class AddPostIdToComments < ActiveRecord::Migration
  def change
    add_belongs_to :posts, :comment, index: true
  end
end
