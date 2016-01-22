module Met_Plots_Models

# package code goes here
using Met_Basic_Types 
using NetCDF
using PyCall
using PyPlot 
export PyPlot
@pyimport mpl_toolkits.basemap as basemap
@pyimport prettyplotlib as ppl
@pyimport brewer2mpl

include("colormaps/cmaps.jl")

export zero_to_one_ratio_cmap;
export purple_cmap, rev_purple_cmap
export sst_only_positive_cmap;
export sst_only_negative_cmap, sst_cmap, diff_cmap, pp_cmap;

include("pairs/all.jl")

#= export mapplot_cross_compare =#

function flush_figures(fpath :: AbstractString)
  println("$fpath.png")
  savefig("$fpath.png")
  savefig("$fpath.pdf")
  savefig("$fpath.svg")
end
export flush_figures


end # module
