class User < ActiveRecord::Base

  has_secure_password

  validates :email, presence: true
  validates :email, uniqueness: true

  validates :password, presence: true
  validates :password_confirmation, presence: true

  # validates :auth_token, presence: true
  validates :auth_token, uniqueness: true

  validates :password_digest, presence: true
  validates :password_digest, uniqueness: true

  before_create -> { self.auth_token = SecureRandom.hex }

end
