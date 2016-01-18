# Oat Hydra

This gem provides a [Hydra](http://www.hydra-cg.com/) adapter for the [Oat](https://github.com/ismasan/oat) API serializer library.


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'oat_hydra'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install oat_hydra


## Usage

Include the adapter:

```ruby
require 'oat_hydra/adapters/hydra'
```

Use it in the same way as other Oat adapters.


## Behaviour

* `:self` links are converted to `@id` properties.
* A `type` definition is displayed as an `@type` property.


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/pmackay/oat_hydra.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

