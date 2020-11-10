class Station

  attr_reader :trains, :name

  def initialize(name)
    @name = name
    @trains = []
  end

  def take_train(train)
    @trains << train
  end
  
  def send_train(train)
    @trains.delete(train)
  end

  def trains_by_class(car_class)
    @trains.find_all { |tr| tr.class == car_class }
  end
end

def create_stations(stations)
  puts 'Введите название станции'
  name = gets.chomp

  if stations.count { |s| s.name.match(name) } == 0
    stations << Station.new(name)
    #puts "\n Станция #{name} добавлена"
  #else
    #puts "\n Такая станция уже существует"
  end
end

def print_stations_n_trains(stations, trains)

  if stations.size == 0
    puts 'Список станций пуст'
  else
    puts 'Список станций:'
    stations.each { |station| puts station.name }
  end

  if trains.size == 0
    puts 'Список поездов пуст'
  else
    trains.each do |train|
      if train.route
        puts "\n Поезд #{train.number} находится на станции #{train.route.route_stations[train.station_number].name}"
      end
    end
  end
end