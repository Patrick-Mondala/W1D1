class Player
    attr_reader :letters, :name

    def initialize(name)
      @name = name
      @letters = ""
    end

    def guess(fragment)
      puts "What character would you like to use?"
      response = gets.chomp
    end

    def give_letter
      @letters = "GHOST"[0..@letters.length]
    end
end