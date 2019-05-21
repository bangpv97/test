class PasswordResetsController < ApplicationController
  before_action :load_user, only: %i(edit update)
  before_action :valid_user, only: %i(edit update)
  before_action :check_expiration, only: %i(edit update)

  def new; end

  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = t "mail_reset"
      redirect_to root_path
    else
      flash.now[:danger] = t "errors.email_not_found"
      render :new
    end
  end

  def edit; end

  def update
    if params[:user][:password].empty?
      @user.errors.add :password, t("errors.pass_not_empty")
      render :edit
    elsif @user.update_attributes user_params
      log_in @user
      @user.update_attribute(:reset_digest, nil)
      flash[:success] = t "pass_have_been_reset"
      redirect_to @user
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def load_user
    @user = User.find_by email: params[:email]
    return if @user
    flash[:danger] = t "errors.user_not_found"
    redirect_to root_path
  end

  def valid_user
    return if @user&.activated? && @user.authenticated?(:reset, params[:id])
    flash[:danger] = t "errors.invalid_user"
    redirect_to root_path
  end

  def check_expiration
    return false unless @user.password_reset_expired?
    flash[:danger] = t "errors.pass_has_expired"
    redirect_to new_password_reset_path
  end
end
