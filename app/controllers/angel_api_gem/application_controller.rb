module AngelApiGem
  class ApplicationController < ActionController::Base

  	def sanitize_query(query)
        unescaped = CGI.unescape(query)
        sanitized_query = unescaped.sub(/^https?\:\/\//, '').sub(/^www./,'')
        query = CGI.escape(sanitized_query)
    end
  	
  end
end
