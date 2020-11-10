require_relative 'methods.rb'

class Route

  attr_reader :route_stations
  
  def initialize(start_station, end_station)
    @route_stations = [start_station, end_station]
  end

  def add_intermediate_station(station)
    @route_stations.insert(1, station)
  end

  def exclude_intermediate_station(station)
    @route_stations.delete_at(station)
  end
end

def create_n_change_routes(routes, stations)

  stations?(stations)
  
  if stations.size != 0

    route_to_add = []

    while route_to_add.size < 2

      request_for_station_number(stations)
      station = gets.to_i #номер станции в списке

      if is_included?(stations, station)
        route_to_add << stations[station - 1]
      #else
      #  puts 'Необходимо указать порядковый номер станции из списка'
      end
    end

    routes << Route.new(route_to_add[0], route_to_add[1])

    loop do

      puts 'Хотите внести изменения в маршрут?
      1 - да, добавить станцию'
      if routes[-1].route_stations.size >= 1
        puts '      2 - да, удалить станцию'
      end
      puts '      нет - любое другое значение'
      choice = gets.to_i

      if choice == 1
        puts 'Введите номер промежуточной станции маршрута'
        stations.each_with_index do |s, i|
          puts "#{i + 1} - #{s.name}"
        end

        station = gets.chomp.to_i
        unless routes[-1].route_stations.include?(stations[station-1])
          routes[-1].add_intermediate_station(stations[station-1])
        #else
        #  puts 'Такая станция уже есть в данном маршруте'
        end

      elsif choice == 2
        if routes[-1].route_stations.size >= 1
          puts 'Введите номер станции маршрута, которую необходимо удалить:'
          routes[-1].route_stations.each_with_index do |s, i| 
            puts "#{i + 1} - #{s.name}"
          end
          station_to_del = gets.chomp.to_i

          if is_included?(routes[-1].route_stations, station_to_del)
            puts "Станция #{routes[-1].route_stations[station_to_del - 1].name} удалена"
            routes[-1].exclude_intermediate_station(station_to_del - 1)
          #else
          #  puts 'Такая станция отсутствует в маршруте'
          end
        else
          break
        end

      else
        break
      end
    end
  end
end

