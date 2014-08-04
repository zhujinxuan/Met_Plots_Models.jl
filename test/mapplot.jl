using PyPlot
using NetCDF

print("Examing mapplot_something in a global map")
plot_problem = AModel_Import(filename = "data/example.nc")
sst = ncread(plot_problem.data_based_on, "sst")
mapplot_something(plot_problem, sst)
savefig("An-Example-of-global-plot.png")

print("Examing mapplot_something in a ENSO area")
ENSO_area= Give_An_ENSO_area(plot_problem)
mapplot_something(ENSO_area, sst)
savefig("An-Example-of-ENSO-plot.png")

