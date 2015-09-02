def keep_playing
  puts "#########################################"
  puts "#  Would you like to play again? (y/n)  #"
  puts "#########################################"
  puts
  gets.chomp == "y" ? (true) : (false)
end

def terminate(message="Terminating...")
  puts `clear`
  puts "#{message}"
  puts
  exit
end

def lie_detector(min_guess, max_guess)
  return false if min_guess > max_guess
  true
end

def variance(min_guess, max_guess)
  range = max_guess - min_guess
  (0..range).to_a.sample / 2 * (-1..1).to_a.sample
end

continue = true
#New game loop
while continue
  #Title Prompt
  puts `clear`
  puts "##################################################"
  puts "#        Welcome my number guessing game.        #"
  puts "#    You think of a number between 1 and 100.    #"
  puts "#   I will guess what that number is (or not).   #"
  puts "#                                                #"
  puts "#      Type exit at anytime to terminate         #"
  puts "##################################################"
  puts
  puts
  puts "Instructions for play:"
  puts "Type 'high' if I guess too high"
  puts "Type 'low' if I guess too low"
  puts "Type 'correct' if I guess correctly"
  puts "Don't lie to me. I'll know."
  puts
  puts
  puts "Are you ready? (y/n)"
  feedback = gets.chomp
  terminate("That's fine. I didn't want to play anyway.") if feedback == "n"
  #Initialize new game
  max_guess = 100
  min_guess = 0
  correct = false
  warnings = 0
  num_guess = 0
  suffix = ""
  previous_guesses = []
  valid_input = true
  #Main game loop
  while (num_guess < 5)
    num_guess += 1 if valid_input
    valid_input = true
    guess = min_guess + (max_guess - min_guess)/2
    guess += variance(min_guess, max_guess)
    puts
    puts "I guess #{guess}"
    print "$: "
    feedback = gets.chomp
    valid_input = lie_detector(min_guess, max_guess)
    if valid_input
      case feedback
      when "high"
        max_guess = guess - 1
      when "low"
        min_guess = guess + 1
      when "correct"
        correct = true
        break
      else
        puts "Invalid response"
        valid_input = false
      end
      previous_guesses.push(guess)
    else
      puts "I told you not to lie to me. I don't like when you lie to me."
      terminate("If you can't be honest, then we can't play.")
    end
  end

  #Check if player found the right answer and end the game
  puts `clear`
  if correct
    suffix = "es" if num_guess > 1
    puts "############################################################"
    puts "#      I'm awesome! I guessed correctly in #{num_guess} guess#{suffix}.      #"
    puts "############################################################"
  else
    puts "###########################################################"
    puts "#  Well, I did not guess the right number. What was it??? #"
    puts "###########################################################"
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
