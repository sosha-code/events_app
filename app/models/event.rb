class Event < ApplicationRecord
	belongs_to :person

	validates :title, :location, presence: true
	validates :date, presence: true, comparision: { greater_than_or_equal_to: Date.current}

	scope :upcoming, -> { where(date: Date.current..).order(date: :asc) }
	scope :next_seven_days, -> { where(date: Date.current..Date.current + 7).order(date: :asc) }
  scope :past, -> { where(date: ...Date.current).order(date: :desc) }
end
