# Copyright 2015 Conrad Scott

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
