class Admin::TripsController < Admin::BaseController

  def show
  end

  def new
    @trip = Trip.new
  end

  def create
    params["trip"]["start_date"] = Time.strptime(params["trip"]["start_date"], "%m/%d/%Y %H:%M")
    params["trip"]["end_date"] = Time.strptime(params["trip"]["end_date"], "%m/%d/%Y %H:%M")
    trip = Trip.new(trip_params)
    if trip.save
      flash[:success] = "You have created a new trip!"
    end
    redirect_to trip_path(trip)
  end

  def edit
    @trip = Trip.find(params[:id])
  end

  def update
    trip = Trip.find(params[:id])
    params["trip"]["start_date"] = Time.strptime(params["trip"]["start_date"], "%m/%d/%Y") if params["trip"]["start_date"]
    params["trip"]["end_date"] = Time.strptime(params["trip"]["end_date"], "%m/%d/%Y") if params["trip"]["end_date"]
    if trip.update(trip_params)
      flash[:success] = "You have updated Trip-#{Trip.find(params[:id]).id}!"
    end
    redirect_to trip_path(trip)
  end

  def destroy
    trip = Trip.find(params[:id])
      if trip.destroy
        flash[:success] = "Trip-#{trip.id} has been deleted!"
      end

    redirect_to trips_path
  end

  private

  def trip_params
    params.require(:trip).permit(:duration, :start_date, :end_date, :bike_id, :subscription_type, :start_station_id, :end_station_id, :zip_code)
  end
end
