class UsersController < ApplicationController
  before_action :load_user, except: %i(new create index)
  before_action :logged_in_user, except: %i(create new)
  before_action :correct_user, only: %i(edit update)
  before_action :admin_user, only: %i(destroy)

  def new
    @user = User.new
  end

  def index
    @users = User.paginate page: params[:page]
  end

  def show; end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      flash[:success] = t "static_pages.home.sample_app"
      redirect_to @user
    else
      render :new
    end
  end

  def edit; end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "profile_updated"
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t "user_deleted"
    else
      flash[:danger] = t "errors.delete_failed"
    end
    redirect_to users_path
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation
  end

  def load_user
    return @user if @user = User.find_by(id: params[:id])
    flash[:danger] = t "errors.user_not_found"
    redirect_to root_path
  end

  def logged_in_user
    return if logged_in?
    store_location
    flash[:danger] = t "errors.login_required"
    redirect_to login_path
  end

  def correct_user
    @user = User.find_by(id: params[:id])
    return if current_user? @user
    flash[:danger] = t "errors.incorrect_user"
    redirect_to root_path
  end

  def admin_user
    return if current_user.admin?
    flash[:danger] = t "errors.no_authority"
    redirect_to root_path
  end
end
