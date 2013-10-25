module AngelApiGem
  module AngelApi
    class Api
      def initialize
        @uri = URI.parse("https://api.angel.co/1/")
        @http = Net::HTTP.new(@uri.host, @uri.port)
        @http.use_ssl = true
      end

      def api_request(api_path)
        response = @http.request(Net::HTTP::Get.new(@uri.request_uri + api_path))
        response.code == '200' ? JSON.parse(response.body) : nil
      end

      def search(query,type="Startup")
        # type can be User, Startup, MarketTag or LocationTag
        types = %w[User Startup MarketTag LocationTag]
        raise "type not one of User, Startup, MarketTag or LocationTag" unless types.include?(type.to_s.capitalize)
        path = URI.encode("search?query=#{query}&type=#{type.to_s.capitalize}")
        result = api_request(path)
      end

      def startup_detail(id)
        path = URI.encode("startups/#{id}")
        api_request(path.strip)
      end

      def startup_detail_from_url(url)
        path = URI.encode("startups/search.json?domain=#{url}")
        detail_list = api_request(path.strip)
      end

      def startup_roles(id, page=1)
        path = URI.encode("startups/#{id}/roles?page=#{page}")
        detail_list = api_request(path.strip)
      end
    end

    class Startup
      def self.where( params = {} )
        angel = AngelApi::Api.new
        @threads = []
        @details = []
        startup_ids = params.values.inject([]) do |ids, v|
          next if v.blank?
          ids += angel.search(v,params.keys.first).collect{ |s| s['id'] }
        end

        return nil if startup_ids.blank? # if no good search results yet don't try anything

        # multithreaded this to speed up the return of startup details
        # needed startup details to get the company url from the Angel API.
        startup_ids.each do |id|
          @threads << Thread.new(id) { |id|
              angel = AngelApi::Api.new
              @details << angel.startup_detail(id)
          }
        end
        @threads.each { |aThread|  aThread.join }
        @details.flatten.uniq
      end

      def self.roles(startup_id)
        mutex = Mutex.new
        @threads = []
        all_roles = []
        page = 0
        last_page = nil
        until page == last_page do
          @threads << Thread.new(startup_id) {
            mutex.synchronize do
              page += 1
              roles = AngelApiGem::AngelApi::Api.new.startup_roles(startup_id,page)
              last_page = roles["last_page"]
              if roles["startup_roles"]
                roles["startup_roles"].each do |role|
                  all_roles << Role.new(role)
                end
              end
            end
          }
          @threads.each { |aThread|  aThread.join }
        end
        return all_roles
      end
    end
  end
end