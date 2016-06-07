class AddCollegeToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :college, :string
  end
end
