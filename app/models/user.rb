class User < ApplicationRecord
  has_secure_password
  has_many :dogs
  validates :email, presence: true, uniqueness: true
end
