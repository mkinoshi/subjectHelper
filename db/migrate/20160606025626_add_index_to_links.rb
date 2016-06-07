class AddIndexToLinks < ActiveRecord::Migration
  def change
  	add_column :links, :user_id, :integer
  	add_column :links, :category_id, :integer
  	add_index :links, [:user_id, :category_id], :unique => false
  end
end
