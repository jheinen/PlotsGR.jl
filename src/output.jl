
const _gr_mimeformats = Dict(
    "application/pdf"         => "pdf",
    "image/png"               => "png",
    "application/postscript"  => "ps",
    "image/svg+xml"           => "svg",
)

const _gr_wstype_default = @static if is_linux()
    "x11"
    # "cairox11"
elseif is_apple()
    "quartz"
else
    "use_default"
end

const _gr_wstype = Ref(get(ENV, "GKS_WSTYPE", _gr_wstype_default))
gr_set_output(wstype::String) = (_gr_wstype[] = wstype)

for (mime, fmt) in _gr_mimeformats
    @eval function Plots._show(io::IO, ::MIME{Symbol($mime)}, plt::Plot{GRBackend})
        GR.emergencyclosegks()
        filepath = tempname() * "." * $fmt
        ENV["GKS_WSTYPE"] = $fmt
        ENV["GKS_FILEPATH"] = filepath
        gr_display(plt)
        GR.emergencyclosegks()
        write(io, readstring(filepath))
        rm(filepath)
    end
end

function Plots._display(plt::Plot{GRBackend})
    if plt[:display_type] == :inline
        GR.emergencyclosegks()
        filepath = tempname() * ".pdf"
        ENV["GKS_WSTYPE"] = "pdf"
        ENV["GKS_FILEPATH"] = filepath
        gr_display(plt)
        GR.emergencyclosegks()
        content = string("\033]1337;File=inline=1;preserveAspectRatio=0:", base64encode(open(readbytes, filepath)), "\a")
        println(content)
        rm(filepath)
    else
        ENV["GKS_DOUBLE_BUF"] = true
        if _gr_wstype[] != "use_default"
            ENV["GKS_WSTYPE"] = _gr_wstype[]
        end
        gr_display(plt)
    end
end

Plots.closeall(::GRBackend) = GR.emergencyclosegks()
