Category.create!(name: "Pokestop") unless Category.find_by(name: "Pokestop")
Category.create!(name: "Gym") unless Category.find_by(name: "Gym")
Category.create!(name: "Pokemon") unless Category.find_by(name: "Pokemon")
