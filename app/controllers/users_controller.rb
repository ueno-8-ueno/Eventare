class UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]
  
  def show
    @user = User.find(params[:id])
    @events = @user.events.page(params[:page]) # ページネーション
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

  # ストロングパラメータ
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  # ユーザプロフィールへのアクセス制御
  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_path(current_user)
    end
  end
end
