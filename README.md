# ChristmasTreeFormatter

Christmas tree formatter for RSpec.

![Example](./example.gif?raw=true)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'christmas_tree_formatter'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install christmas_tree_formatter

## Usage

Add to `.rspec`:

```
--require christmas_tree_formatter
--format ChristmasTreeFormatter
```

If you only want to use the `christmas_tree_formatter`
during the month of December,
you can wrap that in an ERB conditional:

```
<% if Date.today.month == 12 %>
  --require christmas_tree_formatter
  --format ChristmasTreeFormatter
<% end %>
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run
`rake spec` to run the tests. You can also run `bin/console` for an interactive
prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To
release a new version, update the version number in `version.rb`, and then run
`bundle exec rake release`, which will create a git tag for the version, push
git commits and tags, and push the `.gem` file to
[rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at
<https://github.com/elabs/christmas_tree_formatter>. This project is intended
to be a safe, welcoming space for collaboration, and contributors are expected
to adhere to the [Contributor Covenant](http://contributor-covenant.org) code
of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

