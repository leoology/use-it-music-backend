class CreateArtists < ActiveRecord::Migration[6.1]
  def change
    create_table :artists do |t|
      t.string :name
      t.string :genres
      t.string :image_url
      t.integer :popularity

      t.timestamps
    end
  end
end
