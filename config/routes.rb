KnownBuggers::Application.routes.draw do
  match '/bugs',                 to: 'bugs#index'
  match '/bugs/tagged/:tags',    to: 'bugs#tagged',   as: 'tagged'
  match '/bugs/in_state/:state', to: 'bugs#in_state', as: 'in_state'

  root to: 'pages#index'
end
