class RemoveUserIdFromLinks < ActiveRecord::Migration
  def change
    remove_column :links, :user_id, :integer
    remove_column :links, :category_id, :integer
  end
end
