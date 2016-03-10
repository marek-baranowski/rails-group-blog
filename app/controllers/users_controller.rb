class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :activate]
  before_action :admin_only, only: [:destroy]
  before_action :owns_resource, only: [:show, :edit, :update]
  skip_before_action :require_login, only: [:new, :create, :show]

  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to login_path, notice: 'User was successfully created. Now you have to wait for activation.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
    end
  end

  def activate
    @user.activate!
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully activated.' }
    end
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
