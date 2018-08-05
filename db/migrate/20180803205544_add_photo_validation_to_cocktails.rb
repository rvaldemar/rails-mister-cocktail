class AddPhotoValidationToCocktails < ActiveRecord::Migration[5.2]
  def change
    add_column :cocktails, :photo_true, :boolean
  end
end
