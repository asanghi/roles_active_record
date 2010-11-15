require 'roles_active_record/strategy/single'

module RoleStrategy::ActiveRecord
  module AdminFlag    
    def self.default_role_attribute
      :admin_flag
    end

    def self.included base
      base.extend ClassMethods
    end

    module ClassMethods 
      def role_attribute
        strategy_class.roles_attribute_name.to_sym
      end
           
      def in_role(role_name) 
        case role_name.downcase.to_sym
        when :admin
          where(role_attribute => true)
        else
          where(role_attribute => false)
        end          
      end
    end

    module Implementation
      include Roles::ActiveRecord::Strategy::Single

      def new_role role
        role = role.kind_of?(Array) ? role.flatten.first : role
        role.admin?
      end
      
      def new_roles *roles
        new_role roles.flatten.first
      end      
      
      def get_role
        self.send(role_attribute) ? strategy_class.admin_role_key : strategy_class.default_role_key
      end 
      
      def present_roles *roles
        roles.map{|role| role ? :admin : :guest}
      end   
      
      def set_empty_role
        self.send("#{role_attribute}=", false)
      end      

    end # Implementation
    
    extend Roles::Generic::User::Configuration
    configure :num => :single
  end   
end
