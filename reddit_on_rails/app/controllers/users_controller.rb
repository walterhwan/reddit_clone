class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in(@user)
      redirect_to subs_url
    else
      flash[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def destroy
    if current_user.id == params[:id]
      current_user.destroy!
      redirect_to new_user_url
    else
      flash[:errors] = ['You are not the owner of this account']
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
