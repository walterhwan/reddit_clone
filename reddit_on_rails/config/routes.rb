Rails.application.routes.draw do

  resources :comments, only: [:edit, :update, :destroy]

  resources :posts, only: [:edit, :update, :destroy, :show] do
    resources :comments, only: [:new, :create]
  end

  resources :users do
    resources :subs, only: [:edit, :update]
  end

  resource :session

  resources :subs, only: [:new, :create, :index, :show] do
    resources :posts, only: [:new, :create]
  end



  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
