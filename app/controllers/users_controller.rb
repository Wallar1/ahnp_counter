class UsersController < ApplicationController
  before_action :set_user
  before_action :set_users

  def index
    @user.counter += 1
    respond_to do |format|
      if @user.save!
        flash[:notice] = 'User counter was incremented!'
        format.any(:json,:js) {render_users_table(@users)}
        format.html
      else
        flash[:alerts] = @user.errors.full_messages
        format.any(:json,:js) {render json: {user: @user}}
        format.html
      end
    end
  end



  private

  def set_user
    @user = User.where(ip_address: request.remote_ip).first_or_initialize
  end

  def set_users
    @users = User.all.order(counter: :desc)
  end

  def render_users_table users
    render json: {
      success: true, 
      users: render_to_string(
        partial: 'users_table',
        layout: false,
        locals: {:@users => users}
      )
    }
  end
end