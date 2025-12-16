Rails.application.routes.draw do
  get 'pages/index'
  get "up" => "rails/health#show", as: :rails_health_check

  # Default mounting
  mount Robochat::Engine => "/robochat"
  
  # Custom routes using the gem's controller directly
  get '/my-claude-assistant', to: 'robochat/messages#claude'
  get '/my-openai-helper', to: 'robochat/messages#openai'
  
  root "pages#index"
end