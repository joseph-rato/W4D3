class UsersController < ApplicationController
  before_action
  def new
    @user = User.new
    render :new
  end

  # come back later to check on this stuff
  def create
    @user = User.new(user_params)

    if @user.save
      login!(@user)
      redirect_to cats_url
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to new_user_url #flash[:errors]
      # render json: @user.errors.full_messages, status: 422
    end
  end

  private
  def user_params
    params.require(:user).permit(:username, :password)
  end
end
