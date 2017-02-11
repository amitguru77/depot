class LineItemsController < ApplicationController

  include CurrentCart
  before_action :set_cart, only: [:create]

  before_action :set_line_item, only: [:show, :edit, :update, :destroy]

  # GET /line_items
  # GET /line_items.json
  def index
    @line_items = LineItem.all
  end

  # GET /line_items/1
  # GET /line_items/1.json
  def show
  end

  # GET /line_items/new
  def new
    @line_item = LineItem.new
  end

  # GET /line_items/1/edit
  def edit
  end

  # POST /line_items
  # POST /line_items.json
  def create
    product = Product.find(params[:product_id])
    @line_item = @cart.add_product(product)

    # the following one  line commented according to #130 page number
    # @line_item = @cart.line_items.build(product: product)
    # following line commented to overwrite as given in cart chapter.
    # @line_item = LineItem.new(line_item_params)

    respond_to do |format|
      if @line_item.save
        # format.html { redirect_to @line_item.cart }
        # the above line is commented by as direction on page 151
        format.html { redirect_to store_index_url }
        # the following line is commented because of above line according to page no 141
        # format.html { redirect_to @line_item.cart,notice: 'Line item was successfully created.' }
        # format.html { redirect_to @line_item, notice: 'Line item was successfully created.' }

        # the next line is added due to instruction given on page no 155
        # format.js
        # above line is commented because we add next line according to page no 159
        format.js { @current_item = @line_item }
        format.json { render :show, status: :created, location: @line_item }
      else
        format.html { render :new }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /line_items/1
  # PATCH/PUT /line_items/1.json
  def update
    respond_to do |format|
      if @line_item.update(line_item_params)
        format.html { redirect_to @line_item, notice: 'Line item was successfully updated.' }
        format.json { render :show, status: :ok, location: @line_item }
      else
        format.html { render :edit }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /line_items/1
  # DELETE /line_items/1.json
  def destroy
    @line_item.destroy
    respond_to do |format|
      format.html { redirect_to line_items_url, notice: 'Line item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_line_item
      @line_item = LineItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def line_item_params
      # params.require(:line_item).permit(:product_id, :cart_id)
      # above line is commented due to following line instruction given on page no 138
      params.require(:line_item).permit(:product_id)
    end
end