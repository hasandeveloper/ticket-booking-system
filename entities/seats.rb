require_relative './seat_categories.rb'
require_relative './seat_categories_list.rb'
require_relative './shows.rb'
module Theater
    module Entities
        class Seats
            attr_reader :seat_categories_list
            
            def initialize(categories, number_of_seats)
                seat_categories = Theater::Entities::SeatCategories.new(categories)
                @seat_categories_list = Theater::Entities::SeatCategoriesList.build_seat_categories_list(seat_categories.categories, number_of_seats, Theater::Entities::Shows.all)
            end

            def self.display_seats(seats, show_no)    
                seats.seat_categories_list.each do |show|
                    if show_no == show[:show]
                        show[:seat_categories].each do |seat_category|
                           row = []
                            seat_category[1].each do |v,k|
                                if k == true
                                    row << v
                                else                                    
                                    row << ""
                                end   
                            end
                            puts row.join(" ")
                        end
                    end
                end
            end

            def self.book_seat show_no, selected_seats, seats
                booked_seat = []
                seats.seat_categories_list.each do |show|
                    if show_no == show[:show]
                        selected_seats.split(",").each do |selected_seat|
                            show[:seat_categories].each do |seat_category|
                                next if selected_seat.split("")[0] != seat_category[1].first[0].split("")[0]
                                if seat_category[1][selected_seat] == true
                                    seat_category[1][selected_seat] = false
                                    booked_seat << selected_seat
                                end
                            end
                        end
                    end
                end
                return true, "Successfully Booked - Show #{show_no}"
            end
        end
    end
end
