class Client::UsersController < ApplicationController
  def new
    render 'new.html.erb'
  end

  def create
    client_params = {
                      email: params[:email],
                      name: params[:name],
                      password: params[:password],
                      password_confirmation: params[:password_confirmation]
                     }     

    response = HTTP.post(
                            "http://localhost:3000/api/users", 
                            form: client_params
                            )
    
    if response.code == 200
      flash[:success] = 'Successfully created user!'
      redirect_to '/'
    else
      flash[:warning] = 'Was not able to create user'
      redirect_to '/client/users/new'
    end
  end
end
