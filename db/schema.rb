# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_01_29_222626) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "event_attendees", force: :cascade do |t|
    t.bigint "attendee_id", null: false
    t.bigint "attended_event_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["attended_event_id"], name: "index_event_attendees_on_attended_event_id"
    t.index ["attendee_id", "attended_event_id"], name: "index_event_attendees_on_attendee_id_and_attended_event_id", unique: true
    t.index ["attendee_id"], name: "index_event_attendees_on_attendee_id"
  end

  create_table "event_invitees", force: :cascade do |t|
    t.bigint "event_id", null: false
    t.bigint "user_id", null: false
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_event_invitees_on_event_id"
    t.index ["user_id"], name: "index_event_invitees_on_user_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "title"
    t.date "date"
    t.string "location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_events_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "event_attendees", "events", column: "attended_event_id", on_delete: :cascade
  add_foreign_key "event_attendees", "users", column: "attendee_id"
  add_foreign_key "event_invitees", "events"
  add_foreign_key "event_invitees", "users"
  add_foreign_key "events", "users"
end
