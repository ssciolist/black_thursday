# frozen_string_literal: true

require 'csv'
require_relative 'transaction.rb'

# builds transaction repository class
class TransactionRepository
  def initialize(filepath, parent)
    @transactions = []
    @parent = parent
    load_items(filepath)
  end

  def all
    @transactions
  end

  def load_items(filepath)
    CSV.foreach(filepath, headers: true, header_converters: :symbol) do |row|
      @transactions << Transaction.new(row, self)
    end
  end

  def find_by_id(id)
    @transactions.find do |transaction|
      transaction.id == id
    end
  end

  def find_all_by_invoice_id(invoice_id)
    @transactions.find_all do |transaction|
      transaction.invoice_id == invoice_id
    end
  end

  def find_all_by_credit_card_number(cc_number)
    @transactions.find_all do |transaction|
      transaction.credit_card_number == cc_number
    end
  end

  def find_all_by_result(res)
    @transactions.find_all do |transaction|
      transaction.result == res
    end
  end

  def transaction_repo_finds_invoice_via_engine(id)
    @parent.engine_finds_invoice_via_invoice_id(id)
  end

  def inspect
    "#<#{self.class} #{@transactions.size} rows>"
  end
end
