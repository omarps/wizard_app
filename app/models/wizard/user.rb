module Wizard
  module User
    STEPS = %w(step1 step2 step3 step4 step5).freeze
    
    # Base class to avoid load all the user's attributes.
    class Base
      include ActiveModel::Model
      attr_accessor :user
      
      # map attributes to user
      delegate *::User.attribute_names.map { |attr| [attr, "#{attr}="] }.flatten, to: :user
      
      # constructor
      def initialize(user_attributes)
        @user = ::User.new(user_attributes)
      end
    end
    
    # step 1: first_name and last_name
    class Step1 < Base
      validates :first_name, presence: true
      validates :last_name, presence: true
    end
    
    # step 2: step1 + email_address
    class Step2 < Step1
      # note: very basic email validation.
      validates :email_address, presence: true, format: { with: /@/ }
    end
  end
end