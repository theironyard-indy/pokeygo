Rails.application.routes.draw do
  resources :sightings
  resources :categories
  devise_for :trainers
  resources :trainers, only: [:show]

  root 'sightings#index'
end
