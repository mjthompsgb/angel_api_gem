## AngelApiGem v0.0.1

### What is it?

The Angel API Gem is a way to simplify using the AngelList.co API. You can use it to find information about Startups and Talent or any other info
the API makes available.

Below you will find guides on how to use it all.

### Requirements

Angel API Gem works with:

* Ruby 1.9.3 - 2.0.0
* Rails 3.1 - 4.0

### Install

Add AngelApiGem to your Gemfile:

```ruby
gem 'angel_api_gem'
```

Bundle install:

```ruby
bundle install
```

Add base route to your app's routes.rb file:

```ruby
mount AngelApiGem::Engine => "/angel_api"
```

The "/angel_api" route can be whatever you would like.

### Usage

##### Search

Symbol in parameter must be one of:
* :Startup
* :User
* :MarketTag 
* :LocationTag

It is also best to sanitize the query you are passing in to encode any characters that will mess with a query string
```ruby
AngelApi::Startup.where(:Startup => query)
```

##### Startup Detail

Pass in a startup ID and get back the details of that startup
```ruby
AngelApiGem::AngelApi::Api.new.startup_detail( STARTUP_ID )
```

##### Startup Roles

Pass in a startup ID and get back all the roles in an object. Can get the following about a role:
* .id
* .role
* .confirmed
* .name
* .type
* .user_id
* .bio
* .followers
* .angel_url
* .image_url

```ruby
AngelApiGem::AngelApi::Startup.roles( STARTUP_ID )
```

##### jQuery Autocomplete

View input
```ruby
<input class="input-xlarge" id="search" type="text" name="website" data-id=''>
```

jQuery
```ruby
$( "#search" ).autocomplete({
    source: function( request, response ) {
      $.ajax({
        url: "/angel_api/autocomplete",
        dataType: "json",
        data: {
          query: encodeURIComponent(request.term)
        },
        success: function( data ) {
          if (!data) {
            stop_loading_spinner();
            return [];
          }
          response( $.map( data, function( item ) {
            return {
              label: item.company_url || item.name,
              value: item.company_url || item.name,
              id: item.id
            }
          }));
        }
      });
    },
    minLength: 2,
    select: function( event, ui ) {
      log( ui.item ?
        "Selected: " + ui.item.label :
        "Nothing selected, input was " + this.value);
      $('#angel_id').val(ui.item.id);
      stop_loading_spinner();
    },
    open: function() {
      $( this ).removeClass( "ui-corner-all" ).addClass( "ui-corner-top" );
    },
    close: function() {
      $( this ).removeClass( "ui-corner-top" ).addClass( "ui-corner-all" );
    }
});
```

# Future

I will be adding lots of features to this including login via AngelList. Check back often for updates.