Rails.application.routes.draw do
  mount Easymon::Engine => '/health'
end
