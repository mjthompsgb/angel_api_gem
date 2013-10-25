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

# Future

I will be adding lots of features to this including login via AngelList. Check back often for updates.