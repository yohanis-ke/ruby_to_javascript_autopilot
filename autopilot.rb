
def get_new_car
  {
    city: 'Toronto',
    passengers: 0,
    gas: 100,
  }
end

def add_car(cars, new_car)
  cars << new_car
  "Adding new car to fleet. Fleet size is now #{cars.length}."
end

def pick_up_passenger(car)
  car[:passengers] += 1
  car[:gas] -= 10
  "Picked up passenger. Car now has #{car[:passengers]} passengers."
end

def get_destination(car)
  if car[:city] == 'Toronto'
    'Mississauga'
  elsif car[:city] == 'Mississauga'
    'London'
  elsif car[:city] == 'London'
    'Toronto'
  end
end

def fill_up_gas(car)
  old_gas = car[:gas]
  car[:gas] = 100
  "Filled up to #{ get_gas_display(car[:gas]) } on gas from #{ get_gas_display(old_gas) }."
end

def get_gas_display(gas_amount)
  "#{gas_amount}%"
end

def drive(car, city_distance)
  if car[:gas] < city_distance
    return fill_up_gas(car)
  end

  car[:city] = get_destination(car)
  car[:gas] -= city_distance
  "Drove to #{car[:city]}. Remaining gas: #{ get_gas_display(car[:gas]) }."
end

def drop_off_passengers(car)
  previous_passengers = car[:passengers]
  car[:passengers] = 0
  "Dropped off #{previous_passengers} passengers."
end

def act(car)
  distance_between_cities = 50

  if car[:gas] < 20
    fill_up_gas(car)

  elsif car[:passengers] < 3
    pick_up_passenger(car)

  else
    if car[:gas] < distance_between_cities
      return fill_up_gas(car)
    end
    drove_to = drive(car, distance_between_cities)
    passengers_dropped = drop_off_passengers(car)
    "#{drove_to} #{passengers_dropped}"
  end
end

def command_fleet(cars)
  cars.each_with_index do |car, i|
    action = act(car)
    puts "Car #{i + 1}: #{action}"
  end
  puts '---'
end

def add_one_car_per_day(cars, num_days)
  num_days.times do
    new_car = get_new_car
    puts add_car(cars, new_car)
    command_fleet(cars)
  end
end

cars = []
add_one_car_per_day(cars, 10)
