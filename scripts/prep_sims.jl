##
using DrWatson
@quickactivate "Skeleton"
using DataFrames

# Here you may include files from the source directory
include(srcdir("dummy_src_file.jl"))
##
a, b = 2, 3
v = rand(5)
method = "linear"
r, y = fakesim(a, b, v, method)
##
params = @strdict a b v method
##
allparams = Dict(
    "a" => [1, 2],         # it is inside vector. It is expanded.
    "b" => [3, 4],         # same
    "v" => [rand(1:2, 2)], # single element inside vector; no expansion
    "method" => "linear",  # not in vector = not expanded, even if naturally iterable
)

dicts = dict_list(allparams)
##
for (i, d) in enumerate(dicts)
    f = makesim(d)
    wsave(datadir("simulations", "sim_$(i).jld2"), f)
end
##
savename(params)
##
savename(dicts[1], "jld2")
##
for (i, d) in enumerate(dicts)
    f = makesim(d)
    wsave(datadir("simulations", savename(d, "jld2")), f)
end

readdir(datadir("simulations"))
##
for (i, d) in enumerate(dicts)
    f = makesim(d)
    @tagsave(datadir("simulations", savename(d, "jld2")), f)
end
##
firstsim = readdir(datadir("simulations"))[1]

wload(datadir("simulations", firstsim))
##
df = collect_results(datadir("simulations"))
##
analysis = 42

safesave(datadir("ana", "linear.jld2"), @strdict analysis)
