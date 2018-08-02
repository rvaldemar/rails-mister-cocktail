class Dose < ApplicationRecord
  belongs_to :ingredient
  belongs_to :cocktail

  validates :ingredient, uniqueness: { scope: :cocktail, message: "Too many ingredients in your cocktail! Are you an alcoholic? Please refer to; http://alcoholawareness.org/" }

end
