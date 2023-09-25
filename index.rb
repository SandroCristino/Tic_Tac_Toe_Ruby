module TicTacToe
  LINES = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [1, 4, 7], [2, 5, 8], [0, 3, 6], [0, 4, 8], [2, 4, 6]]

  class Player
    def initialize(marker)
      @marker = marker
    end

    private

    def change_marker(marker)
      @marker = marker
    end

    attr_reader :marker
  end

  class Human_Player < Player
    def initialize(name)
      @name = name
    end

    private

    # Player move
    def player_move(symbol, _gameboard)
      puts "Select your #{symbol} position"
      user_position = gets.chomp
      # update_gameboard(user_position, symbol)
      [user_position, symbol]
    end

    attr_reader :name
  end

  class Computer_Player < Player
    def initialize
      @name = 'Bot'
    end

    private

    def player_move(symbol, gameboard)
      loop do
        random_number = rand(9)
        if gameboard[random_number].is_a?(Numeric)
          return random_number, symbol
          break
        end
      end
    end

    attr_reader :name
  end

  class Game
    def initialize
      @gameboard = [0, 1, 2, 3, 4, 5, 6, 7, 8]
    end

    # Start game
    def play(player1, player2)
      # Set marker for player
      player1.change_marker('X')
      player2.change_marker('O')

      loop do
        print_gameboard
        result1 = player1.player_move('X', @gameboard)
        update_gameboard(result1[0], result1[1])
        result2 = player2.player_move('O', @gameboard)
        update_gameboard(result2[0], result2[1])
        if player_won(player1)
          puts "#{player1.name} won the game"
          break
        elsif player_won(player2)
          puts "#{player2.name} won the game"
          break
        elsif check_draw
          puts "It's a draw"
          break
        end
      end
    end

    private

    # Print gameboard
    def print_gameboard
      puts "#{@gameboard[0]} | #{@gameboard[1]} | #{@gameboard[2]}"
      puts '--+---+--'
      puts "#{@gameboard[3]} | #{@gameboard[4]} | #{@gameboard[5]}"
      puts '--+---+--'
      puts "#{@gameboard[6]} | #{@gameboard[7]} | #{@gameboard[8]}"
    end

    # Update gameboard
    def update_gameboard(position, symbol)
      @gameboard[position.to_i] = symbol
    end

    # Check if player has won
    def player_won(player)
      LINES.any? do |line|
        line.all? { |position| @gameboard[position] == player.marker }
      end
    end

    def check_draw
      @gameboard.none? { |position| position.is_a?(Numeric) }
    end
  end
end

include TicTacToe

game = Game.new
me = Human_Player.new('Tom')
bot2 = Computer_Player.new
bot = Computer_Player.new
game.play(me, bot)
