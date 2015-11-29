class Admin::PostsController < Admin::BaseController

  before_action :set_post, only: [:reject, :approve]

  def index
    @posts = Post.unpublished.all
    @title = 'Доступные черновики на публикацию'
  end

  def reject
    @post.update(approved: false)
    #NotificationMailer.post_rejected_notification(@post).deliver_now
    redirect_to index_admin_posts_url, notice: 'Администратор не принял Ваш пост'
  end

  def approve
    @post.update(approved: true)
    #NotificationMailer.post_approved_notification(@post).deliver_now
    redirect_to index_admin_posts_url, notice: 'Администратор разрешил к публикации Ваш пост'
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end
end