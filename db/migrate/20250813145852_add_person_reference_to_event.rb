class AddPersonReferenceToEvent < ActiveRecord::Migration[7.1]
  def change
    add_reference :events, :person, null: false, foreign_key: true
  end
end
