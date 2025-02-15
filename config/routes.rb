Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get "projects/index"
      get "projects/show"
      get "projects/create"
      get "projects/update"
      get "projects/destroy"
      get "users/index"
      get "users/show"
      get "users/create"
      get "users/update"
      get "users/destroy"
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
