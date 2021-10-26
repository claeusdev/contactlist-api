class ContactSerializer
  include JSONAPI::Serializer
  attributes :first_name, :last_name, :email, :phone_number

  has_many :edit_logs, serializer: EditLogSerializer
end
