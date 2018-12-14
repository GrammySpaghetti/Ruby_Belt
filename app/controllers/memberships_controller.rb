class MembershipsController < ApplicationController

  def create
    @membership = Membership.new(user_id: session[:user_id], org_id: params[:membership][:org_id])
    if @membership.valid?
      @membership.save
    else
      flash[:errors] = @membership.errors.full_messages
    end
    redirect_to "/orgs/#{params[:membership][:org_id]}"
  end

  def destroy
    Membership.find_by(user_id: session[:user_id], org_id: params[:membership][:org_id]).destroy
    redirect_to "/orgs/#{params[:membership][:org_id]}"
  end

end
