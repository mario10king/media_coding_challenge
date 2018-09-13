Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get "/movie/:id", to: "media#movie"
  get "/show/:id", to: "media#show"
  get "/search", to: "media#search"

end
