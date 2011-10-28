KnownBuggers::Application.routes.draw do
  match '/bugs', to: 'bugs#index'
  match '/bugs/tagged/:tags', to: 'bugs#tagged', as: 'tagged'

  root to: 'pages#index'
end
