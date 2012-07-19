module Invoicing
  class LineItem < ActiveRecord::Base
    belongs_to :invoice
    belongs_to :invoiceable, polymorphic: true

    attr_accessible :invoiceable, :amount, :tax, :description
    
    def net_amount
      amount - tax
    end
  end
end