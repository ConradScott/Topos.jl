module Topos

using DataFrames

import Base.length

immutable Dictionary{S <: AbstractString, D <: AbstractVector}
  d :: D

  function Dictionary(d :: AbstractVector{S})
    new(d)
  end
end

function Dictionary(d :: AbstractVector)
  Dictionary{eltype(d), typeof(d)}(d)
end

function length(d :: Dictionary)
  length(d.d)
end

immutable Corpus{S <: AbstractString, D <: AbstractVector, I <: Integer, C <: AbstractMatrix}
    v :: Dictionary{S, D}

    # A row per document; a column per word; values are document word counts.
    c :: C

    function Corpus(v :: Dictionary{S, D}, c :: AbstractMatrix{I})
        new(v, c)
    end
end

function Corpus(v :: Dictionary, c :: AbstractMatrix)
  Corpus{eltype(v.d), typeof(v.d), eltype(c), typeof(c)}(v, c)
end

include("vocab.jl")
include("uci-bag-of-words.jl")

end
