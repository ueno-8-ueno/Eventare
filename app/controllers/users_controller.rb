class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @events = @user.events
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user != current_user
      redirect_to user_path(current_user.id)
      return
    end

    if @user.update(user_params)
      flash[:notice] = "プロフィールの保存が完了しました"
      redirect_to user_path(current_user.id)
    else
      render :edit
    end
  end


  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
end
