Rails.application.routes.draw do

  root to: 'cocktails#index'

  get "/inspiration-hub", to: 'cocktails#random', as: 'hub'
  get "/inspiration/:id", to: 'cocktails#random_show', as: 'inspiration'

  resources :cocktails, only: [:index, :show, :new, :create, :destroy] do
    resources :doses, only: [:new, :create]

  end

  resources :doses, only: [:destroy, :index]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

