class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_post, only: [:show, :edit, :update, :destroy, :publish, :hide]
  before_action :user_check, only: [:edit, :update, :destroy]

  def index
    @posts = Post.reverse_order(:desc).published.all
    @title = 'Список Публикаций'
  end

  def unpublished
    @posts = Post.reverse_order(:desc).unpublished.all
    @posts = @posts.find_by_user_id(current_user) unless user_admin?
    @title = 'Доступные черновики'
  end

  def publish
    @post.update(published: true)
    redirect_to posts_path
  end

  def hide
    @post.update(published: false)
    redirect_to unpublished_posts_path
  end

  def show
    @comment = Comment.new
    @comments = @post.comments
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def create
    @post = current_user.posts.new(post_params)
      if @post.save
        redirect_to @post, notice: 'Пост успешно создан'
      else
        render :new
      end
  end

  def update
      if @post.update(post_params)
        redirect_to @post, notice: 'Пост успешно обнавлён'
      else
        render :edit
      end
  end

  def destroy
    @post.destroy
    redirect_to posts_path, notice: 'Пост успешно удалён'
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :body, :published, category_ids: [])
    end

  def user_check
    unless current_user.author_of?(@post) || current_user.admin?
      redirect_to posts_path, alert: 'У вас нет прав на выполнение этого действия'
    end
  end
end
