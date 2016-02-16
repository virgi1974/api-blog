class User < ActiveRecord::Base
  validates :email, presence: true
  validates :email, uniqueness: true
  validates :password, presence: true
  validates :auth_token, presence: true
  validates :auth_token, uniqueness: true

end
