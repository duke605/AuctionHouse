class UsersController < ApplicationController
  before_action :authenticate_with_http_token, only: [:account, :show_users_items]

  def require_login
    user = User.find_by_token(cookies[:session_id])
    redirect_to user if user
  end

  def show_users_items

  end

  def account
  end

  private

  def authenticate_with_http_token
    redirect_to :login unless get_user
  end
end
