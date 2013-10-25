module AngelApiGem
  	class Role

        attr_accessor :id, :role, :confirmed, :name, :type, :user_id, :bio, :followers, :angel_url, :image_url

        def initialize(role)
            @id = role["id"]
            @role = role["role"]
            @confirmed = role["confirmed"]
            @name = role["tagged"]["name"]
            @type = role["tagged"]["type"]
            @user_id = role["tagged"]["id"]
            @bio = role["tagged"]["bio"]
            @followers = role["tagged"]["follower_count"]
            @angel_url = role["tagged"]["angellist_url"]
            @image_url = role["tagged"]["image"]
        end
    end

end
