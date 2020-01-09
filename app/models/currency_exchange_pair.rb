class CurrencyExchangePair < ApplicationRecord
  BASE_CURRENCY = 'EUR'

  # TBD: exchange rate incase base currency other then EUR
  def fetch_historic_data
    exchange_rates = fetch_exchange_rates(target_currency)
    process_exchange_rates(exchange_rates)
  end  

private

  def fetch_exchange_rates(currency)
    start_date, end_date = calculate_dates(number_of_weeks)
    CurrencyExchangeRate.where(date: start_date..end_date).where(target_currency: currency).pluck(:date, :rate)
  end

  # TBD: wrapper to process data incase base currency other then EUR
  def process_exchange_rates(exchange_rates)
    exchange_rates
  end
 
  def calculate_dates(week_number)
    start_date = (Date.today - week_number.weeks).beginning_of_week
    [start_date, Date.today]
  end

  def conversion_needed?
    base != BASE_CURRENCY
  end
end
