class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def authenticate
    @user = User.find_by(email: params[:user][:email]).try(:authenticate, params[:user][:password])

    # User authenticated
    if @user

      # setting session id
      cookies[:session_id] = @user.generate_token
      redirect_to @user
    else

      # Login unsuccessful, retrying
      redirect_to :login
    end
  end

  def get_user
    @session_user = User.find_by_token(cookies[:session_id])
  end
end
