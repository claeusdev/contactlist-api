class Contact < ApplicationRecord
  validates :first_name, :last_name, :email, :phone_number, presence: true
  validates :email, uniqueness: true

  has_many :edit_logs, dependent: :delete_all

  before_update :log_changes

  def log_changes
    return unless changed?

    changed.each do |attr|
      EditLog.create(contact_id: id, field: attr, new_value: attributes[attr], old_value: changed_attributes[attr])
    end
  end
end
