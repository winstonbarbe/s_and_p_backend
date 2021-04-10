class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: true
  # validates :password, length: { in: 6..20 }
  
  def is_allowed(passed_id)
    admin || passed_id == id
  end
end
