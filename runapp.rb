require_relative './movie.rb'
categories = {
      "Platinum" => "A",
      "Gold" => "B",
      "Silver" => "C"
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
    booked_seat = movie.book_seat show, selected_seat, seats
    p booked_seat
    puts "Would you like to continue (Yes/No):"
    confirmed =  gets.chomp.capitalize
end


