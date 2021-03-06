class Search
	def initialize
		puts "App Stared ......!"
		number_letters
		read_dictionary
		
	end
	def number_letters
		@letters = {"2" => ["a", "b", "c"],"3" => ["d", "e", "f"],"4" => ["g", "h", "i"],"5" => ["j", "k", "l"],"6" => ["m", "n", "o"],"7" => ["p", "q", "r", "s"],"8" => ["t", "u", "v"],"9" => ["w", "x", "y", "z"]}
	end

	def read_dictionary
		begin
			@dictionary = []
			file_path = File.join(File.dirname(__FILE__), 'dictionary.txt')
			@dictionary = File.readlines(file_path).map { |w| w.chomp.downcase }.uniq
			puts "Dictionary loaded..."
			# puts dictionary.size
			get_input
		rescue Errno::ENOENT => e
			puts "Caught the exception: #{e}"
		rescue e
			puts "some thing went wrong"
		end
	end

	def get_input
		puts  "Please give 10 digit number to fetch combination words from dictionary"
		@number = gets.chomp
		if  validate_phone_number(@number)
			business_logic(@number)
		else
			puts "woring number input"
		end
	end

	def business_logic(number)
	    keys = number.chars.map{|digit|@letters[digit]}
	    results = {}
	    total_number = keys.length - 1 
	    for i in (2..total_number)
	      first_array = keys[0..i]
	      second_array = keys[i + 1..total_number]
	      next if first_array.length < 3 || second_array.length < 3
	      first_combination = first_array.shift.product(*first_array).map(&:join) # Get product of arrays
	      next if first_combination.nil?
	      second_combination = second_array.shift.product(*second_array).map(&:join)
	      next if second_combination.nil?
	      results[i] = [(first_combination & @dictionary), (second_combination & @dictionary)]
	    end

	    output = []
	    results.each do |key, combinataions|
	      next if combinataions.first.nil? || combinataions.last.nil?
	      combinataions.first.product(combinataions.last).each do |combo_words|
	        output << combo_words
	      end
	    end
	    output << (keys.shift.product(*keys).map(&:join) & @dictionary).join(", ")
		puts output
	end

	def validate_phone_number(number)
		return (number.nil? || number.length < 10 || number.split('').include?('0') || number.split('').include?('1')) ? false : true 
	end 

end

Search.new



