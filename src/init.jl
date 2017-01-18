
import GR
export GR

using Reexport
@reexport using Plots

import Plots:
    GRBackend, Plot, Subplot, Axis, Series, Font, Arrow, EachAnn,
    cycle, left, right, top, bottom, axis_limits, series_list,
    is3d, ispolar, axis_drawing_info, series_annotations_shapes!

function __init__()
    Plots._attr[:gr] = Plots.merge_with_base_supported([
        :annotations,
        :background_color_legend, :background_color_inside, :background_color_outside,
        :foreground_color_legend, :foreground_color_grid, :foreground_color_axis,
        :foreground_color_text, :foreground_color_border,
        :label,
        :seriescolor, :seriesalpha,
        :linecolor, :linestyle, :linewidth, :linealpha,
        :markershape, :markercolor, :markersize, :markeralpha,
        :markerstrokewidth, :markerstrokecolor, :markerstrokealpha,
        :fillrange, :fillcolor, :fillalpha,
        :bins,
        :layout,
        :title, :window_title,
        :guide, :lims, :ticks, :scale, :flip,
        :tickfont, :guidefont, :legendfont,
        :grid, :legend, :colorbar,
        :marker_z, :levels,
        :ribbon, :quiver,
        :orientation,
        :overwrite_figure,
        :polar,
        :aspect_ratio,
        :normalize, :weights,
        :inset_subplots,
        :bar_width,
        :arrow,
    ])
    Plots._seriestype[:gr] = [
        :path, :scatter,
        :heatmap, :pie, :image,
        :contour, :path3d, :scatter3d, :surface, :wireframe,
        :shape
    ]
    Plots._style[:gr] = [:auto, :solid, :dash, :dot, :dashdot, :dashdotdot]
    Plots._marker[:gr] = Plots._allMarkers
    Plots._scale[:gr] = [:identity, :log10]
end

Plots.is_marker_supported(::GRBackend, shape::Shape) = true

function Plots.add_backend_string(::GRBackend)
    """
    Pkg.add("PlotsGR")
    Pkg.build("PlotsGR")
    """
end
