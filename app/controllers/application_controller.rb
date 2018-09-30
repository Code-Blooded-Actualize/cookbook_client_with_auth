class ApplicationController < ActionController::Base
  def current_user
    @current_user ||= session[:email]
  end

  helper_method :current_user

  def authenticate_user!
    if session[:jwt]
      @auth_http = HTTP.auth("Bearer #{session[:jwt]}")
    else
      redirect_to '/'
    end
  end
end
