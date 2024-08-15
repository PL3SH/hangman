def read_file
    words = []
  lines = File.readlines('englishWords.txt').map(&:chomp)#quitamos con el map el salto de linea que poseen cada fila del archivo de texto
    lines.each do |line|
    words.push(line)
    end
end


def save(word,guess,remaining_try,used_words)
  if file.exist? '\\wsl.localhost\Ubuntu\home\pl3sh\projects\hangman\player.save'
    File.open('player.save', 'w') do |file|
      file.write("word:#{word} \n guess:#{guess} \n remaining_attempts:#{remaining_try} \n used_words:#{used_words}")
    end
  end
  puts "archivo guardado"
end
def select_random_word(words_array)
    #filtramos las palabras que sean minimo de 5 a 12 letras
    words_array = words_array.select {|word| word.length >= 5 && word.length <=12}

    hidden_word = words_array.sample
     
    return hidden_word
   
end


def game(word)
  
    puts "welcome to hangman \n guess the following word:#{word.length} letters"
    lines = ""
    word.length.times do
        lines = lines + "_,"
    end
    original_word = word
    puts lines
    guess = Array.new(word.length)
    guess.fill("_")
    try = word.length * 2
        puts "you have #{try} tries!" 
        word = word.split("")
used_words = []
        begin
            
            puts "Escribe tu letra:"
            input = gets.chomp
            used_words.push(input)
            found = false
            
            word.each_with_index do |letter, index|
              if letter == input
                guess[index] = input
                found = true
              end
            end
            
            p guess
            
            if guess.join == original_word
              puts "¡Has ganado! :)"
              break
            end
            
            try -= 1 unless found
            puts "has usado las siguientes letras :#{ used_words} \n _________________________________________________"
            puts "Te quedan #{try} intentos. "
           
          end while try > 0
          
          if try == 0
            puts "Has perdido :( La palabra era: #{original_word}"
          end
end
game(select_random_word(read_file))