Rails.application.routes.draw do
  get '/' => 'sites#home'
  post '/' => 'sites#index'

  resources :concerts do
  	resources :comments
  end

  get '/popular_concerts' => 'concerts#show_most_popular'

end
