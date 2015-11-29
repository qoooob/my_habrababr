Rails.application.routes.draw do
  devise_for :users
  resources :posts do
    get :unpublished, on: :collection
    get :published, on: :collection

    patch :publish, on: :member
    patch :hide, on: :member

    resources :comments, only: [:edit, :create, :update, :destroy], shallow: true
    resources :subscriptions, only: [:create, :destroy], shallow: true
  end

  resources :categories, only: [:show]

  namespace :admin do
    resources :categories
    resources :users, only: [:index, :destroy]
    resources :posts do
      patch :approve, on: :member
      patch :reject, on: :member
      get :index, on: :collection
    end
  end

  root 'posts#index'

  end