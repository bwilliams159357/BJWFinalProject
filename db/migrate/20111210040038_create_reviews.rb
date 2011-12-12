class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.string :content
      t.integer :user_id
      t.integer :game_id

      t.timestamps
    end
    add_index :reviews, :user_id
    add_index :reviews, :game_id
  end
end
