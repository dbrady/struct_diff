# StructDiff

Visually compare deeply nested data structures.

![Example StructDiff](doc/simple_diff_example.png?raw=true)


This gem started life as a hack to help me debug monstrous data blobs coming and
going from an API. Trying to eyeball two structures each half a screen in size,
with mostly equivalent data arranged in different orders, was a great big barrel
of no fun!

NOTE: This gem is just barely pupating from "kludgy hack" to a ruby gem, which
means it's really just "a ruby gem that contains a kludge hack". My development
objectives for this tool are to increase functionality and to make it easier to
use. Right now it's, well, it's a kludge hack. Draw your own assumptions (the
more dismal the better).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'struct_diff'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install struct_diff

## Usage

```ruby
require 'struct_diff'

hash1 = { "a" => { "b" => 64, "c" => 13 }}
hash2 = { "a" => { "b" => 63, "c" => 13 }}

StructDiff.hash_cmp h1, h2
# => output rendered to console
```



**TODO**: Note that only comparing hashes is currently supported. Eventually
`hash_cmp` will become `struct_diff` or `struct_cmp` and will tolerate
Arrays. Further TODO items can be found in
the [TODO file](https://github.com/dbrady/struct_diff/blob/master/TODO.md)
or [issues](https://github.com/dbrady/struct_diff/issues).

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run
`rake spec` to run the tests. You can also run `bin/console` for an interactive
prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To
release a new version, update the version number in `version.rb`, and then run
`bundle exec rake release`, which will create a git tag for the version, push
git commits and tags, and push the `.gem` file
to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/dbrady/struct_diff. This project is intended to be a safe,
welcoming space for collaboration, and contributors are expected to adhere to
the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of
the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the StructDiff project’s codebases, issue trackers, chat
rooms and mailing lists is expected to follow
the
[code of conduct](https://github.com/dbrady/struct_diff/blob/master/CODE_OF_CONDUCT.md).
