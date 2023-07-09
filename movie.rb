require 'pry'
require_relative './entities/seats.rb'
class Movie
    def shows show
        number_of_shows = Theater::Entities::Shows.all
        validate_shows number_of_shows, show
        return show
    end

    def self.build_seats categories, number_of_seats
        Theater::Entities::Seats.new(categories, number_of_seats)
    end

    def self.show_available_seats seats, show
        Theater::Entities::Seats.display_seats(seats, show)
    end

    def book_seat show, selected_seats, seats
        status, message = validate_seat(show, selected_seats, seats) 
        if status == false
            return message
        end
        Theater::Entities::Seats.book_seat(show, selected_seats, seats)
    end

    private 

    def validate_seat show_no, selected_seats, seats
        seat_names = []
        seats.seat_categories_list.each do |show|
            if show_no == show[:show]
                selected_seats.split(",").each do |selected_seat|
                    show[:seat_categories].each do |seat_category|
                        seat_names << seat_category[1].keys
                        next if selected_seat.split("")[0] != seat_category[1].first[0].split("")[0]
                        return false, "#{selected_seat} Not available which is already booked, Please select different seats" if seat_category[1][selected_seat] == false
                    end
                end
            end
        end

         flattened_seats = seat_names.flatten
         selected_seats.split(",").each do |selected_seat|
            return false, "#{selected_seat} Not available, Please select different seats" if not  flattened_seats.include? selected_seat
         end
    end

    def validate_shows number_of_shows, show
        raise "There are #{number_of_shows.count} shows available, please enter from #{number_of_shows.first} to #{number_of_shows.last} shows" unless number_of_shows.include? show
    end
end

