function simple_map(pa :: AnArea_Regular)

  slat = pa.lat[1] 
  nlat = pa.lat[end] 

  llon = pa.lon[1] 
  rlon = pa.lon[end] 
  m = basemap.Basemap(projection="cyl",
  llcrnrlat=slat ,urcrnrlat=nlat ,llcrnrlon=llon,urcrnrlon=rlon,resolution="c")
end
export simple_map

function canvas ( pa :: AnArea_Regular,xarr :: Array{Float64,2})
  return (pa.plon, pa.plat, xarr)
end

function canvas ( pa :: AnArea_Regular,xarr :: Array{Bool,2})
  return (pa.plon[xarr], pa.plat[xarr])
end

function canvas ( pa :: AnArea_Regular,xarr :: BitArray{2})
  return (pa.plon[xarr], pa.plat[xarr])
end
export canvas
