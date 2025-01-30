class Event < ApplicationRecord
  belongs_to :creator, class_name: "User", foreign_key: "user_id"
  has_many :event_attendees, foreign_key: :attended_event_id
  has_many :attendees, through: :event_attendees, source: :attendee
  has_many :event_invitees, dependent: :destroy
  has_many :invitees, through: :event_invitees, source: :user

  # def self.past
  #   self.where(date: ..Date.today)
  # end

  # def self.future
  #   self.where(date: Date.today..)
  # end

  scope :past, -> { where(date: ..Date.today) }
  scope :future, -> { where(date: Date.today..) }
end
