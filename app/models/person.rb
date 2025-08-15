class Person < ApplicationRecord
	has_many :events, dependent: :destroy

	before_validation :normalize_email

	validates :name, presence: true
	validates :email, presence: true, 
	                  format: {with: /\A\S+@\S+\.\w+\z/} , 
	                  uniqueness: { case_sensitive: false }

	private

  def normalize_email
  	self.email = email.to_s.strip.downcase
  end
end
