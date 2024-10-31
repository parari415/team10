class CreateRecipes < ActiveRecord::Migration[7.1]
  def change
    create_table :recipes do |t|
      t.string :title
      t.string :genre
      t.text :ingredients
      t.text :instructions
      t.integer :calories
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
