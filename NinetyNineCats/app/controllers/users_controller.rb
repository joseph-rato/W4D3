class UsersController < ApplicationController 
  
  def new
    render :new 
  end 
  
  def create
    @user = User.find_by(params[:id])
    
    if 
  end
end