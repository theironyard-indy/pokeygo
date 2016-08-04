require 'csv'

Category.create!(name: "Pokestop") unless Category.find_by(name: "Pokestop")
Category.create!(name: "Gym") unless Category.find_by(name: "Gym")
Category.create!(name: "Pokemon") unless Category.find_by(name: "Pokemon")

types_of_sightings = %w(Pokemon Pokestop Gym)

users = 25.times.map do
  Trainer.create(
    email: Faker::Internet.email,
    password: 'playground',
    password_confirmation: 'playground'
  )
end

users = users.select{|u| u.persisted?}

puts users.length

if users.length > 0

  pokemon_names = CSV.foreach(Rails.root + 'vendor/data/pokemon.csv', headers: true).map{|row| row['identifier']}

  locations = CSV.foreach(Rails.root + 'vendor/data/indy_locs.csv')

  teams = %w(Mystic Instinct Valor)

  # 1 & 3
  locations.each do |loc|
    sighting = Sighting.new(
      trainer: users.sample,
      lat: loc[1],
      lng: loc[3],
      category: Category.order("RANDOM()").first
    )
    case sighting.category.name
    when "Pokemon"
      sighting.body = "I caught a #{pokemon_names.sample}!"
    when "Pokestop"
      sighting.body = "I got a bunch of stuff here. Check it out!"
    when "Gym"
      sighting.body = "Go Team #{teams.sample}!"
    end
    sighting.save
    puts sighting
  end
end
