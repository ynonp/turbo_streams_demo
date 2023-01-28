Rails.application.routes.draw do
  resources :messages, only: %w[index create]
end
