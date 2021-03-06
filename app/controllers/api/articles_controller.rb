class Api::ArticlesController < ApplicationController

  def index
    @articles = Article.all
  end

  def show
    render :show
    Article.create_articles
  end

  private
  def article_params
    params.require(:article).permit(:categories)
  end

end
