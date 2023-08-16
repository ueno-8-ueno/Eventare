class Event < ApplicationRecord
  belongs_to :user

  validates :name, presence: true
  validates :introduction, presence: true
  validates :genre, presence: true
  validates :start_at, presence: true
  validates :end_at, presence: true

end
