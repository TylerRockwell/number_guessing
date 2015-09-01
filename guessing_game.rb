def get_input()
  #Prompts user for input
  print "Enter your guess: "
  gets.chomp
end

def is_a_number(input)
  true if Float(input) rescue false
end

def terminate(message="Terminating...")
  puts "#{message}"
  puts ""
  exit
end

def check_guess(guess, answer)
  if guess > answer
    puts "Sorry, too high."
  elsif guess < answer
    puts "Sorry, too low."
  else
    puts "That is correct, nice job!"
    return true
  end
  false
end

def warn_player(warnings)
  case warnings
  when 0
    puts "Numbers only please."
  when 1
    puts "Seriously, numbers only!"
  when 2
    puts "LAST WARNING!"
  else
    terminate("I asked nicely. Now you're done")
  end
end



answer = rand(1..100)
correct = false
warnings = 0
num_guess = 0
suffix = ""
puts ""
puts "##################################################"
puts "#        Welcome my number guessing game.        #"
puts "#  I will think of a number between 1 and 100.   #"
puts "#  You will guess what that number is (or not).  #"
puts "#                                                #"
puts "#      Type exit at anytime to terminate         #"
puts "##################################################"
puts ""
#Initial prompt

while (num_guess < 5)
  #Input guess from user
  num_guess += 1
  guess = get_input
  terminate("Leaving so soon? Goodbye then.") if guess == "exit"

  #Ensure that guess is a number
  if is_a_number(guess)
    guess = guess.to_i
    correct = check_guess(guess, answer)
    break if correct
  else
    warn_player(warnings)
    warnings+=1
  end
end

if correct
  suffix = "es" if num_guess > 1
  puts "Congratulations! You guessed correctly in #{num_guess} guess#{suffix}."
else
  puts "Sorry, you did not guess the right number. The correct number was #{answer}."
end

puts ""
