class Api::ArticlesController < ApplicationController

  def index
    @articles = Article.all
  end

  def show
    Article.create_articles
    redirect_to 'staticpages/root'
  end

  private
  def article_params
    params.require(:article).permit(:categories)
  end

end
