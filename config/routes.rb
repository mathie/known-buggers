KnownBuggers::Application.routes.draw do
  resources :bugs

  root to: 'pages#index'
end
