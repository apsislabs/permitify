module Permitify
  class Utils
    def self.roles_for_permission(permissions)
      permissions = Array.wrap(permissions)
      Permitify.permissions.select {|r, p| (p & permissions).present? }.keys
    end

    def self.permissions_for_roles(roles)
      Array.wrap(roles).map do |role|
        Permitify.permissions[role]
      end.flatten
    end

    def self.validate_role(role)
      unless Permitify.roles.include?(role)
        raise Exceptions::InvalidRoleException.new "Invalid Role: #{role}"
      end
    end
  end
end
