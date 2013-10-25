Rails.application.routes.draw do

  mount AngelApiGem::Engine => "/angel_api"
end
