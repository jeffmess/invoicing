module Invoicing
  class InvoiceDecorator < ActiveRecord::Base
    belongs_to :invoice
    serialize :data

    attr_accessible :data
  end
end