class UsersController < ApplicationController
  before_action :load_user, only: %i(show)

  def new
    @user = User.new
  end

  def show; end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t "static_pages.home.sample_app"
      redirect_to @user
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation
  end

  def load_user
    return @user if @user = User.find_by(id: params[:id])
    flash.now[:danger] = t "user_not_found"
    redirect_to root_path
  end
end
