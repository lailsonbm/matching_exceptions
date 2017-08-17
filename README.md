# MatchingExceptions

Rescues exceptions using pattern matching.

Usage example:

```ruby
  def foo
    raise StandardError.new('foo bar')
  rescue ME.matches(/bar/)
    puts 'it works!'
  end

  pry(main)> foo
  # it works!
```

An ideal use case for this gem:

**Old code**
```ruby
  def bar
    do_something_complicated
  rescue StandardError => e
    if e.message =~ /some kind of error/
      treat_error
    else
      treat_rest
    end
  end
```

**New code**
```ruby
  def bar
    do_something_complicated
  rescue ME.matches(/some kind of error/)
    treat_error
  rescue StandardError
    treat_rest
  end
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'matching_exceptions'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install matching_exceptions

## Usage

Call `ME.matches(something)` in a rescue block to rescue exceptions with `something`.

By default, `message` will be matched (i.e. the exception will be rescued if `e.message == something`, or `e.message =~ something` if `something` is a regex).

You can also specify a custom attribute with the keyword argument `attribute:`:

```
  class CustomError < StandardError
    attr_reader :my_custom_attr
  end

  ...

  begin
    raise CustomError.new('foo', 'some weird custom field')
  rescue ME.matches(/weird/, attribute: :my_custom_attr)
    puts 'yay!'
  end
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/guava/matching_exceptions.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
