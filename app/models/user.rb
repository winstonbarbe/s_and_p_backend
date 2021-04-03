class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: true
  # validates :password, length: { in: 6..20 }

  def change_password(passwords)
    first_test = Proc.new { |key| key ? }
  end
end
