Rails.application.routes.draw do
  apipie
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'thumbnails', to: "thumbnails#index"
end
