class CategoriesController < ApplicationController

  def show
    @categories = Category.find(params[:id])
    @posts = @categories.posts
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
