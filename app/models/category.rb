class Category < ActiveRecord::Base
  has_many :categories_posts, dependent: :destroy
  has_many :posts, through: :categories_posts

  validates :name, presence: true, uniqueness: true
end