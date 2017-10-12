Rails.application.routes.draw do
  devise_for :users
  # RESTful Route
  # A method that declares index, show, new, edit, update, and destroy actions instead of declaring separate routes
  resources :books do
    resources :reviews
    # storing the RESTful resource reviews INSIDE books
  end

  root 'books#index'
end
