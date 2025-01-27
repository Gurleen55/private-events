class AddCascadeToEventAttendees < ActiveRecord::Migration[8.0]
  def change
    remove_foreign_key :event_attendees, :events, column: "attended_event_id"
    add_foreign_key :event_attendees, :events, column: "attended_event_id", on_delete: :cascade
  end
end
