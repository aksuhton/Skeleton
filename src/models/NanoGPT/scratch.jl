##
using DrWatson
##
Base.@kwdef mutable struct Config
    n_embed::Int = 4
    n_hidden::Int = 8
    n_heads::Int = 2
    qk_dim::Int = 4
    v_dim::Int = 4
    n_layers::Int = 2
    sequence_length::Int = 2
    batchsize::Int = 2
    dropout_rate::Float32 = 0.0f0
    test_split::Float64 = 0.1
    lr::Float64 = 1e-2
    epochs::Int = 2
    # Only inference options
    inference::Bool = false
    model_path::String = ""
    seed::Union{String, Vector{String}} = ["_", "The", "Julia", "Lux.jl"]
    output_length::Int = 2
    # My options
    N_train = 10
    N_test = 2
end
##
cfg = Config()
##
@unpack n_embed, n_hidden, n_heads, qk_dim, v_dim, n_layers, sequence_length, batchsize, dropout_rate, test_split, lr, epochs, inference, model_path, seed, output_length = cfg
##
function main(cfg::Config)
    cfg_fieldnames = fieldnames(typeof(cfg))
    cfg_nt = NamedTuple{cfg_fieldnames}(getfield.(Ref(cfg), cfg_fieldnames))
    main(; cfg_nt...)
end
##
function get_nanogpt_data(N_train::Int, N_test::Int; sequence_length, test_split)
    alphabet, trainX, trainY, testX, testY = get_nanogpt_data(; sequence_length, test_split)
    return alphabet, trainX[:, 1:N_train], trainY[:, :, 1:N_train],
    testX[:, 1:N_test], testY[:, :, 1:N_test]
end
##
