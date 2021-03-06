# frozen_string_literal: true

require_relative 'test_helper.rb'
require_relative '../lib/transaction.rb'
require_relative '../lib/sales_engine.rb'
require_relative './test_engine.rb'

class TransactionTest < Minitest::Test
  def setup
    test_engine = TestEngine.new.test_hash
    @sales_engine = SalesEngine.new(test_engine)
    @transaction = Transaction.new(
      {
        id:                          6,
        invoice_id:                  8,
        credit_card_number:          '4242424242424242',
        credit_card_expiration_date: '0220',
        result:                      'success',
        created_at:                  '2011-08-29 19:23:23 UTC',
        updated_at:                  '2006-12-25 19:23:23 UTC'
      },
      @sales_engine.transactions
    )
  end

  def test_it_exists
    transaction = @transaction

    assert_instance_of Transaction, transaction
  end

  def test_transaction_attributes_accessible
    transaction = @transaction

    assert_equal 6, transaction.id
    assert_equal 8, transaction.invoice_id
    assert_equal 4_242_424_242_424_242, transaction.credit_card_number
    assert_equal '0220', transaction.credit_card_expiration_date
    assert_equal 'success', transaction.result
    assert_instance_of Time, transaction.created_at
  end

  def test_transaction_can_have_different_attributes
    transaction = Transaction.new(
      {
        id:                          13,
        invoice_id:                  88,
        credit_card_number:          '4343434343434343',
        credit_card_expiration_date: '0330',
        result:                      'failed',
        created_at:                  '2011-08-29 19:23:23 UTC',
        updated_at:                  '2006-12-25 19:23:23 UTC'
      },
      @sales_engine.transactions
    )

    assert_equal 13, transaction.id
    assert_equal 88, transaction.invoice_id
    assert_equal 4_343_434_343_434_343, transaction.credit_card_number
    assert_equal '0330', transaction.credit_card_expiration_date
    assert_equal 'failed', transaction.result
    assert_instance_of Time, transaction.created_at
  end

  def test_transaction_to_repo_to_engine_can_return_invoice
    result = @transaction.invoice

    assert_equal 8, result.id
    assert_equal 1, result.customer_id
    assert_equal 12_334_266, result.merchant_id
    assert_equal :shipped, result.status
  end
end
