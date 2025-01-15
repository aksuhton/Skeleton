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
    sequence_length::Int = 3
    batchsize::Int = 2
    dropout_rate::Float32 = 0.0f0
    test_split::Float64 = 0.1
    lr::Float64 = 1e-2
    epochs::Int = 2
    # Only inference options
    inference::Bool = false
    model_path::String = ""
    seed::Union{String, Vector{String}} = ["_", "The", "Julia", "Lux.jl"]
    output_length::Int = 3
    # My options
    N_train = 20
    N_test = 4
end
##
cfg = Config()
##
@unpack n_embed, n_hidden, n_heads, qk_dim, v_dim, n_layers, sequence_length, batchsize, dropout_rate, test_split, lr, epochs, inference, model_path, seed, output_length, N_train, N_test = cfg
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
# @unpack n_vocab, n_embed, sequence_length, n_hidden, n_layers, dropout_rate, n_heads, qk_dim, v_dim = model_config
##
# my_gpt = @compact(;
#     token_embedding=Embedding(n_vocab => n_embed),
#     position_embedding=Embedding(sequence_length => n_embed),
#     drop=Dropout(dropout_rate),
#     blocks=Chain(ntuple(n_layers) do i
#         return gpt_block(; n_embed, n_hidden, qk_dim, v_dim, n_heads, dropout_rate)
#     end...),
#     ln=LayerNorm((n_embed, 1)),
#     output_layer=Dense(n_embed => n_vocab)) do tokens
#     x = drop(token_embedding(tokens) .+ position_embedding(1:size(tokens, 1)))
#     x = blocks(x)
#     @return output_layer(ln(x))
# end
