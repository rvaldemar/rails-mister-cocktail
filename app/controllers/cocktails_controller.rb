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

  end

  private

  def cocktail_params
    params.require(:cocktail).permit(:name, :photo, :photo_cache)
  end
end
