module Permitify
  module Configure
    @@permissions = {}
    @@roles = []
    @@permissions_file = "permissions.yml"

    def configure
      yield self if block_given?
    end

    def permissions
      @@permissions
    end

    def permissions=(value)
      @@permissions = value
    end

    def roles
      @@roles
    end

    def roles=(value)
      @@roles = value
    end

    def permissions_file
      @@permissions_file
    end

    def permissions_file=(value)
      @@permissions_file = value
    end
  end
end
