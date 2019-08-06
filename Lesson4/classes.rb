# frozen_string_literal: true

class Station
  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = {}
  end

  def take_train(train)
    @trains[train] = { number: train.number, type: train.type, cars: train.cars }
  end

  def trains_count(type)
    @trains.values.count { |train| train[:type] == type }
  end

  def send_train(train)
    @trains.delete(train)
  end
end

class Route
  attr_accessor :route

  def initialize(start, finish)
    @start = start
    @finish = finish
    @route = [start, finish]
  end

  def add_station(station, position)
    @route.insert(position - 1, station)
  end

  def delete_station(station)
    @route.delete(station)
  end

  def print_route
    @route.each { |x| puts x.name }
  end
end

class Train
  attr_reader :number, :type, :current_station
  attr_accessor :speed, :cars, :route

  def initialize(number, type, carriages)
    @number = number
    @type = type
    @cars = carriages
    @speed = 0
  end

  def stop
    @speed = 0
  end

  def hook_cars
    @speed.zero? ? self.cars += 1 : 'Train speed is not zero'
  end

  def unhook_cars
    speed.zero? ? self.cars -= 1 : 'Train speed is not zero'
  end

  def take_route(route)
    @route = route.route
    @current_station = @route[0]
    @current_station.take_train(self)
  end

  def go_to_next
    if @current_station && @current_station != @route.last
      @current_station.send_train(self)
      @current_station = @route[@route.index(@current_station) + 1]
      @current_station.take_train(self)
    else
      p 'The train have not got a next station'
    end
  end

  def go_to_previous
    if @current_station && @current_station != @route.first
      @current_station.send_train(self)
      @current_station = @route[@route.index(@current_station) - 1]
      @current_station.take_train(self)
    else
      p 'The train have not got a previous station'
    end
  end

  def next_station
    if @current_station && @current_station != @route.last
      puts "Next Station is #{@route[@route.index(@current_station) + 1].name}"
    else
      'The train have not got a next station'
    end
  end

  def previous_station
    if @current_station && @current_station != @route.first
      puts "Previous Station is #{@route[@route.index(@current_station) - 1].name}"
    else
      'The train have not got a previous station'
    end
  end
end
