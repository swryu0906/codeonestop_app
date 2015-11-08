class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :authorize, except: [:index, :show, :new, :create]

  def index
    @users = User.all.order(:id)
  end

  def show
    @posts = @user.posts
  end

  def new
    @user = User.new
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to @user, notice: "User '#{@user.fname.titleize} #{@user.lname.titleize}' was successfully created!"
    else
      render :new
    end
  end

  def edit
    respond_to do |format|
      format.html
      format.js
    end
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: "User '#{@user.fname.titleize} #{@user.lname.titleize}' profile was successfully updated!"
    else
      render :edit
    end
  end

  def destroy
    # user_name = "#{@user.fname.titleize} #{@user.lname.titleize}"
    if @user.destroy
      # redirect_to users_path, notice: "User '#{user_name}' was successfully deleted!"
      redirect_to users_path, notice: "User '#{@user.fname.titleize} #{@user.lname.titleize}' was successfully deleted!"
    else
      redirect_to :back
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:fname, :lname, :email, :website, :git, :password, :password_confirmation)
  end
end
