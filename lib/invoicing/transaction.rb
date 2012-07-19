module Invoicing
  class Transaction < ActiveRecord::Base
    belongs_to :invoice

    attr_accessible :amount
    
    def debit?
      false
    end
    
    def credit?
      false
    end
  end
end