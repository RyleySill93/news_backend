Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'staticpages#root'
  namespace :api, defaults: { format: :json } do
    resources :articles, only: [:index, :show]
  end
end
