require_relative './../movie'
require_relative './../entities/shows.rb'
require 'test/unit'
require 'rspec'
require 'pry'

RSpec.describe Movie do
  let(:movie) { Movie.new }
  let(:all_shows) { Theater::Entities::Shows.all }

  describe "#show" do 
      it 'When accepts show number' do
        show = movie.shows(1)
        expect(show).to eq(1)
      end
      it 'When accepts shows within the show range specified' do
        show = all_shows.sample
        expect(movie.shows(show)).to eq(show)
      end
      it 'When accepts shows out of the show range specified' do
        show = all_shows.last + 1
        error_sentence = "There are #{all_shows.count} shows available, please enter from #{all_shows.first} to #{all_shows.last} shows"
        expect {movie.shows(show)}.to raise_error(RuntimeError, error_sentence)
      end
  end

  describe "#seats" do
    let(:categories) {{
      "Platinum" => "A",
      "Gold" => "B",
      "Silver" => "C"
     }}
    let(:number_of_seats) { 9 }
    let(:seats) { Movie.build_seats(categories, number_of_seats) }

    context '#when built' do
      it "Should have number of shows" do
        expect(seats.seat_categories_list.count).to eq(all_shows.count)
      end
      it "Should have number seat categories" do
        seat_categories = seats.seat_categories_list.first[:seat_categories].keys
        expect(seat_categories).to eq(categories.keys)
      end
      it "Should have number of seats" do
        seat_count = seats.seat_categories_list.first[:seat_categories][categories.first[0]].count
        expect(seat_count).to eq(number_of_seats)
      end
    end

    context "When selects" do
      let(:show_no) { all_shows.first }
      let(:seat_1) { "#{categories.values.first}#{number_of_seats}" }
      let(:seat_2) { "#{categories.values.last}#{number_of_seats-1}" }

      before do
        @seats = Movie.build_seats(categories, number_of_seats) 
      end

      before do
        @booked_seat, @message = movie.book_seat show_no, "#{seat_1},#{seat_2}", @seats
      end

      it "Should booked when available" do
        expect(@message).to eq("Successfully Booked - Show #{show_no}")
      end

      it "Should not book if already seat is booked" do
        booked_seat, message = movie.book_seat show_no, "#{seat_1},#{seat_2}", @seats
        expect(message).to eq("#{seat_1} Not available which is already booked, Please select different seats")
      end
    end

    context "When Validate" do
      it "should show please enter proper seat number as mentioned above with comma seperated" do
        seat = "dasdsa"
        booked_seat, message = movie.book_seat 1, seat, seats
        expect(message).to eq("#{seat} Not available, Please select different seats")
      end
    end
  end
end

