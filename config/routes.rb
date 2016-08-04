Rails.application.routes.draw do
  resources :sightings
  resources :categories
  devise_for :trainers

  root 'sightings#index'
end
