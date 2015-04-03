Rails.application.routes.draw do
  get 'items/index'
  get 'users/account/:id' => 'users#account', as: :user
  get 'user/items/:id' => 'users#show_users_items', as: :user_items
  get 'users/login' => 'users#require_login', as: :login

  post 'users/login' => 'users#authenticate'

  get '/' => 'items#index', as: :items
end
