module Invoicing
  class Invoice < ActiveRecord::Base
    has_many :line_items
    has_many :transactions
    has_one :late_payment
  
    before_save :calculate_totals, :calculate_balance
    after_create :create_initial_transaction!
    
    def add_line_item(params)
      self.line_items << LineItem.new(params)
    end
    
    def add_debit_transaction(params)
      self.transactions << DebitTransaction.new(params)
    end
    
    def add_credit_transaction(params)
      self.transactions << CreditTransaction.new(params)
    end
    
    def calculate_totals
      self.total = line_items.inject(0) {|res, item| res + item.amount.to_f}
      self.vat_amount = 0 # fix
    end
      
    def create_initial_transaction!
      if total < 0
        add_credit_transaction amount: total
      else
        add_debit_transaction amount: total
      end

      save!
    end
      
    def debit_transactions
      transactions.select{|t| t.is_a? DebitTransaction}
    end
      
    def credit_transactions
      transactions.select{|t| t.is_a? CreditTransaction}
    end
      
    def calculate_balance
      self.balance = (0 - debit_transactions.sum(&:amount)) + credit_transactions.sum(&:amount)
    end
      
    def settled?
      balance == 0
    end
      
    def owing?
      balance < 0
    end
      
    def due_date_past?
      due_date.to_date < Date.today
    end
      
    def overdue?
      owing? and due_date_past?
    end
    
    def self.owing
      where("balance < ?", 0)
    end
  
  end
end