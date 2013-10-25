AngelApiGem::Engine.routes.draw do

	get 'autocomplete' => 'angel_api#autocomplete', as: :angel_api_autocomplete
  	get 'startup_detail' => 'angel_api#startup_detail', as: :angel_api_startup_detail

end
