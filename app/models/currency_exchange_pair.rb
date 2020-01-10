class CurrencyExchangePair < ApplicationRecord
  validates :base_currency, presence: true
  validates :target_currency, presence: true
  validates :number_of_weeks, presence: true
  validates :amount, presence: true

  def fetch_historic_data
    target_rates = fetch_exchange_rates(target_currency)
    base_rates = nil
    base_rates = fetch_exchange_rates(base_currency) if conversion_needed?
    process_exchange_rates(target_rates, base_rates)
  end

  private

  def fetch_exchange_rates(currency)
    start_date, end_date = calculate_dates(number_of_weeks)
    CurrencyExchangeRate.where(date: start_date..end_date, target_currency: currency).pluck(:date, :rate)
  end

  # TBD: needs refactoring
  def process_exchange_rates(target_rates, base_rates)
    rates = []
    target_rates.each_with_index do |target_rate, index|
      rate = []
      rate[0] = target_rate[0]
      rate[1] = if conversion_needed?
                  calculate_exchange_rate(base_rates[index][1], target_rate[1])
                else
                  target_rate[1]
                end
      rates << rate
    end
    rates
  end

  def calculate_dates(week_number)
    start_date = (Date.today - week_number.weeks).beginning_of_week
    [start_date, Date.today]
  end

  def conversion_needed?
    base_currency != global_base_currency
  end

  def global_base_currency
    ENV['BASE_CURRENCY'] || 'EUR'
  end

  # TBD
  def calculate_exchange_rate(base_rate, target_rate)
    (target_rate / base_rate)
  end
end
