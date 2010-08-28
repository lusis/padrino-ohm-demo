require 'digest/sha1'

class Account < Ohm::Model
  include Ohm::Timestamping
  include Ohm::Typecast
  include Ohm::ExtraValidations
  include Ohm::Callbacks
  include Ohm::Boundaries
  include Ohm::LengthValidations

  attr_accessor :password, :password_confirmation

  # Properties
  attribute :name,             String
  attribute :surname,          String
  attribute :email,            String
  attribute :crypted_password, String
  attribute :salt,             String
  attribute :role,             String

  %w[email role].each do |idx|
    index idx.to_sym
  end

  def assert_confirmation_of(att, error = [att, :does_not_match])
    if assert_present(att, error)
      m = send(att).to_s
      n = "#{m}_confirmation".to_sym.to_s
      assert does_match?(m,n), error
    end

    private
    def does_match?(string, confirmation)
      string == confirmation
    rescue ArgumentError
      return false
    end
  end



  def validate
    super
    assert_present          :email, :role
    assert_present          :password if password_required
    assert_present          :password_confirmation if password_required

    assert_email            :email unless email.blank?
    assert_format           :role, /[A-Za-z]/ unless role.blank?
    assert_unique           :email
    # The following depends on my commit to ohm-contrib
    # otherwise I'll have to add the validation inline
    assert_min_length       :password, 4 if password_required
    assert_max_length       :password, 40 if password_required
    assert_min_length       :email, 3
    assert_max_length       :email, 100
    assert_confirmation_of  :password if password_required

    # TODO
    # The following validations need to be converted for ohm

    #validates_confirmation_of  :password,                          :if => :password_required
  end

  ##
  # This method is for authentication purpose
  #
  def self.authenticate(email, password)
    account = first(:email => email) if email.present?
    account && account.password_clean == password ? account : nil
  end

  ##
  # This method is used by AuthenticationHelper
  #
  def self.find_by_id(id)
    self[id] rescue nil
  end

  ##
  # This method is used to retrieve the original password.
  #
  def password_clean
    crypted_password.decrypt(salt)
  end

  ###
  # Password setter generates salt and crypted_password
  #
  def password=(val)
    return if val.blank?
    update_attributes(:salt => Digest::SHA1.hexdigest("--#{Time.now.to_s}--#{email}--")) if new?
    update_attributes(:crypted_password => val.encrypt(self.salt))
  end

  private

    def password_required
      crypted_password.blank? || !password.blank?
    end
end
