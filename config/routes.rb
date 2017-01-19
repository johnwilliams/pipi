Rails.application.routes.draw do
  resources :articles
  get 'welcome/index'
  
  root 'welcome#index'
  
  mount Easymon::Engine => "/up"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
