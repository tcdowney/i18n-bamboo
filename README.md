I18n::Bamboo
------------

[![Build Status](https://travis-ci.org/tcdowney/i18n-bamboo.svg?branch=master)](https://travis-ci.org/tcdowney/i18n-bamboo)

Consider the noble bamboo.  This peculiar member of the Poaceae family has been known to grow to extraordinary lengths without yielding to (mostly) any obstacles.

Not unlike bamboo, the i18n translations of a Rails app will continue to grow.  As a tenacious stalk of bamboo breaks through a slab of sidewalk, so too will long translations break a UI.

I18n:Bamboo monkey patches the Rails I18n module and will force all calls to I18n.translate (I18n.t) and I18n.localize (I18n.l) to return the longest translated or localized value from all available locales.  For obvious reasons (monkey patching :cold_sweat:), this gem is intended to be used for development purposes only to aid in UI and internationalization/localization testing.

## tl;dr

This gem monkey patches the I18n module to force I18n.translate and I18n.localize to always return the longest translation, regardless of current locale.

I18n-bamboo will help you find UI pain points and help you uncover some of the less responsive parts of your application.

## Example Usage

Consider the following hypothetical locale files:
```yml
# en.yml
en:
    car: "Car"
    dog: "Dog"
    bird: "Feathered Friend"

# es.yml
es:
    car: "Coche"
    dog: "Perro"
    bird: "Pajaro"

# de.yml
de:
    car: "Automobil"
    dog: "Hund"
    bird: "Vogel"
```

Calls to the new monkey patched translation helper would return the following:

```ruby
# Assume that I18n.default_locale = :en
I18n.t('car')
# => "Automobil"
I18n.t('dog')
# => "Perro"
I18n.t('bird')
# => "Feathered Friend"
```

Additionally, you can temporarily override this new behavior of the `translate` and `localize` methods by passing in the `:force_default_behavior` option.

```ruby
# Assume that I18n.default_locale = :en
I18n.t('car', force_default_behavior: true)
# => "Car"
I18n.t('car', force_default_behavior: false)
# => "Automobil"
```

## Installation

Add this line to your application's Gemfile:

    gem 'i18n-bamboo'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install i18n-bamboo

## Configuration
### Automatic
Simply add the following line to your `config/environments/development.rb` file:
```ruby
# config/environments/development.rb
Rails.application.configure do
    # ... previous config
    config.i18n_bamboo.active = true
    # further config ...
end
```

Setting `config.i18n_bamboo.active` to `false` will disable the automatic initialization of the gem.

### Manual
If you want to use the gem temporarily in a pry session or something simply require the following:
```ruby
require 'i18n/bamboo/fertilizer'
```
**CAUTION:** Keep in mind that the fertilizer _does_ monkey patch the existing I18n module, so you will need to restart your console session/server to get the original I18n behavior back.

## Contributing

1. Fork it ( https://github.com/tcdowney/i18n-bamboo/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
