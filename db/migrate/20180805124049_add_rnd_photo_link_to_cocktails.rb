class AddRndPhotoLinkToCocktails < ActiveRecord::Migration[5.2]
  def change
    add_column :cocktails, :rnd_photo_link, :text
  end
end
