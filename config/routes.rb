Rails.application.routes.draw do
  #トップページ
  root to: "homes#top"
  get "home/about" => "homes#about"

  #User
  devise_for :users
  resources :users, only: [:index,:show,:edit,:update]

  #book,コメント、いいね
  resources :books, only: [:create, :index, :show, :destroy, :edit, :update] do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end

  #フォロー、フォロワー機能
  resources :relationships, only: [:create, :destroy]
   get "relationship/follow_users" => "relationships#follow_users"
   get "relationship/follower_users" => "relationships#follower_users"

  #検索機能
  get "/search" => "searches#search"

  #DM機能
  resources :messages, only: [:create]
  resources :rooms, only: [:create, :show, :index]
end
