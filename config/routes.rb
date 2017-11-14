Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "pokers#index"

  get '/restart_game', to: 'pokers#shuffle', as: :restart_game_pokers
end
