class Post < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  has_many :categories_posts, dependent: :destroy
  has_many :categories, through: :categories_posts
  has_many :tags_posts, dependent: :destroy
  has_many :tags, through: :tags_posts
  belongs_to :user

  has_many :subscriptions
  has_many :subscribers, source: :user, through: :subscriptions

  validates :title, :body, presence: true

  scope :reverse_order, ->(order) {order(created_at: order)}
  scope :published, -> {where(published: true)}
  scope :unpublished, -> {where(published: false)}
  scope :moderated, -> { where(moderated: true) }
  scope :unmoderated, -> { where(moderated: false) }

  after_create :subscribe_author
  #after_update :change_moderate_state

  protected

  def subscribe_author
    user.subscribe_to(self)
  end

  def change_moderate_state
    NotificationMailer.moderate_notification(self).deliver_now
  end
end
