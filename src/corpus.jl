# Copyright 2015 Conrad Scott

immutable Corpus{S <: AbstractString, D <: AbstractVector, I <: Integer, C <: AbstractMatrix}
    v :: Dictionary{S, D}

    # A term-document matrix: A row per term; a column per document; values are document word counts.
    c :: C

    function Corpus(v :: Dictionary{S, D}, c :: AbstractMatrix{I})
        new(v, c)
    end
end

function Corpus(v :: Dictionary, c :: AbstractMatrix)
  Corpus{eltype(v.d), typeof(v.d), eltype(c), typeof(c)}(v, c)
end

function words(c :: Corpus)
  size(c.c, 1)
end

function documents(c :: Corpus)
  size(c.c, 2)
end
