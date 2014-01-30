class User < ActiveRecord::Base
  validates :username, uniqueness: true,
                      length: {minimum: 3}

  has_many :projects

has_secure_password

end