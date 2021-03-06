# frozen_string_literal: true

require 'bigdecimal'
require 'time'

# builds item class
class Item
  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :merchant_id,
              :created_at,
              :updated_at
  def initialize(data, parent)
    @id          = data[:id].to_i
    @name        = data[:name]
    @description = data[:description]
    @unit_price  = BigDecimal.new(data[:unit_price]) / 100
    @merchant_id = data[:merchant_id].to_i
    @created_at  = Time.parse(data[:created_at])
    @updated_at  = Time.parse(data[:updated_at])
    @parent      = parent
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end

  def merchant
    @parent.item_repo_finds_merchant_via_engine(@merchant_id)
  end
end
