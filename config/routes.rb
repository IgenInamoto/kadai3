Rails.application.routes.draw do
  get 'relationships/followings'
  get 'relationships/followers'
  devise_for :users
  root to: 'homes#top'
  get "home/about" => "homes#about"
  get "search" => "searches#search"
  
  # ネストさせる
  resources :books, only:[:new, :edit, :index, :show, :create, :update, :destroy] do
    resources :book_comments, only:[:create, :destroy]
    resource :favorites, only:[:create, :destroy]
  end
  # ネストさせる
  resources :users, only:[:show, :edit, :index,  :update] do
    member do
      get :follows, :followers
    end
     resource :relationships, only: [:create, :destroy]
  end
  
end

