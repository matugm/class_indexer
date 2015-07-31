# ClassIndexer

This application uses the `parser` gem to find all the methods and classes in your Ruby source code. It generates json output.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'class_indexer'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install class_indexer

## Usage

To use run the `indexer` binary. You can use the `-p` flag for pretty json output.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/matugm/class_indexer/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
