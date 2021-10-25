class Contact < ApplicationRecord
  validates :first_name, :last_name, :email, :phone_number, presence: true
  validates :email, uniqueness: true
end
