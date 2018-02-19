require 'bigdecimal'
class Item
  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :merchant_id,
              :created_at,
              :updated_at

  def initialize(data)
    @id = data[:id].to_i
    #get input ^^ do we want that to be an integer for any reason?
    @name = data[:name]
    @description = data[:description]
    @unit_price  = BigDecimal.new(data[:unit_price])
    @merchant_id = data[:merchant_id].to_i
    @created_at  = data[:created_at]
    @updated_at  = data[:updated_at]
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end
end