include("levels.jl")
function AnArea_Import( p :: AnArea_Regular; plon :: Array{Float64,2} = p.plat, plat :: Array{Float64,2} = p.plon)
  p1 = copy(p) ;
  p1.plat = plat ;
  p1.plon = plon;
  p1.lat = mean(plat,1)
  p1.lon = mean(plat,2)
  p1
end

function plot_map(p :: AnArea_Regular; whether_plot_map :: Bool = true, pre_plot :: Symbol = :default)
  clf();
  if (haskey( p.configs,"wesn"))
    (llon, rlon, slat, nlat ) = p.configs["wesn"]
    m = basemap.Basemap(projection="cyl",llcrnrlat=slat ,urcrnrlat=nlat , llcrnrlon=llon,urcrnrlon=rlon,resolution="l")
  else
    m = basemap.Basemap(projection="cyl",llcrnrlat=-90,urcrnrlat=90, llcrnrlon=0,urcrnrlon=360,resolution="l")
  end
  if (whether_plot_map)
    if (pre_plot == :default)
      m[:drawmapboundary](fill_color="#4771a5")
      m[:fillcontinents](color="#555555")
      m[:drawparallels](-90:10.0:90,labels=[1,0,0,0],fontsize=10);
      m[:drawmeridians](0:30:360.0,labels=[0,0,0,1],fontsize=10);
    elseif (pre_plot == :boundary)
      m[:drawcoastlines]()
      #= m[:drawmapboundary](fill_color="#4771a5") =#
      m[:drawparallels](-90:10.0:90,labels=[1,0,0,0],fontsize=10);
      m[:drawmeridians](0:30:360.0,labels=[0,0,0,1],fontsize=10);
    else
      m[:drawparallels](-90:10.0:90,labels=[1,0,0,0],fontsize=10);
      m[:drawmeridians](0:30:360.0,labels=[0,0,0,1],fontsize=10);
    end
  end
  return m 
end


function plot_something( p :: AnArea_Regular,sst :: Array{Float64} ;colormap:: ColorMap = sst_cmap, levels :: Array{Float64,1} = [NaN], stratagy :: Symbol  = :default)
  plevels = read_stratagy(p,sst,levels = levels , stratagy = stratagy)
  print(plevels)
  clf();
  plat = p.plat
  plon = p.plon
  set_cmap(colormap)
  if (length(size(sst)) > 2) 
    sst = squeeze(sst,3)
  end
  m = plot_map(p)
  sstp = Selected_within(p,sst)
  m[:contourf](plon,plat,sstp,levels=plevels)
  m[:colorbar]()
end

function mapplot_something(p :: AnArea_Regular, sst :: Array{Float64}; colormap :: ColorMap = sst_cmap, levels :: Array{Float64,1} = min_max_levels(sst),stratagy :: Symbol = :default, whether_tight :: Bool = true)
  plevels = read_stratagy(p,sst,levels = levels , stratagy = stratagy)
  clf();
  plat = p.plat
  plon = p.plon
  set_cmap(colormap)
  m = plot_map(p)
  if(length(size(sst)) > 2)
    sst = squeeze(sst,3)
  end
  sstp = Selected_within(p,sst)
  m[:contourf](plon,plat,sstp,levels = plevels,spacing ="proportional",extend="both")
  m[:colorbar]()
  if (whether_tight)
    tight_layout()
  end
end

function scatter_something(p:: AnArea_Regular, mask :: BitArray{2}; whether_clf :: Bool = true, pre_plot :: Symbol = :boundary)
  if (whether_clf)
    clf();
  end
  m = plot_map(p,pre_plot = pre_plot)
  m[:scatter](p.plon[mask],p.plat[mask])
  tight_layout()
end

function scatter_pretty(p:: AnArea_Regular, mask :: BitArray{3}; whether_clf :: Bool = true)
  if (whether_clf)
    clf();
  end
  (fig, ax) = ppl.subplots(1)
  for i = 1:size(mask,3)
    ppl.scatter(ax,p.plon[squeeze(mask[:,:,i],3)], p.plat[squeeze(mask[:,:,i],3)],label="$i" );
  end
  ppl.legend(ax)
  (fig,ax)
end

function plot_test ( p :: AnArea_Regular , sstname :: ASCIIString = "sst")
  clf();
  sst = ncread (p.data_based_on,sstname)
  ncclose(p.data_based_on)
  plot_something(p, squeeze(mean(sst,3),3))
end

function plot_test1 ( p :: AnArea_Regular , sstname :: ASCIIString = "sst")
  clf();
  sst = ncread (p.data_based_on,sstname)
  ncclose(p.data_based_on)
  mapplot_something(p, squeeze(mean(sst,3),3),sst_cmap,sst_levels)
end

function mapplot_cross_compare( p:: AnArea_Regular, sst :: Array{Float64,3}, figure_path :: ASCIIString ; colormap :: ColorMap = sst_cmap,  levels :: Array{Float64,1} = sst_levels,sub_years :: Int64 = 140, stratagy :: Symbol = :default )
  plon = p.plon
  plat = p.plat 
  n_exp = int(size(sst,3)/sub_years)
  psst = sst[:,:,1:sub_years*n_exp]
  psst = reshape(psst,(size(sst,1),size(sst,2),sub_years, n_exp))
  pmsst = squeeze(mean(psst,3),3)
  pvsst = squeeze(var(psst,3),3)
  pvsst_all = mean(pvsst,3)
  for i1 = 1:n_exp
    mapplot_something(p, pmsst[:,:,i1];colormap = colormap,levels = levels, stratagy = stratagy)
    filepath = string(figure_path,"mean",i1)
    savefig("$filepath.svg")
    savefig("$filepath.svgz")
    savefig("$filepath.eps")
    savefig("$filepath.png")
    for i2 = (i1+1):n_exp
      mapplot_something(p,pmsst[:,:,i2] - pmsst[:,:,i1];colormap = colormap, levels = [-1.5:0.5:1.5], stratagy = stratagy)
      filepath = string(figure_path,"diff",i1,"-",i2)
      savefig("$filepath.svg")
      savefig("$filepath.svgz")
      savefig("$filepath.eps")
      savefig("$filepath.png")
    end
  end
end
export plot_map
export scatter_something
export scatter_pretty
