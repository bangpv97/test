class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    return @user if @user = User.find_by(id: params[:id])
    flash[:danger] = t "not_found_error"
    redirect_to root_url
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t "static_pages.home.sample_app"
      redirect_to @user
    else
      render "new"
    end
  end
  private
  def user_params
    params.require(:user).permit(:name, :email, :password,
      :password_confirmation)
  end
end
