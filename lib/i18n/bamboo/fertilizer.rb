require 'i18n'

module I18n
  module Bamboo
    module Fertilizer
      module ::I18n
        class << self
          alias_method :original_translate, :translate
          alias_method :original_localize, :localize

          def translate(*args)
            translations = []

            available_locales.each do |locale|
              args_copy = args.dup

              if args_copy.last.is_a? Hash
                args_copy.last.merge!(locale: locale)
              else
                args_copy << {locale: locale}
              end

              translations << original_translate(*args_copy)
            end

            translations.max
          end

          def localize(object, options = {})
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
