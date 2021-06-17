class AddIdToRatings < ActiveRecord::Migration[6.1]
  def change
    add_reference :ratings, :artist, null: false
  end
end
