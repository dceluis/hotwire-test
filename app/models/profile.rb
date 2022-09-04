class Profile < ApplicationRecord
  validates :first_name, :last_name, :nickname, :email, :phone, presence: true

  validates_format_of :email, with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
  validates_format_of :phone, with: /\A[0-9]{3}-[0-9]{3}-[0-9]{4}\z/

  has_many :employments, dependent: :destroy

  def full_name
    "#{first_name} #{last_name}"
  end
end
