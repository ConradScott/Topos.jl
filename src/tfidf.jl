# Given a corpus, return a document-term matrix of tf-idf values.
function tfidf(c :: Corpus)
  # D = The number of documents.
  D = documents(c)

  # tf(d, w) = The number of occurrences of term w in document d.
  tf = c.c

  # df(w) = number of documents in which term w occurs
  df = sum(tf .≠ 0, 1)[:]

  # idf(w) = inverse document frequency of term w
  idf = log(D) .- log(df)

  # tfidf(d, w) = tf(d, w) * idf(w)
  tfidf = (tf' .* idf)'

  return tfidf
end
