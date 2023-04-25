Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  get "home/about" => "homes#about"
  resources :books, only:[:new, :edit, :index, :show, :create, :update, :destroy]
  resources :users, only:[:show, :edit, :index,  :update]
end

