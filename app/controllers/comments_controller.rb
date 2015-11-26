class CommentsController < ApplicationController
  before_action :authenticate_user!, except: [ :show]
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_action :user_check, only: [:edit, :update, :destroy]

  def show
  end

  def new
    @comment = Comment.new
  end

  def edit
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.user = current_user

      if @comment.save
        redirect_to @post, notice: 'Комментарий успешно создан'
      else
        render :new
      end
    end

  def update
      if @comment.update(comment_params)
        redirect_to @comment.post, notice: 'Комментарий успешно обновлён'
      else
        render :edit
      end
  end

  def destroy
    @comment.destroy
    redirect_to @comment.post, notice: 'Комментарий успешно удалён'
  end


  private
    def set_comment
      @comment = Comment.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:body, :post_id)
    end

  def user_check
    unless current_user.author_of?(@comment) || current_user.admin?
      redirect_to posts_path, alert: 'У вас нет прав на выполнение этого действия'
    end
  end
end
