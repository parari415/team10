Rails.application.routes.draw do
  get 'users/new'
  get 'users/create'
  get 'likes/create'
  get 'likes/destroy'
  get 'recipes/index'
  get 'recipes/show'
  get 'recipes/new'
  get 'recipes/create'
  get 'recipes/edit'
  get 'recipes/update'
  get 'recipes/destroy'
  get 'top/main'
  get 'top/login'
  get 'top/logout'

  root 'top#main'

  get 'login', to: 'top#login'
  post 'login', to: 'top#login'
  delete 'logout', to: 'top#logout'

  get 'signup', to: 'users#new', as: 'signup'
  resources :users, only: [:create]

  resources :recipes do
    resource :like, only: [:create, :destroy]
    collection do
      get 'generate_recipe'
      post 'generate_recipe'
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
