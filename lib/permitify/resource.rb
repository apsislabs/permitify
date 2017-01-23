module Permitify
  module Resource
    extend ActiveSupport::Concern

    class_methods do
      def with_permission(permission, user = nil)
        role_names = Permitify::Utils.roles_for_permission(permission)
        self.with_role(role_names, user)
      end
      alias :with_permissions :with_permission

      def without_permission(permission, user = nil)
        role_names = Permitify::Utils.roles_for_permission(permission)
        self.without_role(role_names, user)
      end
      alias :without_permissions :without_permission
    end
  end
end
