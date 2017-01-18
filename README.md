# PlotsGR

Provides a [GR](https://github.com/jheinen/GR.jl) backend for [Plots](https://github.com/JuliaPlots/Plots.jl).  This is normally not included directly, but rather by initializing through Plots.

Install:

```julia
Pkg.add("PlotsGR")
```

Use:

```julia
using Plots
gr()
plot(sin)
```

See the [Plots documentation](https://juliaplots.github.io/) for more information.
