class SessionsController < ApplicationController
  def new 
    render :new 
  end
  
  def create 
     @user = User.find_by_credentials(params[:user][:username], params[:user][:password])
     login!(@user)
     redirect_to cats_url 
  end
  
  def destroy
     # current_user.reset_session_token!
     logout!
     redirect_to cats_url
  end 
  
end