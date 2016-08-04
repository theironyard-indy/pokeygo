class SightingsController < ApplicationController

  before_action :authenticate_trainer!, only: [:new, :create, :edit, :update, :destroy]

  def index
    @sightings = Sighting.order(created_at: :desc).limit(20)
    marker_sightings = Sighting.all
    respond_to do |format|
      format.json {
        @markers = sightings_markers(marker_sightings)
        render json: @markers
      }
      format.html {}
    end
  end

  def new
    @sighting = Sighting.new
  end

  def create
    @sighting = current_trainer.sightings.new(sighting_params)

    if @sighting.save
      flash[:success] = "Gotta catch 'em all!"
      redirect_to :root
    else
      flash[:warning] = "Oops. Looks like that sighting escaped the pokeball. Review the errors below and try again."
      render :new
    end
  end

  def edit
    @sighting = current_trainer.sightings.find(params[:id])
  end

  def update
    @sighting = current_trainer.sightings.find(params[:id])

    if @sighting.update(sighting_params)
      flash[:success] = "All updated!"
      redirect_to :root
    else
      flash[:warning] = "Oops. Looks like that sighting escaped the pokeball. Review the errors below and try again."
      render :edit
    end
  end

  def destroy
    @sighting = current_trainer.sightings.find(params[:id])
    @sighting.destroy
    flash[:success] = "A sighting no more. :("
    redirect_to :root
  end

  private

  def sighting_params
    params.require(:sighting).permit(:body, :category_id, :full_address, :lat, :lng)
  end

  def sightings_markers(sightings)
    Gmaps4rails.build_markers(sightings) do |sighting, marker|
      marker.lat sighting.lat
      marker.lng sighting.lng
      marker.infowindow "<img width='50' height='50' src='#{ActionController::Base.helpers.asset_url(sighting.map_icon, type: :image)}' /><p>#{sighting.body}</p>"
    end
  end

end
