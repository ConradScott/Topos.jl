function readVocab(filename :: AbstractString)
  df = readtable( filename,
                  header = false, separator = ' ',
                  skipblanks = false, ignorepadding = false,
                  names = [:Terms], eltypes = [UTF8String] )

  (lines, columns) = size(df)

  if columns != 1
    error("Vocabulary file should have a single word per line; \"$filename\" has $columns columns")
  end

  return Dictionary(df[:Terms])
end
