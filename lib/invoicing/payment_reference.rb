module Invoicing
  
  class PaymentReference < ActiveRecord::Base

  	attr_accessible :reference
    
    belongs_to :invoice
    
    
  end
  
end