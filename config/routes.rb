Rails.application.routes.draw do
  get '/' => 'client/recipes#index'

  namespace :client do
    get '/users/new' => 'users#new'
    post '/users' => 'users#create'

    get '/login' => 'sessions#new'
    post '/login' => 'sessions#create'
    delete '/logout' => 'sessions#destroy'

    get '/recipes' => 'recipes#index'
    get '/recipes/new' => 'recipes#new'
    post '/recipes' => 'recipes#create'
    get '/recipes/:id' => 'recipes#show'
    get '/recipes/:id/edit' => 'recipes#edit'
    patch '/recipes/:id' => 'recipes#update'
    delete '/recipes/:id' => 'recipes#destroy'
  end
end
