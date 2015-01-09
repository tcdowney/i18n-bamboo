require 'i18n'

module I18n
  module Bamboo
    module Fertilizer
      module ::I18n
        class << self
          alias_method :original_translate, :translate
          alias_method :original_localize, :localize

          # Public: Unless overridden, translates using the longest translation from among all available locales.
          #
          # *args   - see http://goo.gl/vSpFKl for original method argument doc
          # options - The final argument can optionally be a Hash of options
          #           :force_default_behavior - Boolean that determines whether or not to force the default translate
          #                                   behavior
          #
          # Returns the longest translated String.
          def translate(*args)
            # Fall back to the default translate behavior if the :force_default_behavior is true
            force_current_locale  = args.last.is_a?(Hash) ? args.pop.delete(:force_default_behavior) : false
            return original_translate(*args) if force_current_locale

            translations = []

            available_locales.each do |locale|
              args_copy = args.dup

              if args_copy.last.is_a?(Hash)
                args_copy.last.merge!(locale: locale)
              else
                args_copy << {locale: locale}
              end

              translations << original_translate(*args_copy)
            end

            translations.max
          end

          # Public: Unless overridden, translates using the longest localized value from among all available locales.
          #
          # object  - see http://goo.gl/bbXILw for original method argument doc
          # options - see http://goo.gl/bbXILw for original method argument doc.  This Hash can can contain the
          #           the following custom key:
          #           :force_default_behavior - Boolean that determines whether or not to force the default localize
          #                                   behavior
          #
          # Returns the longest localized String.
          def localize(object, options = {})
            # Fall back to the default localize behavior if the :force_default_behavior is true
            return original_localize(object, options) if options.delete(:force_default_behavior)

            localized_values = []

            available_locales.each do |locale|
              options_copy = options.merge(locale: locale)

              localized_values << original_localize(object, options_copy)
            end

            localized_values.max
          end

          alias_method :t, :translate
          alias_method :l, :localize
        end
      end
    end
  end
end
