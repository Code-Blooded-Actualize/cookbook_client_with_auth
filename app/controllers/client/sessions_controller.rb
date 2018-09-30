class Client::SessionsController < ApplicationController
  def new
    render 'new.html.erb'
  end

  def create
    client_params = {
                      email: params[:email],
                      password: params[:password]
                     }     

    response = HTTP.post(
                            "http://localhost:3000/api/sessions", 
                            form: client_params
                            )
    
    if response.code == 200
      session[:jwt] = response.parse["jwt"]
      session[:email] = response.parse["email"]
      flash[:success] = 'Successfully logged in!'
      redirect_to '/'
    else
      flash[:warning] = 'Invalid email or password!'
      redirect_to '/client/login'
    end
  end

  def destroy
    session[:jwt] = nil
    session[:email] = nil
    flash[:success] = 'Successfully logged out!'
    redirect_to '/client/login'
  end
end
