Rails.application.routes.draw do
  resource :query, only: [ :show ]
end
