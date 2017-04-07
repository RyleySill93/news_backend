require 'mechanize'
require 'json'

class Article < ApplicationRecord
  validates :url, :smmry, :title, :category, :age, :img_url, presence: true

  def self.create_articles
    articles = Article.fetch_articles
    articles.shuffle.take(15).each do |article|
      smmry = Article.create_smmry(article['url'])
      Article.create(url: article['url'],
                     smmry: smmry[1..-1],
                     title: article['title'],
                     category: article['category'],
                     age: article['publishedAt'],
                     img_url: article['urlToImage'])
    end
  end

  def self.fetch_articles
    sources = ['techcrunch', 'the-economist', 'espn', 'entertainment-weekly', 'associated-press']
    all_articles = []
    sources.each do |src|
      response = Mechanize.new.get("https://newsapi.org/v1/articles?source=#{src}&apiKey=745723fdc5784cbe8a09c975af39d28e")
      articles = JSON.parse(response.body)['articles']
      articles = Article.tag_articles(src, articles)
      all_articles.concat(articles)
    end
    all_articles
  end

  def self.create_smmry(url)
    response = Mechanize.new.get("http://api.smmry.com/?SM_API_KEY=2CA94C7AE9&SM_LENGTH=3&SM_URL=#{url}")

    JSON.parse(response.body)['sm_api_content']
  end

  def self.tag_articles(src, articles)
    category = nil
    case src
    when 'techcrunch'
      category = 'Tech'
    when 'the-economist'
      category = 'Business'
    when 'espn'
      category = 'Sports'
    when 'entertainment-weekly'
      category = 'Entertainment'
    when 'associated-press'
      category = 'Politics'
    else
      category = ""
    end

    articles.each do |article|
      article['category'] = category
    end
    articles
  end

end
