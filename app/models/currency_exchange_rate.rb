# frozen_string_literal: true

class CurrencyExchangeRate < ApplicationRecord

  validates :base_currency, presence: true
  validates :target_currency, presence: true
  validates :rate, presence: true
  validates :date, presence: true

  def self.exists_for_date?(date)
    CurrencyExchangeRate.find_by(date: date).present?
  end

end
