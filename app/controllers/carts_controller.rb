class CartsController < ApplicationController
  skip_before_action :authorize, only: [:create, :update, :destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_cart

  # GET /carts
  # GET /carts.json




  def index
    @carts = Cart.all
  end

  # GET /carts/1
  # GET /carts/1.json
  def show
  end

  # GET /carts/new
  def new
    @cart = Cart.new
  end

  # GET /carts/1/edit
  def edit
  end

  # POST /carts
  # POST /carts.json
  def create
    @cart = Cart.new(cart_params)

    respond_to do |format|
      if @cart.save
        format.html { redirect_to @cart, notice: 'Cart was successfully created.' }
        format.json { render :show, status: :created, location: @cart }
      else
        format.html { render :new }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /carts/1
  # PATCH/PUT /carts/1.json
  def update
    respond_to do |format|
      if @cart.update(cart_params)
        format.html { redirect_to @cart, notice: 'Cart was successfully updated.' }
        format.json { render :show, status: :ok, location: @cart }
      else
        format.html { render :edit }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /carts/1
  # DELETE /carts/1.json
  def destroy
    # @cart.destroy
    # the following two lines add according to page no 140
    @cart.destroy if @cart.id == session[:cart_id]
    session[:cart_id] = nil

    respond_to do |format|

      format.html { redirect_to store_index_url }

      # the blow line commented because of above line according to page no 163

      # format.html { redirect_to store_index_url, notice: 'Your cart is currently empty' }

      # the blow line commented because of above lineaccording to page no 140
      # format.html { redirect_to carts_url, notice: 'Cart was successfully destroyed.' }

      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cart
      @cart = Cart.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cart_params
      params.fetch(:cart, {})
    end
    
  # the following method is introduce in page no 136
    def invalid_cart
     logger.error "Attempt to access invalid cart #{params[:id]}"
     redirect_to store_index_url, notice: 'Invalid cart'
     end
end
