class Trainer < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :sightings

  def name
    "Trainer ##{id}"
  end

end
