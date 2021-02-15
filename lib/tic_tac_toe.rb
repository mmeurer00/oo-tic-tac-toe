require "pry"
class TicTacToe
    def initialize(board = nil)
        @board = board || Array.new(9, " ")
    end

  WIN_COMBINATIONS = [
      [0, 1, 2], #combo1
      [3, 4, 5], #combo2
      [6, 7, 8], #combo3
      [0, 4, 8], #combo4
      [1, 4, 7], #combo5
      [0, 3, 6], #combo6
      [2, 5, 8], #combo7
      [2, 4, 6] #combo8
        ]

  def current_player
    turn_count % 2 == 0 ? "X" : "O"
  end

  def input_to_index(string)
    index = string.to_i - 1
  end

  def turn_count
    @board.count{|token| token == "X" || token == "O"}
  end

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def move(index, token = "X")
    @board[index] = token
  end

    def position_taken?(index)
        if @board[index] == " "
            return false
        elsif @board[index] == ""
            return false
        elsif @board[index] == nil
            return false
        else @board[index] == "X" || "O"
            return true
        end
    end

    def valid_move?(index)
        if !position_taken?(index) && index.between?(0,8)
            return true
        else
            return false
        end
    end

    def turn
        puts "Please enter your position as an number between 1-9."
        input = gets.chomp      #input = gets.chomp
        index = input_to_index(input)  #index = input_to_index(input)
        if valid_move?(index) #token = current_player if valid_move?(input)
            token = current_player #move(index, token) if valid_move?(input)
            move(index, token)
        else                   #turn
            turn
        end                    #display_board
        display_board
    end

    def x_player_indexes
        indexes = []
        @board.each_with_index do |x, index|
            if x == "X"
                indexes << index
            end
        end
        indexes
    end

    def o_player_indexes
        indexes = []
        @board.each_with_index do |o, index|
            if o == "O"
                indexes << index
            end
        end
        indexes
    end
    #[[0, 4, 8],[0,0,0]].include?([0,4,8])
    def won?
        WIN_COMBINATIONS.each do |combo|
           # puts "CURRENT COMBO CHECKING IS = #{combo}, X player indexes = #{x_player_indexes} , o player = #{o_player_indexes}"
            if (x_player_indexes & combo) == combo
                return combo
            elsif (o_player_indexes & combo) == combo
                return combo
            end
        end
        false
    end

    def full?
        if @board.include?(" ")
            return false
        else
            return true
        end
    end

    def draw?
        if full? && won? == false
            return true
        else 
            return false
        end
    end

    def over?
        if draw? == true || won? != false
            return true
        else
            false
        end
    end

    def winner
        WIN_COMBINATIONS.each do |combo|
            if (x_player_indexes & combo) == combo
                return "X"
            elsif (o_player_indexes & combo) == combo
                return "O"
            end
        end
        return nil
    end

    def play
        turn until over?
        if winner != nil
            puts "Congratulations #{winner}!"
        else
            puts "Cat's Game!"
        end
    end
end 

