class Train

  attr_reader :speed, :route, :number, :cars, :station_number

  def initialize(number)
    @number = number
    @speed = 0
    @station_number = 0
    @cars = []
  end

  def accelerate(speed)
    @speed = speed
  end

  def brake
    @speed = 0
  end

  def detach_car(car)
    @cars.delete(car) if @speed==0
  end

  def get_route(route)
    @route = route
    @station_number = 0
  end

  def move_forward
    @station_number += 1 if @station_number < (@route.route_stations.length - 1)

    #if (@station_number + 1) >= @route.route_stations.size
    #  puts 'Нельзя переместить поезд дальше конечной станции'
    #else
    #  @station_number += 1
    #end
  end
  
  def move_back
    @station_number -= 1 if @station_number >= 1

    #if @station_number == 0
    #  puts 'Нельзя переместить поезд дальше начальной станции'
    #else
    #  @station_number -= 1
    #end
  end

  def previous_station
    @route.route_stations[@station_number - 1] if @station_number >= 1
  end

  def current_station
    @route.route_stations[@station_number]
  end

  def next_station
    @route.route_stations[@station_number + 1] if @station_number < @route.route_stations.size
  end

  def attach_car
    if @speed == 0
      if @class == PassengerTrain
        @cars << PassengerCar
      else
        @cars << CargoCar
      end
    end
       
  end
end

def create_train(trains)
  puts 'Введите номер поезда'
  number = gets.chomp

  if trains.count { |t| t.number.match(number) } == 0

    loop do
      puts 'Выберите тип поезда: 1 - пассажирский, 2 - грузовой'
      type = gets.to_i
      if type == 1
        trains << PassengerTrain.new(number)
        break
      elsif type == 2
        trains << CargoTrain.new(number)
        break
      else
        puts 'Для выбора типа поезда необходимо ввести цифру: 1 - пассажирский, 2 - грузовой'
      end
    end

  else
    puts "\n Поезд с таким номером уже существует"
  end
end

def assign_route_to_train(trains, routes)
  trains?(trains)
  routes?(routes)

  if routes.size != 0 && trains.size != 0

    request_for_route_number(routes)

    route_num = gets.to_i

    request_for_train_number(trains)

    train_num = gets.to_i

    if is_included?(routes, route_num) && is_included?(trains, train_num) #проверка выбора поезда и маршрута
      trains[train_num - 1].get_route(routes[route_num - 1])
      #puts "Поезду #{trains[train_num - 1].number} назначен маршрут #{routes[route_num - 1].route_stations[0].name} - #{routes[route_num - 1].route_stations[-1].name}"
    #else
      #puts 'Необходимо указать порядковый номер поезда и маршрута из списка'
    end
  end
end

def add_cars(trains)
  trains?(trains)
  if trains.size != 0

    request_for_train_number(trains)
    train_num = gets.to_i

    if trains[train_num-1].class == PassengerTrain
      trains[train_num-1].attach_car
      #puts "Поезду #{trains[train_num - 1].number} добавлен вагон.
      #Количество вагонов в поезде: #{trains[train_num - 1].cars.size}."
    elsif trains[train_num-1].class == CargoTrain
      trains[train_num-1].attach_car
      #puts "Поезду #{trains[train_num - 1].number} добавлен вагон.
      #Количество вагонов в поезде: #{trains[train_num - 1].cars.size}."
    #else
    #  puts 'Поезд с таким порядковым номером отсутствует'
    end
  end
end

def delete_cars(trains)
  trains?(trains)

  if trains.size != 0
    request_for_train_number(trains)
    train_num = gets.to_i
      
    if is_included?(trains, train_num)
      if trains[train_num - 1].cars.size > 0
        trains[train_num - 1].cars.delete_at(-1)
        #puts "От поезда #{trains[train_num - 1].number} отцеплен вагон.
        #Количество вагонов в поезде: #{trains[train_num - 1].cars.size}."
      #else
      #  puts 'Отцеплять вагоны возможно только от поезда, количество вагонов которого не менее одного.'
      end
    #else
    #  puts 'Необходимо указать порядковый номер поезда из списка'
    end
  end
end

def move_train(trains)

  trains_with_routes_qty = (trains.size - trains.count { |t| t.route.nil? })

  #if trains_with_routes_qty == 0
  #  puts 'Ни одному поезду не присвоен маршрут'
  #end

  if trains_with_routes_qty != 0

    if trains_with_routes_qty == 1
      train_to_move = trains.select { |t| t.route }
      train_to_move = train_to_move[0]
      #puts "Единственный поезд с присвоенным маршрутом: #{train_to_move.number}"
    else
      loop do
        trains_with_routes(trains) #запрос номера поезда, который перемещаем
        train_num = gets.to_i
        if trains[train_num - 1].route
          train_to_move = trains[train_num - 1]
          break
        #else
        #  puts 'Необходимо указать порядковый номер поезда из списка, которому присвоен маршрут'
        end
      end
    end

    loop do
      puts 'Куда переместить поезд?
      1. Вперед
      2. Назад
      0. Выход в главное меню'

    direction = gets.to_i

    case direction
    when 1
      train_to_move.move_forward
    when 2
      train_to_move.move_back
    when 0
      break
    end
  end
end
end
