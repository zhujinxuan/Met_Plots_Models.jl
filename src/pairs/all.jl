function simple_map(pa :: AnArea_Regular)

  slat = minimum(pa.lat )
  nlat = maximum(pa.lat)

  
  llon = minimum(pa.lon )
  rlon = maximum(pa.lon )
  if (sum( (pa.lon .> 355) & (pa.lon .< 5)) > 0)
    if (sum( (pa.lon .< 185) & (pa.lon .> 175) ) == 0)
      (llon, rlon) = (rlon, llon)
    end
  end
  m = basemap.Basemap(projection="cyl",
  llcrnrlat=slat ,urcrnrlat=nlat ,llcrnrlon=llon,urcrnrlon=rlon,resolution="c")
end
export simple_map

function DrawMap(m; NoLands :: Bool = false)
  if ( NoLands) 
    m[:drawcoastlines](color="#555555")
  else
    m[:fillcontinents](color="#555555")
  end
  m[:drawmeridians](0:30:360.0,labels=[0,0,0,1],fontsize=10);
  m[:drawparallels](-90:10.0:90,labels=[1,0,0,0],fontsize=10);
end
export DrawMap

function lonrotate(plon :: Array{Float64,2}, rr)
  if ((plon[1,1] > 180) & (plon[end,1] < 180))
    lon = mean(plon ,2)
    return [rr[lon .<= 180,:] ; rr[lon .> 180,:]]
  else 
    return rr
  end
end

function canvas( pa :: AnArea_Regular,xarr :: Array{Float64,2})
  return map(x->lonrotate(pa.plon,x),(pa.plon, pa.plat, xarr))
end

function canvas( pa :: AnArea_Regular,xarr :: Array{Bool,2})
  (plon,plat,xx) = map( x-> lonrotate(plon,x), (pa.plon, pa.plat, xarr))
  return map(plon[xx], plat[xx])
end

function canvas( pa :: AnArea_Regular,xarr :: BitArray{2})
  (plon,plat,xx) = map( x-> lonrotate(plon,x), (pa.plon, pa.plat, xarr))
  return map(plon[xx], plat[xx])
end
function canvas(x :: Array{Float64,1}, y :: Array{Float64,1},  xarr :: Array{Float64,2})
  (px, py) = begin
    p1 = x .+ zeros(y')
    p2 = y .+ zeros(x')
    (p1, p2')
  end
  return (px, py,xarr)
end

function canvas(x :: Array{Float64,1}, y :: Array{Float64,1},  xarr :: Array{Float64})
  xarr1 = squeeze(xarr, tuple(findin(size(xarr),1)...))
  @assert ( ndims(xarr1) == 2)
  return canvas(x, y, xarr1)
end
export canvas

include("levels.jl")
