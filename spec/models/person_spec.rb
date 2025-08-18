require "rails_helper"

RSpec.describe Person, type: :model do
	describe "#validations" do
		subject { described_class.new(name: name, email: email) }
	  let(:name) { "john" }
	  let(:email) { "john@example.com" }

    context "with valid attributes" do
    	it { is_expected.to be_valid }
    end

    context "when name is empty" do
    	let(:name) { "" }

    	it { is_expected.to be_invalid }
    	
    	it "adds a can't be blank error" do
    		subject.validate
        expect(subject.errors[:name]).to include("can't be blank")
      end
    end

    context "when email is empty" do
    	let(:email) { "" }

    	it { is_expected.to be_invalid }

    	it "adds error" do
    		subject.validate
    		expect(subject.errors[:email]).to include("can't be blank") 
    	end
    end    

    context "when email format is incorrect" do
    	let(:email) { "john@example" }

    	it { is_expected.to be_invalid }

    	it "adds error" do
    		subject.validate
    		expect(subject.errors[:email]).to include("is invalid") 
    	end
    end

    context "when email is inconsistent with trailing space or case" do
    	let(:email) { " John@Example.com " }

    	it "normalize email" do
    		subject.validate
    		expect(subject.email).to eq("john@example.com")
    	end
    end
  end		

  describe "#associations" do
  	let(:person) { Person.create(name: "john", email: "john_#{SecureRandom.hex(4)}@example.com")}
  	let!(:event) { Event.create(title: "Boot Camp", 
  		                         location: "Dallas, tx", 
  		                         date: Date.current + 2, 
  		                         person: person )}

  	it "has associated events" do
  	  expect(person.events).to include(event)
  	end

  	it "destroys associated events when person is destroyed" do
  		expect { person.destroy }.to change { Event.count }.from(1).to(0)
  	end
  end
end 