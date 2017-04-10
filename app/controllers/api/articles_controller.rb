class Api::ArticlesController < ApplicationController

  def index
    @articles = Article.all
  end

  def show
    redirect_to 'staticpages/root'
    Article.create_articles
  end

  private
  def article_params
    params.require(:article).permit(:categories)
  end

end
