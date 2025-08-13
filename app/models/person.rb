class Person < ApplicationRecord
	has_many :events, dependent: :destroy

	validates :name, presence: true
	validates :email, presence: true, format: {with: /\A\S+@\S+\.\w+\z/} , uniqueness: { case_sensitive: false }
end
