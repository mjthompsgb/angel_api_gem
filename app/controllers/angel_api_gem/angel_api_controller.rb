require_dependency "angel_api_gem/application_controller"

module AngelApiGem

	class AngelApiController < ApplicationController

    def autocomplete
    	raise "Need query string param 'query'" if !params[:query]
      @detail_list = AngelApi::Startup.where(:Startup => sanitize_query(params[:query]))
      render json: @detail_list
    end

    def startup_detail
      if params[:id]
        id = params[:id]
        @detail = AngelApi::Api.new.startup_detail(id)
      elsif params[:url]
        @detail = AngelApi::Api.new.startup_detail_from_url(sanitize_query(params[:url]))
      else
        @detail = nil
      end
      render json: @detail
    end
	end

end
