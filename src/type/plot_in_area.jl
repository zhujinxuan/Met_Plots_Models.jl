zero_to_one_ratio_colormap = brewer2mpl.get_map("Purples", "sequential", 5)
zero_to_one_ratio_cmap = zero_to_one_ratio_colormap[:get_mpl_colormap]()
sst_only_positive_colormap = brewer2mpl.get_map("Reds","sequential",8)
sst_only_positive_cmap = sst_only_positive_colormap[:get_mpl_colormap]()
sst_only_negative_colormap     = brewer2mpl.get_map("Blues","sequential",8,reverse=true)
sst_only_negative_cmap    = sst_only_negative_colormap[:get_mpl_colormap]();
sst_colormap               = brewer2mpl.get_map("RdBu", "Diverging", 11,reverse = true)
sst_cmap                   = sst_colormap[:get_mpl_colormap]()
sst_diff_cmap               = sst_cmap
diff_colormap               = brewer2mpl.get_map("PRGn", "Diverging",8)
diff_cmap                   = diff_colormap[:get_mpl_colormap]()

pp_colormap     = brewer2mpl.get_map("Blues","sequential",8)
pp_cmap    = pp_colormap[:get_mpl_colormap]();

m = basemap.Basemap(projection="cyl",llcrnrlat=-90,urcrnrlat=90, llcrnrlon=0,urcrnrlon=360,resolution="l")

sst_levels = [-5:5:30] +0.0;
diff_levels = [-1.0:0.2:1.0] ;
sst_diff_levels = [-1.0:0.2:1.0] ;

function plot_something (p:: Any_Area_is_an_Area, sst; colormaps :: ColorMap = sst_cmap , levels = NaN, stratage :: Symbol = :default)
  error("plot something quickly without maps")
end

function mapplot_something(p :: Any_Area_is_an_Area, sst :: Array{Float64}; colormaps :: ColorMap = sst_cmap ,levels = NaN , stratage :: Symbol = :default)
  error("plot something on map")
end
function plot_test ( p :: Any_Area_is_an_Area ,sstname :: ASCIIString = "sst")
  error("plot sst as an test")
end

function plot_test1 ( p :: Any_Area_is_an_Area ,sstname :: ASCIIString = "sst")
  error("plot sst as an test")
end

function mapplot_cross_compare( p:: Any_Area_is_an_Area, sst :: Array{Float64,3}, figure_path :: ASCIIString ; colormaps :: ColorMap = sst_cmap,  levels :: Array{Float64,1} = NaN,sub_years :: Int64 = 140, stratage :: Symbol = :sst)
  error("plot to see whether models are stable ")
end
