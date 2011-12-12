class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :name
      t.string :release
      t.string :image
      t.float :rating
      t.float :total_ratings
      t.integer :num_ratings

      t.timestamps
    end
  end
end
