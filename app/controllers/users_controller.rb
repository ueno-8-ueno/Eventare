class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @events = @user.events
  end

  def edit
  end
end
