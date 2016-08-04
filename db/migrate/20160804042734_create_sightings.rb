class CreateSightings < ActiveRecord::Migration[5.0]
  def change
    create_table :sightings do |t|
      t.float :lat
      t.float :lng
      t.string :full_address
      t.text :body
      t.references :trainer, foreign_key: true
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end
