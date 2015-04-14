
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
