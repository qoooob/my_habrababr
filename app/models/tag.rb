class Tag < ActiveRecord::Base
  has_many :tags_posts, dependent: :destroy
  has_many :posts, through: :tags_posts

  validates :name, presence: true
end
