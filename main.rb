require_relative 'route.rb'
require_relative 'station.rb'
require_relative 'train.rb'
require_relative 'cargo_car.rb'
require_relative 'cargo_train.rb'
require_relative 'passenger_car.rb'
require_relative 'passenger_train.rb'
require_relative 'methods.rb'

stations = []
trains = []
routes = []

loop do
  print_menu

  choice = gets.to_i

  case choice
  when 1 #Создавать станции
    create_stations(stations)
  when 2 #Создавать поезда
    create_train(trains)
  when 3 #Создавать маршруты и управлять станциями в нем (добавлять, удалять)
    create_n_change_routes(routes, stations)
  when 4 #Назначать маршрут поезду
    assign_route_to_train(trains, routes)
  when 5 #Добавлять вагоны к поезду
    add_cars(trains)
  when 6 #Отцеплять вагоны от поезда
    delete_cars(trains)
  when 7 #Перемещать поезд по маршруту вперед и назад
    move_train(trains)
  when 8 #Просматривать список станций и список поездов на станции
    print_stations_n_trains(stations, trains)
  when 0
    break
  end
end
