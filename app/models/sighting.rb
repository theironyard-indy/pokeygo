class Sighting < ApplicationRecord
  belongs_to :trainer
  belongs_to :category

  acts_as_mappable
  before_validation :geocode_address, :on => :create

  def map_icon
    case category.name
    when "Pokemon"
      "Pokeball.png"
    when "Pokestop"
      "pokemon-moltres.png"
    when "Gym"
      "fight.png"
    end
  end

  private
  def geocode_address
    if lat.blank? || lng.blank?
      geo=Geokit::Geocoders::MultiGeocoder.geocode (full_address)
      errors.add(:full_address, "Could not Geocode address") if !geo.success
      self.lat, self.lng = geo.lat,geo.lng if geo.success
    end
  end
end
