
function read_stratagy( p :: AnArea_Regular,sst :: Array{Float64} ;colormap:: ColorMap = sst_cmap, levels :: Array{Float64,1} = [NaN], stratagy :: Symbol  = :default, filter :: Function x->x)
  if (stratagy == :default)
    if  ( length(find(isnan(levels))) > 0) 
      plevels = sort_levels(sst, filter = filter) 
    else
      plevels = levels
    end
  elseif (stratagy == :balance)
    plevels = balance_levels(sst)
  elseif(stratagy == :sst )
      plevels == sst_levels
  end
  return plevels 
end

function sort_levels( sst; nlevel :: Int64 = 7, filter :: Function x->x)
  sst1 = sort(sst[!isnan(sst)])
  sst1 = filter(sst1)
  n = length(sst1)
  return sst1[(int(floor([0:nlevel]/nlevel) * (n-1) + 1 ))]
end

function extend_levels( levels , sst; whether_extend_to_max :: Bool = true, whether_extend_to_min :: Bool = true,
  whether_subs_max :: Bool = false, whether_subs_min :: Bool = false )
  if (whether_subs_max)
    plevels[end] = maximum(sst)
  elseif (whether_extend_to_max)
    plevels = [plevels; maximum(sst)]
  end
  
  if (whether_subs_min)
    plevels [1] = minimum(sst)
  elseif (whether_extend_to_min)
    plevels = [minimum(sst) ; plevels]
  end
end

function min_max_levels(sst :: Array, nlevel :: Int64 = 8)
  m1 = maximum(sst );
  m2 = minimum(sst );
  return [m2 : (m1-m2)/nlevel : m1]
end
  
function balance_levels( sst :: Array ,nlevel :: Int64 =7)
  m1 = maximum(sst );
  m2 = minimum(sst );
  m = ( -m2 > m1 ) ? (-m2) : m1
  return [-m:(2*m/nlevel):m]
end

export balance_levels 

