# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'i18n/bamboo/version'

Gem::Specification.new do |spec|
  spec.name          = 'i18n-bamboo'
  spec.version       = I18n::Bamboo::VERSION
  spec.authors       = ['Tim Downey']
  spec.email         = ['tim@downey.io']
  spec.summary       = %q{
                          Aids in development by monkey patching the Rails I18n module to always return the longest
                          translation or localized value across all available locales.
                         }
  spec.description   = %q{
                          Consider the noble bamboo.  This peculiar member of the Poaceae family has been known to 
                          grow to extraordinary lengths without yielding to (mostly) any obstacles.

                          Not unlike bamboo, the i18n translations of a Rails app will continue to grow.  As a 
                          tenacious stalk of bamboo breaks through a slab of sidewalk, so too will long translations 
                          break a UI.

                          I18n:Bamboo monkey patches the Rails I18n module and will force all calls to I18n.translate 
                          (I18n.t) and I18n.localize (I18n.l) to return the longest translated or localized value from 
                          all available_locales.  For obvious reasons, this gem is intended to be used for development 
                          purposes only to aid in UI and internationalization/localization testing.
                        }
  spec.homepage      = 'https://github.com/tcdowney/i18n-bamboo'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'i18n'

  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'pry', '~> 0.10'
  spec.add_development_dependency 'rake', '~> 10.3'
  spec.add_development_dependency 'rubocop', '~> 0.27.1'
  spec.add_development_dependency 'rspec', '~> 3.1.0'
end
