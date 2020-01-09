class CurrencyExchangePairsController < ApplicationController
  before_action :set_currency_exchange_pair, only: [:show, :edit, :update, :destroy]

  # GET /currency_exchange_pairs
  # GET /currency_exchange_pairs.json
  def index
    @currency_exchange_pairs = CurrencyExchangePair.all
  end

  # GET /currency_exchange_pairs/1
  # GET /currency_exchange_pairs/1.json
  def show
    @data = @currency_exchange_pair.fetch_historic_data
  end

  # GET /currency_exchange_pairs/new
  def new
    @currency_exchange_pair = CurrencyExchangePair.new
  end

  # GET /currency_exchange_pairs/1/edit
  def edit
  end

  # POST /currency_exchange_pairs
  # POST /currency_exchange_pairs.json
  def create
    @currency_exchange_pair = CurrencyExchangePair.new(currency_exchange_pair_params)

    respond_to do |format|
      if @currency_exchange_pair.save
        format.html { redirect_to @currency_exchange_pair, notice: 'Currency exchange pair was successfully created.' }
        format.json { render :show, status: :created, location: @currency_exchange_pair }
      else
        format.html { render :new }
        format.json { render json: @currency_exchange_pair.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /currency_exchange_pairs/1
  # PATCH/PUT /currency_exchange_pairs/1.json
  def update
    respond_to do |format|
      if @currency_exchange_pair.update(currency_exchange_pair_params)
        format.html { redirect_to @currency_exchange_pair, notice: 'Currency exchange pair was successfully updated.' }
        format.json { render :show, status: :ok, location: @currency_exchange_pair }
      else
        format.html { render :edit }
        format.json { render json: @currency_exchange_pair.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /currency_exchange_pairs/1
  # DELETE /currency_exchange_pairs/1.json
  def destroy
    @currency_exchange_pair.destroy
    respond_to do |format|
      format.html { redirect_to currency_exchange_pairs_url, notice: 'Currency exchange pair was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_currency_exchange_pair
      @currency_exchange_pair = CurrencyExchangePair.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def currency_exchange_pair_params
      params.require(:currency_exchange_pair).permit(:base_currency, :target_currency, :number_of_weeks)
    end
end
