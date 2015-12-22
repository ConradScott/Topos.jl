# Copyright 2015 Conrad Scott

function readUCIBagOfWords(filename :: AbstractString, vocab :: Dictionary)
  header = readtable( filename,
                      header = false, separator = ' ',
                      skipblanks = false, ignorepadding = false,
                      names = [:Header], eltypes = [Int64],
                      nrows = 3 )

  (lines, columns) = size(header)

  if lines != 3
    error("Expected three rows in the header of the UCI bag-of-words file; \"$filename\" only has $lines line(s)")
  end

  if columns != 1
    error("The header of the UCI bag-of-words file should only have one column of data; \"$filename\" has $columns columns")
  end

  (documents, words, triples) = header[:Header]

  if documents < 0
    error("The number of documents in the header should be non-negative; \"$filename\" specifies $documents document(s)")
  end

  if words < 0
    error("The number of words in the header should be non-negative; \"$filename\" specifies $words words(s)")
  end

  if words > length(vocab)
    error("The number of words in the header should not exceed the provided vocabulary; \"$filename\" specifies $words words(s) but the dictionary only has $(length(vocab)) words")
  end

  if triples < 0
    error("The number of triples in the header should be non-negative; \"$filename\" specifies $triples triple(s)")
  end

  body = readtable( filename,
                    header = false, separator = ' ',
                    skipblanks = false, ignorepadding = false,
                    names = [:DocId, :WordId, :Count],
                    eltypes = [Int64, Int64, Int64],
                    skipstart = 3 )

  (lines, columns) = size(body)

  if lines != triples
    error("The header claims that the file contains $triples lines in the body; \"$filename\" has $lines line(s)")
  end

  if columns != 3
    error("Expected three columns in the body of the UCI bag-of-words format file; \"$filename\" has $columns column(s)")
  end

  if minimum(body[:DocId]) < 1
    error("The document ids should be positive integers; \"$filename\" contains a document id of $(minimum(body[:DocId]))")
  end

  if maximum(body[:DocId]) > documents
    error("The header claims that there are $documents documents; \"$filename\" contains a document id of $(maximum(body[:DocId]))")
  end

  if minimum(body[:WordId]) < 1
    error("The word ids should be positive integers; \"$filename\" contains a word id of $(minimum(body[:WordId]))")
  end

  if maximum(body[:WordId]) > words
    error("The header claims that there are $words words; \"$filename\" contains a word id of $(maximum(body[:WordId]))")
  end

  if minimum(body[:Count]) < 0
    error("The document word counts should be non-negative integers; \"$filename\" contains a count of $(minimum(body[:Count])))")
  end

  if maximum(body[:WordId]) > length(vocab)
    error("The word ids should be in the provided dictionary; \"$filename\" contains a word id of $(maximum(body[:WordId])) but the dictionary only has $(length(vocab)) words")
  end

  return Corpus(vocab, sparse(body[:DocId], body[:WordId], body[:Count], documents, words))
end
