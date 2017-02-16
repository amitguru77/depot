class StoreController < ApplicationController

	skip_before_action :authorize

	# folloing two lines are added according to page no 149
	 include CurrentCart
	 before_action :set_cart
  def index
  	@products = Product.order(:title)
  	# @products = Product.order(:title)
  end
end
