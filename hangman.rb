require "colorize"

class Hangman
  WORD_CHOICES = ["cheeseburger", "cat", "dog", "whatever", "mississippi", "octothorpe", "splat", "bang"]

  attr_reader :blank_answer_row

  def initialize
    @answer = WORD_CHOICES.sample
    @wrong_counter = 0
    @wrong_answers = []
    @correct_guesses = " "
    @blank_answer_row = "_ " * @answer.length
  end

#--------------------------------------------------------
# USER INPUT

# Generates art/prompts for user interface
  def user_prompt
    until @answer == answer_output
      print_art
      puts "\nPlease enter a letter."
      puts "\nWRONG GUESSES:" + @wrong_answers.join(" ") + "\n"
      puts "YOUR GUESS:"
      guess = gets.chomp.downcase
      check_user_input(guess)

        if @answer.include?(guess)
          @correct_guesses.concat guess
        else
          @wrong_counter += 1
          @wrong_answers.push(guess)
        end

        puts answer_output.chars.join(" ")
    end
    puts "CONGRATULATIONS! YOU WIN!"
  end

  private

  def answer_output
    @answer.tr("^#{@correct_guesses}", "_")
  end

  def check_user_input(guess)
    #searching for alphabetical input and accounting for the edgecase of "0"
    while guess.length > 1 || guess.to_i != 0 || guess == "0"
      puts "Please enter a valid character."
      guess = gets.chomp.downcase
    end
  end

# Generates ascii dragon art
  def print_art
    case @wrong_counter
    when 0
      puts "
                ._____.
              .          .
            :              :
           ;                ;
           |                |
           |                |
           ;                ;
            :              /
    ---------.           .---------
                ;.____.;
    ".colorize(:green)

    when 1
      puts "
                ._____.
              .          .
            :              :
           ;       ^        ;
           |       |        |
           |             ^  |
           ;    |        |  ;
            :  \\       /  /
    ---------.  |      | .---------
                ;.____.;
    ".colorize(:light_black)

    when 2
      puts "
                .__^__.
              .           .
            :    /         :
           ;       ^    /   ;
           |   *   |        |
           |    *        ^  |
           ;    |        |  ;
            :  \\       /  /
    ---------.  |      | .---------
                ;.____.;
    ".colorize(:white)

    when 3
      puts "
                   (\\^~^/)
                    )d b(
                  \\(  _  )/
                   ((q_p))
                . _________ .
              :    /         :
             ;       ^    /   ;
             |   *   |        |
             |    *        ^  |
             ;    |        |  ;
              :  \\       /  /
      ---------.  |      | .---------
    ".colorize(:yellow)

    when 4
      puts "
                 (\\^~^/)
          ._____  )d b(  _____.
         .__)_   \(  _  )/  _(__.
         ._)_    ((q_p))    _(_.
           \\__  .-)\\u/(-.  __/
            \\ :\\,-.   .   ,-./
             |||\\,       ,/||
             | \\    /\\   /  |
             ;    \\ -<      ;
              :   \\ -. \\_  /
      ---------. \\       .---------
                 ;.____.;
    ".colorize(:magenta)

    when 5
      puts "
           (\\               /)
          __)\\             /(__
         __)_ \\  (\\!~!/)  / _(__
        __)_ `.\\  )d b(  /.' _(__  *YOU'RE NOT MY MOMMY*
      ___)_ `. \\\\(  _  )// .' _(___  *BREATHES FIRE*
       )_  `. \\  ((q_p))  / .'  _(_    *GAME OVER*
       _)`.  \\  ,-)\\_/(-.  /  .'(_
        _) ,-._/v/vvvvv\\v\\_,-. (_
        _)///(._/v(___)v\\_.)\\\\\\(_
         \\_ ___/v(_____)v\\___ _/
           /vvv\\(_______)/vvv\\
           \\vvv/v(_____)v\\vvv/
           _\\vv\\\\v(___)v//vv/_
          '>_`  \\`-._.-'/  '_<`
          ' >_,-'       `-._<`

      ".colorize(:red)
      exit

    end
  end

end

if $0 == __FILE__
  hangman = Hangman.new
  puts hangman.blank_answer_row
  hangman.user_prompt
end
