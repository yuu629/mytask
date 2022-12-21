Rails.application.routes.draw do

  devise_for :users, :controllers => {
  :registrations => 'users/registrations',
  :sessions => 'users/sessions'   
 }
 
  get 'search' => 'users#search'

  devise_scope :user do
    get "user/:id", :to => "users/registrations#detail"
    get "signup", :to => "users/registrations#new"
    get "login", :to => "users/sessions#new"
    get "logout", :to => "users/sessions#destroy"
  end

  get 'users/index'

  resources :users

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
