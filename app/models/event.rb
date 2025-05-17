class Event < ApplicationRecord
  belongs_to :creator, class_name: "User"

  has_many :attendances, foreign_key: :attended_event_id
  has_many :attendees, through: :attendances, source: :attendee

  scope :past, -> { where("date < ?", Date.today).order(date: :desc) }
  scope :upcoming, -> { where("date >= ?", Date.today).order(date: asc) }
end
