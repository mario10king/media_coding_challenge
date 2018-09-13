Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get "/movies/:id", to: "media#movies"
  get "/shows/:id", to: "media#shows"
  get "/search", to: "media#search"

end
