Rails.application.routes.draw do
  resources :issues
  get '/closed', to: 'issues#closed', as: 'closed_issues'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'issues#index'
end
