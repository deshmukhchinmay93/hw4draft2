class PlacesController < ApplicationController
  before_action :require_login
  
  def index
    @places = Place.where(user_id: @current_user.id)
  end
  
  def show
    @place = Place.find(params[:id])
    @entries = @place.entries.where(user_id: @current_user.id)
  end
  
  def new
    @place = Place.new
  end
  
  def create
    @place = Place.new(place_params)
    @place.user_id = @current_user.id
    if @place.save
      redirect_to places_path
    else
      render :new
    end
  end
  
  private
  
  def place_params
    params.require(:place).permit(:name)
  end
end
