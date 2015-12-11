Rails.application.routes.draw do
  get 'events/join'

  get 'events/index'

  root to: 'static_pages#home'
  get 'signup',  to: 'users#new'
  get    'login' , to: 'sessions#new'
  post   'login' , to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  resources :users, except: [:index, :new]
  resources :sessions, only: [:new, :create, :destroy]
  resources :microposts
  resources :events
  resources :relationships, only: [:create, :destroy]

  resources :users do #課題
    member do
      get :followings
      get :followers
    end
  end
end