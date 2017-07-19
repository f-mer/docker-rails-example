Rails.application.routes.draw do
  mount Easymon::Engine => '/health'

  root to: redirect('/health')
end
