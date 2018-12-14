class UsersController < ApplicationController
  def index
  end

  def create
    @user = User.new(user_params)
    if @user.valid?
      @user.save
      session[:user_id] = @user.id
      return redirect_to "/orgs"
    else
      flash[:errors] = @user.errors.full_messages
      return redirect_to "/main"
    end
  end
  private
    def user_params
      params.require(:user).permit(:first_name,:last_name, :email, :password, :password_confirmation)
    end
end
