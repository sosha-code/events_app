require "rails_helper"

RSpec.describe Event, type: :model do 
	  include ActiveSupport::Testing::TimeHelpers

	describe "#validations" do
	  let(:person) { Person.create!(name: "john", email: "john_#{SecureRandom.hex(4)}@example.com") }

	  # Provide valid defaults
	  let(:title)   { "Boot Camp" }
	  let(:location){ "Dallas, TX" }
	  let(:date)    { Date.current + 2 }

	  subject { described_class.new(title: title, location: location, date: date, person: person) }

    context "with valid attributes" do
    	it { is_expected.to be_valid }
    end

    context "when title is empty" do
    	let(:title) { "" }

    	it { is_expected.to be_invalid }
    	
    	it "adds a can't be blank error" do
    		subject.validate
        expect(subject.errors[:title]).to include("can't be blank")
      end
    end    

    context "when location is empty" do
    	let(:location) { "" }

    	it { is_expected.to be_invalid }
    	
    	it "adds a can't be blank error" do
    		subject.validate
        expect(subject.errors[:location]).to include("can't be blank")
      end
    end    

    context "when date is past" do
    	let(:date) { Date.current - 2 }
    	
    	it "adds a can't be blank error" do
    		is_expected.to be_invalid
        expect(subject.errors[:date]).to include(a_string_including("must be greater than or equal"))
      end
    end
	end

	describe ".scopes" do
		person = Person.create!(name: "john", email: "john_#{SecureRandom.hex(4)}@example.com") 
    
    it "returns .past and .upcoming" do
	    travel_to Date.new(2025, 8, 10) do
			  @past = Event.create!(title: "Y", location: "X", date: Date.new(2025, 8, 12),  person:) 
			  @today = Event.create!(title: "T", location: "D", date: Date.new(2025, 8, 15), person: ) 
				@future = Event.create!(title: "I7", location: "D7", date: Date.new(2025, 8, 16), person:  ) 
				@next_7_days = Event.create!(title: "I8", location: "D8", date: Date.new(2025, 8, 20), person:  ) 
	    end
	    travel_to Date.new(2025, 8, 15) do
			  expect(Event.past).to include(@past)
			  expect(Event.upcoming).to include(@future)
			  expect(Event.next_seven_days).to match_array([@today, @future, @next_7_days])
			end 
		end

	end
end