module Met_Plots_Models

# package code goes here
using Met_Basic_Types 
export Met_Basic_Types
using NetCDF
using PyCall
using PyPlot 
export PyPlot
@pyimport mpl_toolkits.basemap as basemap
@pyimport prettyplotlib as ppl
@pyimport brewer2mpl

include("type/plot_in_area.jl")
include("Regular/plot_in_area.jl")

export zero_to_one_ratio_cmap,sst_only_positive_cmap,sst_only_negative_cmap, sst_cmap, diff_cmap, pp_cmap

export plot_something,plot_test , plot_test1, mapplot_something
export mapplot_cross_compare

function flush_figures( fpath :: String)
  println("$fpath.png")
  savefig("$fpath.png")
  savefig("$fpath.pdf")
  savefig("$fpath.svg")
end
export flush_figures

end # module
