class CreateIngredients < ActiveRecord::Migration[5.0]
  def change
    create_table :ingredients do |t|
      t.string :ingredient
      t.boolean :done,             default: false
      t.belongs_to :family_recipe, foreign_key: true

      t.timestamps
    end
  end
end
