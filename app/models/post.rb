class Post < Ohm::Model
  include Ohm::Timestamping
  include Ohm::Typecast

  # Examples:
  # attribute :name
  # attribute :email, String 
  # reference :venue, Venue
  # set :participants, Person
  # counter :votes
  #
  # index :name
  #
  # def validate
  #   assert_present :name
  # end

  attribute :title, String
  attribute :author, String
  attribute :body, String
end
