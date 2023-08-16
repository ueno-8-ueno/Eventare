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

  def edit
    @event = Event.find(params[:id])
  end

  def update
     event = Event.find(params[:id])

     if event.user != current_user
      redirect_to user_path(current_user.id)
      return
    end

    if event.update(event_params)
      flash[:notice] = "編集内容がが反映されました"
      redirect_to event_path(event.id)
    else
      render :edit
    end
  end


  private

  def event_params
    params.require(:event).permit(:name, :introduction, :genre, :start_at, :end_at)
  end

end
