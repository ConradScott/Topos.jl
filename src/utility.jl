function sumbyterm(dtm :: AbstractMatrix)
  sum(dtm, 2)[:]
end

function sumbydocument(dtm :: AbstractMatrix)
  sum(dtm, 1)[:]
end
