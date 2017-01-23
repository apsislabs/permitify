require 'permitify'
require 'rails'

module Permitify
  class Railtie < Rails::Railtie
    initializer 'permitify.initialize' do

      ActiveSupport.on_load(:active_record) do
        ActiveRecord::Base.send :extend, Permitify
      end

      config.before_initialize do
        roles = YAML.load_file(Rails.root.join('config/', Permitify.permissions_file))["roles"]

        if roles.present?
          # Convert Permission Strings to Symbols
          permissions = roles.inject({}) do |result, (role, perms)|
            result[role] = perms.map(&:to_sym)
            result
          end

          Permitify.roles = roles.keys.map(&:to_sym)
          Permitify.permissions = permissions.with_indifferent_access
        end
      end
    end
  end
end
