 class SessionsController < ApplicationController
  def new
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @user = User.find_by(email: params[:session][:email])
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      redirect_to root_path, notice: "User '#{@user.fname} #{@user.lname}' has successfully logged in!"
    else
      redirect_to login_path
    end
  end

  def destroy
    @user = current_user
    session[:user_id] = nil
    redirect_to root_path, notice: "User '#{@user.fname} #{@user.lname}' has successfully logged out!"
  end
end
