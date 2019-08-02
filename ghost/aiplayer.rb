class AiPlayer
# move towards having only one word that can be completed with given fragment
# list of char options
# compare list of word possibilities per char use lowest word possibilites count
    def initialize(name)
        @name = name
        @letters = ""
        @dictionary = Set.new
        File.foreach("dictionary.txt") do |line|
            @dictionary << line.chomp
        end

        @word_options = @dictionary.to_a.to_set
    end

    def reset_options
        @word_options = @dictionary.to_a.to_set
    end

    def guess(fragment)
        alphabet = ("a".."z").to_a
        return alphabet.sample if fragment = ""

        options = Hash.new {|hash, key| hash[key] = []}
        word_options = @word_options.select! { |word| word[0...fragment.length].include? fragment }
        word_options.each do |word|
            char = word[fragment.length]
            options[char] << [word]
        end

        sorted_options = options.sort_by { |k, v| v.length }

        # sort to least number of word options that can be completed using letter
        # do any of those words count as winning moves
        # if they don't count as winning moves, does the next letter over have any?

        sorted_options.each do |option|
          option[1].each do |word|
            if non_losing_move?(word)
              return option_char = option[0]
            end
          end
        end
        

        # num_players*n + 1
        # n % num_players
        # fragment, 3 players, "frag"
        # n = 4
        # players = 3

        # 4 % 3 = 1

        # word.length - fragment.length
        #num_players % n == 1
    end

    def give_letter
        @letters = "GHOST"[0..@letters.length]
    end

    def

    end
end