require_relative './movie.rb'
categories = {
      "Platinum" => "A",
      "Gold" => "B",
      "Silver" => "C"
}
price = {
    "A" => 320,
    "B" => 280,
    "C" => 240
}
number_of_seats = 9
seats = Movie.build_seats categories, number_of_seats
confirmed = "Yes"

while confirmed == "Yes"
    puts "Enter Show no:"
    show = gets.chomp.to_i
    movie = Movie.new
    show = movie.shows show
    available_seats = Movie.show_available_seats seats, show
    puts "Enter Seats:"
    selected_seat = gets.chomp.upcase
    booked_seat, message = movie.book_seat show, selected_seat, seats
    if booked_seat
        puts "Print: #{message}"
        Movie.calculate_seats selected_seat, price
    else
        puts "Print: #{message}"
    end
    puts "Would you like to continue (Yes/No):"
    confirmed =  gets.chomp.capitalize
    if confirmed == "No"
        Movie.calculate_total_sales seats, price
    end
end


