class OrgsController < ApplicationController
  def index
    @user = current_user
    @orgs = Org.all
  end

  def create
    @org = Org.new(name: params[:org][:name], desc: params[:org][:desc], user_id: session[:user_id])
    if @org.valid?
      @org.save
      Membership.create(user_id: session[:user_id], org: @org)
    else
      flash[:errors] = @org.errors.full_messages
    end
    redirect_to "/orgs"
  end

  def show
    @org = Org.find(params[:id])
    @users = Org.find(params[:id]).users
    # @membership = Org.find(params[:id]).memberships.where("user_id == ?", session[:user_id])
    @m = Membership.find_by(user_id: session[:user_id], org_id: params[:id])
    # @m.to_a
    puts "session id #{session[:user_id]}, params id #{params[:id]}"
    puts "this is m to array: #{@m}"
    # puts "this is membership #{@membership}"
    # User.first.memberships.where(org_id:2)
  end

  def destroy
    flash[:errors] = ["Cannot delete that Organization"] unless Org.find(params[:id]).destroy
    redirect_to "/orgs"
  end
end
