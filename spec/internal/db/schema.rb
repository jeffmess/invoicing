ActiveRecord::Schema.define do
  
  create_table "invoicing_late_payments", :force => true do |t|
    t.integer  "invoice_id"
    t.datetime "penalty_date"
    t.boolean  "processed"
    t.timestamps
  end
  
  create_table "invoicing_line_items", :force => true do |t|
    t.integer "invoice_id"
    t.string  "description"
    t.float   "amount"
    t.timestamps
  end
  
  create_table "invoicing_transactions", :force => true do |t|
    t.integer "invoice_id"
    t.string  "type"
    t.float   "amount"
    t.timestamps
  end
  
  create_table "invoicing_invoices", :force => true do |t|
    t.string   "invoice_number"
    t.datetime "due_date"
    t.float    "total"
    t.float    "vat_amount"
    t.float    "balance"
    t.timestamps
  end
  
end