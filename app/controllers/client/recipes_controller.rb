class Client::RecipesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def index
    response = HTTP.get("http://localhost:3000/api/recipes")
    @recipes = response.parse
    render 'index.html.erb'
  end

  def new
    render 'new.html.erb'
  end

  def create
    client_params = {
                     title: params[:title],
                     prep_time: params[:prep_time],
                     ingredients: params[:ingredients],
                     directions: params[:directions],
                     image_url: params[:image_url]
                    }
                      
    response = @auth_http.post(
                            "http://localhost:3000/api/recipes", 
                            form: client_params
                           )

    recipe = response.parse
    redirect_to "/client/recipes/#{recipe['id']}"
  end

  def show
    response = HTTP.get("http://localhost:3000/api/recipes/#{params[:id]}")
    @recipe = response.parse
    render 'show.html.erb'
  end

  def edit
    response = @auth_http.get("http://localhost:3000/api/recipes/#{params[:id]}")
    @recipe = response.parse
    render "edit.html.erb"
  end

  def update
    client_params = {
                     title: params[:title],
                     prep_time: params[:prep_time],
                     ingredients: params[:ingredients],
                     directions: params[:directions],
                     image_url: params[:image_url]
                    }

    response = @auth_http.patch(
                              "http://localhost:3000/api/recipes/#{params[:id]}", 
                              form: client_params
                              )

    redirect_to "/client/recipes/#{params[:id]}"
  end

  def destroy
    response = @auth_http.delete("http://localhost:3000/api/recipes/#{params[:id]}")
    redirect_to '/'
  end
end
