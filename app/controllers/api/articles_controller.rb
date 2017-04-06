class Api::ArticlesController < ApplicationController

  def index
    @articles = Article.all
  end

  private
  def article_params
    params.require(:article).permit(:categories)
  end

end