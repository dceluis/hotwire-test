Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")

  resource :profile, only: [] do
    post "new", as: :validate, to: "profiles#new", on: :collection
  end

  resources :profiles, only: [:new, :create] do
    resources :employments, only: [:new, :create]
    resource :employment, only: [] do
      post "validate", as: :validate, to: "employments#validate", on: :collection
    end
  end

  root "pages#home"
end
