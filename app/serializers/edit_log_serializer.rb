class EditLogSerializer
  include JSONAPI::Serializer
  attributes :field, :title, :description, :new_value, :old_value
  attribute :titlize do |object|
    "Changed #{object.field} from #{object.old_value} to #{object.new_value}"
  end
end
