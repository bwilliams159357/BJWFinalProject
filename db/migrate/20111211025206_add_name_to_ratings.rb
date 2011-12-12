class AddNameToRatings < ActiveRecord::Migration
  def change
    add_column :ratings, :name, :string
  end
end
