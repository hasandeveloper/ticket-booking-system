module Theater
    module Entities
        class Billing
            attr_reader :price
            def initialize(price)
                @price = price
            end

            def calculate_seats selected_seat
                calculate selected_seat
            end

            def calculate_total_sales seats
                selected_seat = []
                seats.seat_categories_list.each do |show|
                    show[:seat_categories].values.each do |seat|
                        seat.each do |seat_name|
                            if seat_name[1] == false
                                selected_seat << seat_name.first
                            end
                        end
                    end
                end
                calculate_seats selected_seat.join(",")
            end

            private
                def calculate selected_seat
                    sub_total = 0
                    service_tax = 0
                    swatch_barath_cess = 0
                    krishi_kalyan_cess = 0
                    total = 0
                    selected_seat.split(",").each do |seat|
                        seat_category = seat.split("")[0]
                        sub_total += self.price[seat.split("")[0]]
                    end
    
                    puts "Subtotal: #{sub_total}"
                    puts "Service Tax @14%: #{sub_total.to_f*14/100}"
                    puts "Swachh Bharat Cess @0.5%: #{sub_total.to_f*0.5/100}"
                    puts "Krishi Kalyan Cess @0.5%: #{(sub_total.to_f*0.5/100)}"
                    puts "Total: Rs. #{(sub_total + sub_total.to_f*14/100 + sub_total.to_f*0.5/100 + sub_total.to_f*0.5/100).ceil}"
                end
        end
    end
end