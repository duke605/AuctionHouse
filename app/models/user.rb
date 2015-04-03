class User < ActiveRecord::Base
  MAX_ATTEMPTS = 3

  has_secure_password

  validates :email, :password_digest, presence: true
  validates :email, format: /[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,6}/, uniqueness: true
  validates :token, uniqueness: true, strict: true, on: :update

  # Generates a random token for user
  # @return the token that was generate, false if no token could be generated
  def generate_token
    attempts = 0

    begin
      self.token = SecureRandom.uuid
      save!

      self.expiry_date = 1.day.from_now
      save!
    rescue
      attempts += 1
      STDERR.puts 'Token collision!' unless attempts == MAX_ATTEMPTS

      retry if attempts < MAX_ATTEMPTS

      STDERR.puts 'Token collision! Max attempts exceeded!'
      return false
    end

    return self.token
  end

  # Class methods

  # @param token The token that will be searched for
  # @return the user the token is accosiated with, false if no accosiated
  def self.find_by_token(token)
    return false unless token # Returning unless token doesn't contain null
    user = find_by(token: token)

    if user != nil && user.expiry_date > Date.current
      return user
    end

    return false
  end
end
