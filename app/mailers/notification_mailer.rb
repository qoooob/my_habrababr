class NotificationMailer < ApplicationMailer

  def comment_notification(user, post, comment)
    @user = user
    @post = post
    @comment = comment

    mail(to: user.email, subject: 'Новый комментарий к Вашему посту')
  end

  def moderate_notification(post)
    @post = post

    mail(to: post.user.email, subject: 'Статус вашего поста изменен')
  end
end
