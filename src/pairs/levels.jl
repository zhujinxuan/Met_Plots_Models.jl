abstract LevelMethods

type CenterLevels <: LevelMethods
  nlevels :: Int64
  rangeCalculator :: Function
end

function CenterLevels(; nlevels :: Int64 = 5, center_by :: Function = x-> mean(x))
  rangeCalculator = function ( x :: Array{Float64})
    center = center_by(x)
    r1 = 3*std(x)
    return (center - r1, center + r1)
  end
  return CenterLevels(nlevels, rangeCalculator)
end
export CenterLevels

type PDFlevels <: LevelMethods
  nlevels :: Int64 
  low_cutoff :: Float64
  high_cutoff :: Float64
end

function PDFlevels(; nlevels :: Int64 = 5, low_cutoff :: Float64 = 0.15)
  return PDFlevels( nlevels, low_cutoff, 1-low_cutoff)
end

function levels( xarr :: Array{Float64} , m :: PDFlevels)
  x1 = sort(xarr[:])
  lx = length(xarr)
  low = x1[floor(Int64,m.low_cutoff * lx)]
  high = x1[floor(Int64,m.high_cutoff * lx)]
  rr = collect( low:(high-low)/(m.nlevels):high )
  return ((:levels, rr), (:extend, "both"))
end


function levels( xarr :: Array{Float64} , m :: CenterLevels)
  (low, high) = m.rangeCalculator(xarr)
  rr = collect( low:(high-low)/(m.nlevels):high )
  return ((:levels, rr), (:extend, "both"))
end




export levels
export PDFlevels
export CenterLevels
