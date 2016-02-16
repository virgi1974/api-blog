Rails.application.routes.draw do

  namespace :api, defaults: { format: :json }, path: '/api-blog'  do 
    scope module: :v1 do
      resources :users, except: [:new, :edit]
    end
  end

end


