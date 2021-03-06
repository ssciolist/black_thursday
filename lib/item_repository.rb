# frozen_string_literal: true

require 'csv'
require_relative 'item.rb'

# builds item repository class
class ItemRepository
  def initialize(filepath, parent)
    @items = []
    @parent = parent
    load_items(filepath)
  end

  def all
    @items
  end

  def load_items(filepath)
    CSV.foreach(filepath, headers: true, header_converters: :symbol) do |row|
      @items << Item.new(row, self)
    end
  end

  def find_by_id(id)
    @items.find do |item|
      item.id == id
    end
  end

  def find_by_name(name)
    @items.find do |item|
      item.name.downcase == name.downcase
    end
  end

  def find_all_with_description(my_description)
    @items.find_all do |item|
      item.description.downcase.include?(my_description.downcase)
    end
  end

  def find_all_by_price(price)
    @items.find_all do |item|
      item.unit_price == price
    end
  end

  def find_all_by_price_in_range(range)
    @items.find_all do |item|
      item.unit_price.between?(range.begin, range.end)
    end
  end

  def find_all_by_merchant_id(merchant_id)
    @items.find_all do |item|
      item.merchant_id == merchant_id
    end
  end

  def item_repo_finds_merchant_via_engine(id)
    @parent.engine_finds_merchant_via_merchant_repo(id)
  end

  def inspect
    "#<#{self.class} #{@items.size} rows>"
  end
end
