def get_input(num_guess)
  #Prompts user for input
  print "Enter your guess (#{5-num_guess} remaining): "
  gets.chomp
end

def is_a_number(input)
  true if Float(input) rescue false
end

def terminate(message="Terminating...")
  puts `clear`
  puts "#{message}"
  puts
  exit
end

def check_guess(guess, answer)
  if guess > answer
    puts "Sorry, too high."
    puts
  elsif guess < answer
    puts "Sorry, too low."
    puts
  else
    puts "That is correct, nice job!"
    puts
    return true
  end
  false
end

def warn_player(warnings)
  case warnings
  when 0
    puts "Numbers only please."
    puts
  when 1
    puts "Seriously, numbers only!"
    puts
  when 2
    puts "LAST WARNING!"
    puts
  else
    terminate("I asked nicely. Now you're done.")
  end
end
def draw_box(message)
  width = message.length + 6
  puts "#" * width
  message = message.prepend "#  "
  message += "  #"
  puts message
  puts "#" * width
end

def keep_playing
  draw_box("Would you like to play again? (y/n)")
  gets.chomp == "y" ? (true) : (false)
end

def stupid_guess(guess, answer, previous_guesses)
  return true if guess > 100 || guess < 1
  return true if previous_guesses.include?(guess)
  count = 0
  while (count < previous_guesses.size)
    old_answer = previous_guesses[count]
    if guess < answer
      return true if guess < old_answer && old_answer < answer
    elsif guess > answer
      return true if guess >  old_answer && old_answer > answer
    end
    count +=1
  end
  false
end

continue = true

#New game loop
while continue
  #Title Prompt
  puts `clear`
  puts "##################################################"
  puts "#        Welcome my number guessing game.        #"
  puts "#  I will think of a number between 1 and 100.   #"
  puts "#  You will guess what that number is (or not).  #"
  puts "#                                                #"
  puts "#      Type exit at anytime to terminate         #"
  puts "##################################################"
  puts

  #Initialize new game
  number_pool = (1..100).to_a.shuffle
  answer = number_pool[6] #6 Chosen by fair dice roll. Guaranteed to be random.
  correct = false
  warnings = 0
  num_guess = 0
  suffix = ""
  previous_guesses = []
  #Main game loop
  while (num_guess < 5)
    #Input guess from user
    guess = get_input(num_guess)
    terminate("Leaving so soon? Goodbye then.") if guess == "exit"

    #Ensure that guess is a number
    if is_a_number(guess)
      num_guess += 1
      guess = guess.to_i
      correct = check_guess(guess, answer)
      break if correct
      puts "Really? You already know that's not the answer." if stupid_guess(guess, answer, previous_guesses)
      puts
      previous_guesses.push(guess)
    else
      #Warn, and eventually terminate for non-numbers
      warn_player(warnings)
      warnings+=1
    end
  end

  #Check if player found the right answer and end the game
  puts `clear`
  if correct
    suffix = "es" if num_guess > 1
    draw_box("Congratulations! You guessed correctly in #{num_guess} guess#{suffix}.")
  else
    draw_box("Sorry, you did not guess the right number. The correct number was #{answer}.")
  end
  puts
  puts
  puts
  puts "Press enter to continue..."
  gets.chomp
  #Ask if player wants to play again
  puts `clear`
  continue = keep_playing
end
terminate("Thanks for playing!")
