class Movies < ActiveRecord::Migration[8.0]
  def change
    create_table :movies do |t|
      t.string :title, null: false
      t.string :url, null: false
      t.integer :year, null: false
      t.string :poster_url
      t.string :imdb
      t.string :uaserial_id, null: false

      t.timestamps
    end
  end
end
