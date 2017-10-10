Rails.application.routes.draw do
  # RestFUL Route
  # A method that declares index, show, new, edit, update, and destroy actions instead of declaring separate routes
  resources :books
end
