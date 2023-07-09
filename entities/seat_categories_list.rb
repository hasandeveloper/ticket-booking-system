require_relative './shows.rb'
module Theater
    module Entities
        class SeatCategoriesList
            
            def self.build_seat_categories_list seat_categories, number_of_seats, number_of_shows
                lists = []
                number_of_shows.each do |show_number|
                    show = {}
                    show[:show] = show_number
                    seat_categories.each do |k,v|
                        unless show.has_key? :seat_categories
                            show[:seat_categories] = {}
                            show[:seat_categories][k] = {}
                            number_of_seats.times do |i|
                                show[:seat_categories][k]["#{v}#{i+1}"] = true 
                            end
                        else
                            show[:seat_categories][k] = {}
                            number_of_seats.times do |i|
                                show[:seat_categories][k]["#{v}#{i+1}"] = true 
                            end
                        end
                    end 
                    lists << show
                end
                return lists
            end
        end
    end
end