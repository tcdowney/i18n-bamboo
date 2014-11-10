require 'active_support'

module I18n
  module Bamboo
    class Railtie < Rails::Railtie

      config.i18n_bamboo = ActiveSupport::OrderedOptions.new

      config.after_initialize do
        require 'i18n/bamboo/fertilizer' if config.i18n_bamboo.active
      end

    end
  end
end
