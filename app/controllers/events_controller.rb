class EventsController < ApplicationController
  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.user_id = current_user.id
    @event.save
    redirect_to user_path(current_user)
  end

  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
  end

  def destroy
    event = Event.find(params[:id])
    event.destroy
    redirect_to user_path(current_user)
  end


  private

  def event_params
    params.require(:event).permit(:name, :introduction, :genre, :start_at, :end_at)
  end

end
