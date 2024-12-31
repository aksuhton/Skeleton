##
using DrWatson
@quickactivate :Skeleton
using DataFrames
##
a, b = 2, 3
v = rand(5)
method = "linear"
r, y = fakesim(a, b, v, method)
##
params = @strdict a b v method
##
allparams = Dict(
    "a" => [1, 2]::Vector{Int},         # it is inside vector. It is expanded.
    "b" => [3, 4]::Vector{Int},         # same
    "v" => [rand(1:2, 2)]::Vector{Vector{Int}}, # single element inside vector; no expansion
    "method" => "linear"::String  # not in vector = not expanded, even if naturally iterable
)

dicts = dict_list(allparams)
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
