# frozen_string_literal: true

Rails.application.routes.draw do
  # devise_for :users
  get 'start/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resource :session, only: [:new, :create, :destroy] do
    post :callback
  end

  resource :registration, only: [:new, :create] do
    post :callback
  end

  resources :credentials, only: [:create, :destroy] do
    post :callback, on: :collection
  end

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }


  # post "session_callback", to: "sessions#callback"
  # post "registration_callback", to: "registrations#callback"
  root to: "home#index"
end
