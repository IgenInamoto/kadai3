Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  get "home/about" => "homes#about"
  resources :books, only:[:new, :edit, :index, :show, :create, :update, :destroy] do
    resources :book_comments, only:[:create, :destroy]
    resource :favorites, only:[:create, :destroy]
  end
  resources :users, only:[:show, :edit, :index,  :update]
  
end

