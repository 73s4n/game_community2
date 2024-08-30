Rails.application.routes.draw do

  get 'groups/index'
  devise_for :admin, skip: [:registrations, :password], controllers: {
    sessions: 'admin/sessions'
  }
  
  namespace :admin do
    get 'dashboards', to: 'dashboards#index'
    resources :users, only: [:destroy]
    get 'post_comments', to: 'post_comments#index'
    resources :post_comments, only: [:destroy]
  end
  
  
  scope module: :public do
    devise_for :users
    root to: 'homes#top'
    get '/search', to: 'searches#search'
    get 'homes/about', to: 'homes#about', as: :about
    resources :posts, only: [:new, :create, :index, :show, :destroy] do
      #resource :favorites, only: [:create, :destroy]
      resources :post_comments, only: [:create, :destroy]
      
    end
    resources :users, only: [:index, :show, :edit, :update]
    resources :groups, only: [:new, :index, :show, :create, :edit, :update] do
    # group_users(中間テーブルをネストさせる)
      resource :group_users, only: [:create, :destroy]
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end