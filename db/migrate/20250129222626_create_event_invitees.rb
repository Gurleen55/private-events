class CreateEventInvitees < ActiveRecord::Migration[8.0]
  def change
    create_table :event_invitees do |t|
      t.references :event, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
