@articles.each do |article|
  json.set! article.id do
    json.partial! 'article', article: article
  end
end
