require_relative 'test_helper.rb'
require_relative '../lib/merchant_repository.rb'

class MerchantRepositoryTest < Minitest::Test
  def test_merchant_repository_initializes
    merchant_repository = MerchantRepository.new('./test/fixtures/merchants_fix.csv')

    assert_instance_of MerchantRepository, merchant_repository
  end

  def test_merchant_repository_has_merchants
    merchant_repository = MerchantRepository.new('./test/fixtures/merchants_fix.csv')

    assert_equal 9, merchant_repository.all.count
    assert_instance_of Array, merchant_repository.all
    assert merchant_repository.all.all? { |merchant| merchant.is_a?(Merchant) }
    assert_equal 'Shopin1901', merchant_repository.all.first.name
  end

  def test_merchant_repository_can_be_searched_by_id
    merchant_repository = MerchantRepository.new('./test/fixtures/merchants_fix.csv')

    result = merchant_repository.find_by_id(12334112)

    assert_instance_of Merchant, result
    assert_equal 'Candisart', result.name
    assert_equal 12334112, result.id

    result_nil = merchant_repository.find_by_id(9000)

    assert_nil result_nil
  end

  def test_merchant_repository_can_be_searched_by_name
    merchant_repository = MerchantRepository.new('./test/fixtures/merchants_fix.csv')

    result = merchant_repository.find_by_name('Candisart')

    assert_instance_of Merchant, result
    assert_equal 'Candisart', result.name
    assert_equal 12334112, result.id

    result_nil = merchant_repository.find_by_name('Kung Foodoo: Caribbean Karate')

    assert_nil result_nil
  end

  def test_merchant_repository_can_find_all_by_name
    merchant_repository = MerchantRepository.new('./test/fixtures/merchants_fix.csv')

    result = merchant_repository.find_all_by_name('se')

    assert_instance_of Array, result
    assert_equal 'perlesemoi', result[0].name
    assert_equal 'Urcase17', result[1].name
    assert_equal 2, result.length

    result_nil = merchant_repository.find_all_by_name('Xtzxtx')

    assert_equal [], result_nil
  end
end