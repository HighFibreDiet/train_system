require './lib/line'
require './lib/station'
require 'pg'

DB = PG.connect(:dbname => 'train_system')

def starting_menu
  system('clear')
  header
  puts "Enter 'm' for the main menu to find information on train lines and stations."
  puts "Enter 'o' for the train system operator menu to add lines and/or stations."
  puts "Enter 'x' to exit"
  menu_choice = gets.chomp
  case menu_choice
  when 'm'
    main_menu
  when 'o'
    operator_menu
  when 'x'
    puts "Thanks for playing! Ride with us again! (Or not...it's a free country)"
    exit
  else
    idiot_menu
    starting_menu
  end
end

def header
  print "\t\t*********************************************\n\t\t* WELCOME * TO * THE * WORLD * OF * TRAINS! *\n\t\t*********************************************\n\n"
end

def main_menu

end

def operator_menu
  system('clear')
  puts "\n****** Operator Menu ******\n"
  puts "Press 'nl' to add a new line"
  puts "Press 'ns' to add a new station"
  puts "Press 'vs' to view all stations"
  puts "Press 'vl' to view all lines"
  puts "Press 'u' to update a station, line, or stop"
  puts "Press 'c' to connect a line and station with a new stop"
  puts "Press 's' to return to the starting menu"

  user_choice = gets.chomp

  case user_choice
  when 'nl'
    new_line
  when 'ns'
    new_station
  when 'vs'
    list_stations
    gets
    operator_menu
  when 'vl'
    list_lines
    gets
    operator_menu
  when 'u'
    update_menu
  when 'c'
    new_stop
  when 's'
    starting_menu
  else
    idiot_menu
    operator_menu
  end
end

def new_line
  puts "\nEnter a name for the new line"
  name = gets.chomp
  if Line.exists?(name)
    puts "That name is already assigned to an existing line. Please enter a different name."
    new_line
  else
    Line.new({'name' => name}).save
  end
  operator_menu
end

def new_station
  puts "\nEnter a name for the new station"
  name = gets.chomp
  if Station.exists?(name)
    puts "That name is already assigned to an existing station. Please enter a different name."
    new_station
  else
    Station.new({'name' => name}).save
    puts "Station #{name} created!"
  end
  operator_menu
end

def update_menu
  puts "Enter 's' to update a station, 'l' to update a line."
  puts "You can update a stop from any station or line that includes that stop."
  what_to_update = gets.chomp
  case what_to_update
  when 's'
    update_station
  when 'l'
    update_line
  else
    idiot_menu
    update_menu
  end
end

def update_station
  puts "Enter 'r' to rename a station, 's' to remove a line, or 'd' to delete the station."
  station_update_choice = gets.chomp
  case station_update_choice
  when 'r'
    puts "Enter the name of the station you would like to rename, or 'l' to list all stations."
    rename_choice = gets.chomp
    if rename_choice == 'l'
      list_stations
      puts "Enter the name of the station you would like to rename."
      rename_choice = gets.chomp
    end
    station = Station.search(rename_choice)
    while station.nil?
      puts "That is not a valid station name. Please enter a valid station name choice."
      rename_choice = gets.chomp
      station = Station.search(rename_choice)
    end
    puts "What would you like the station's new name to be?"
    new_name = gets.chomp
    station.update_name(new_name)
    operator_menu
  when 's'
  when 'd'
    puts "Enter the name of the station you would like to remove, or 'l' to list all stations."
    removal_choice = gets.chomp
    if removal_choice == 'l'
      list_stations
      puts "Enter the name of the station you would like to remove."
      removal_choice = gets.chomp
    end
    station = Station.search(removal_choice)
    while station.nil? do
      puts "Please enter a valid station name."
      removal_choice = gets.chomp
      station = Station.search(removal_choice)
    end
    station.delete
    puts "The #{station.name} station and all associated stops have been deleted."
    operator_menu
  else
    idiot_menu
    update_station
  end
end

def list_stations
  puts "\nThe stations you currently have saved are: "
  Station.all.each_with_index do |station, index|
    puts "#{index + 1}. #{station.name}"
  end
  puts "\n"
end

def list_lines
  puts "\nThe lines you currently have saved are: "
  Line.all.each_with_index do |line, index|
    puts "#{index + 1}. #{line.name}"
  end
  puts "\n"
end

def update_line
  puts "Enter 'r' to rename a line, 's' to remove a station, or 'd' to delete the line."
  line_update_choice = gets.chomp
  case line_update_choice
  when 'r'
    puts "Enter the name of the line you would like to rename, or 'l' to list all lines."
    rename_choice = gets.chomp
    if rename_choice == 'l'
      list_lines
      puts "Enter the name of the line you would like to rename."
      rename_choice = gets.chomp
    end
    line = Line.search(rename_choice)
    while line.nil?
      puts "That is not a valid line name. Please enter a valid line name choice."
      rename_choice = gets.chomp
      line = Line.search(rename_choice)
    end
    puts "What would you like the line's new name to be?"
    new_name = gets.chomp
    line.update_name(new_name)
    operator_menu
  when 's'
  when 'd'
    puts "Enter the name of the line you would like to remove, or 'l' to list all lines."
    removal_choice = gets.chomp
    if removal_choice == 'l'
      list_lines
      puts "Enter the name of the line you would like to remove."
      removal_choice = gets.chomp
    end
    line = Line.search(removal_choice)
    while line.nil? do
      puts "Please enter a valid line name."
      removal_choice = gets.chomp
      line = Line.search(removal_choice)
    end
    line.delete
    puts "The #{line.name} line and all associated stops have been deleted."
    operator_menu
  else
    idiot_menu
    update_line
  end
end
def new_stop

end

def idiot_menu
  puts "You are an idiot. You deserve punishment, but because we're nice people, we'll let you pick:\n"
  puts "Press 'k' to get kicked"
  puts "Press 'c' for chinese water torture (it's not that bad...we promise)"
  puts "Press 's' to get face-slapped"
  puts "Press 'b' to come face to face with a swarm of angry bees"
  puts "Press 'm' to talk to your mother-in-law on the phone for an hour"
  puts "Press 't' to get stuck in traffic with a broken radio and no A/C"

  punishment_choice = gets.chomp

  case punishment_choice
  when 'k'
    puts "*kick!* *kick!* *kick!*\n"
    puts "Yeah, that hurt didn't it?"
  when 'c'
    1.upto(10) do
      puts "*drip*"
      gets
    end
    puts "Okay, it really was that bad"
  when 's'
    puts "*SLAP!*"
    puts "Stings, eh?"
  when 'b'
    puts "\t\t\t\t\t*bzzzzz*"
    puts "\t*bzzz*"
    puts "\t\t\t*bzzzz*"
    puts "\t\t*STING*"
    puts "\t\t\t\t*bzzzzzzz*"
    puts "\t\t\t*bzzzzz*"
    puts "The bee that stung you is dead. I hope you're happy."
  when 'm'
    puts "No matter what you do, you will never be good enough to deserve my son/daughter/gender-neutral offspring.\n*Cue self-doubt and self-esteem downward spiral."
  when 't'
    puts "You just got cut off AND flipped off. By a guy on a cell phone. And your gas light just came on."
  else
    puts "Seriously? Like...seriously? You don't deserve to stay in this program anymore. Goodbye."
    exit
  end
  gets
end



starting_menu
