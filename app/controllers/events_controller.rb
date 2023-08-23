class EventsController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.user_id = current_user.id
    if @event.save
      flash[:notice] = "投稿が成功しました"
      redirect_to user_path(current_user)
    else
      render :new
    end
  end

  def index
    @events = Event.page(params[:page]) # ページネーション
  end

  def show
    @event = Event.find(params[:id])
  end

  def destroy
    event = Event.find(params[:id])
    event.destroy
    flash[:notice] = "イベントTODOが削除されました"
    redirect_to user_path(current_user)
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])

    if @event.user != current_user
      redirect_to user_path(current_user.id)
      return
    end

    if @event.update(event_params)
      flash[:notice] = "編集内容が反映されました"
      redirect_to event_path(@event.id)
    else
      render :edit
    end
  end


  private

  # ストロングパラメータ
  def event_params
    params.require(:event).permit(:name, :introduction, :genre, :start_at, :end_at)
  end

  # TODO編集画面へのアクセス制御
  def is_matching_login_user
    user = Event.find(params[:id]).user
    unless user.id == current_user.id
      redirect_to events_path
    end
  end

end
