class CocktailsController < ApplicationController
  def index
    @cocktails = Cocktail.all
  end

  def show
    @cocktail = Cocktail.find(params[:id])
  end

  def new
    @cocktail = Cocktail.new
  end

  def create
    @cocktail = Cocktail.new(cocktail_params)
    cocktail_params[:photo].nil? ? @cocktail.photo_true = false : @cocktail.photo_true = true
    if @cocktail.save
      redirect_to cocktail_path(@cocktail)
    else
      render :new
    end
  end

  def destroy
    Cocktail.find(params[:id]).destroy

    redirect_to cocktails_path
  end

  def random

    @cocktails = []
    9.times do
      require "json"
      require 'open-uri'
      url = "https://www.thecocktaildb.com/api/json/v1/1/random.php"
      rand_cocktail_serialized = open(url).read
      rand_cocktail = JSON.parse(rand_cocktail_serialized)["drinks"]


      name = rand_cocktail.first["strDrink"]

      photo = rand_cocktail.first["strDrinkThumb"]

      ingredients_id = []
      rand_cocktail.first.select { |k,_| k.include? "strIngredient" }.each do |par|
        unless par[1].nil?
          unless par[1].empty?
            if Ingredient.find_by_name(par[1]).nil?
              ingredient = Ingredient.create(name: par[1])
            else
              ingredient = Ingredient.find_by_name(par[1])
            end
            ingredients_id << ingredient.id
          end
        end
      end

      descriptions = []
      rand_cocktail.first.select { |k,_| k.include? "strMeasure" }.each do |par|
         unless par[1].nil?
          descriptions << par[1] unless par[1].empty?
         end
      end

      list_len = descriptions.size

      if !Cocktail.find_by_name(name)
        cocktail = Cocktail.new(name: name, rnd_photo_link: photo, photo_true: false)
        cocktail.save

        (0...list_len).each do |i|
          dose = Dose.new(ingredient_id: ingredients_id[i], cocktail_id: cocktail.id, description: descriptions[i])
          dose.save
        end

      else
        cocktail = Cocktail.find_by_name(name)
      end

      @cocktails << cocktail
    end
  end

  def random_show
    @cocktail = Cocktail.find(params[:id])
  end

  private

  def cocktail_params
    params.require(:cocktail).permit(:name, :photo, :photo_cache)
  end
end
