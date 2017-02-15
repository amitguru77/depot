class LineItem < ApplicationRecord
  belongs_to :order, optional: true
  belongs_to :product, optional: true
  belongs_to :product
  belongs_to :cart

# the total_price method is written according to page number 141
  def total_price
	product.price * quantity
  end

end
