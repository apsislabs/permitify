module Permitify
  module Permission
    extend ActiveSupport::Concern

    def has_permission?(permission, resource = nil)
      applicable_roles = self.role_symbols(permission).select do |r|
        self.has_role?(r, resource) || self.has_role?(r, resource.class)
      end

      Permitify::Utils.permissions_for_roles(applicable_roles).include?(permission)
    end
    alias :can? :has_permission?

    def add_role(role_name, resource = nil)
      Permitify::Utils.validate_role(role_name)
      super
    end

    def role_symbols(permission)
      self.roles.pluck(:name).map(&:to_sym)
    end

    def method_missing(method_sym, *args, &block)
      if method_sym.to_s.match(/^(\w+)_for_permission$/)
        self.class.define_dynamic_permission_scope(method_sym, $1)
        send(method_sym, args.first)
      else
        super
      end
    end

    class_methods do
      def with_permission(permission, resource = nil)
        role_names = Permitify::Utils.roles_for_permission(permission)
        users = []

        role_names.each do |role|
          users_to_add = self.with_role(role, resource)
          users = users_to_add if users.empty?
          users = users_to_add.or(users) unless users.empty?
        end

        return users.distinct
      end
      alias :with_permissions :with_permission

      def define_dynamic_permission_scope(method_sym, class_sym)
        class_eval do
          define_method(method_sym) do |permission|
            klass = class_sym.to_s.classify.constantize rescue nil

            if klass.present? && klass.respond_to?(:with_permission)
              klass.with_permission(permission, self)
            end
          end unless method_defined?(method_sym)
        end
      end
    end
  end
end
