class SessionController < ApplicationController
  def create
    @user = User.find_by_email(params[:user][:email]).try(:authenticate, params[:user][:password])
    if @user
      session[:user_id] = @user.id
      return redirect_to "/orgs"
    else
      flash[:errors] = ["Invalid Combination"]
      return redirect_to '/main'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to "/main"
  end
end
