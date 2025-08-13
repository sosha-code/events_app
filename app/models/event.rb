class Event < ApplicationRecord
	belongs_to :person, dependent: :destroy

	validates :title, :location, presence: true
	validate :date_cannot_be_in_past

	private

	def date_cannot_be_in_past
		return errors.add(:date, "cannot be empty") if date.nil?

		unless date >= Date.today
			errors.add(:date, "cannot be in past")
		end
	end
end
