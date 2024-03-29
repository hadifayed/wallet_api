Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth', skip: [:sessions, :password, :registration]
  devise_scope :user do
    resource :session, only: [], path: 'auth', controller: 'sessions', as: :user_session do
      post "sign_in" => :create
    end
    resource :registration, only: [:create], path: '/auth', controller: 'registrations'
  end
  resources :transactions, only: [:index, :create]
  scope '/twilio' do
    post "/ask_for_confirmation", to: "twilio#ask_for_confirmation"
    post "/submit_confirmation", to: "twilio#submit_confirmation"
  end
  get '/my_wallet', to: 'users#my_wallet'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
