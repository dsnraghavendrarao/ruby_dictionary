class Search
	def initialize
		puts "App Stared ......!"
		read_dictionary
	end

	def read_dictionary
		begin
			file_path = File.join(File.dirname(__FILE__), 'dictionary.txt')
			dictionary = File.readlines(file_path).map { |w| w.chomp.downcase }.uniq
			puts "Dictionary loaded..."
			puts dictionary.size
		rescue Errno::ENOENT => e
			puts "Caught the exception: #{e}"
		rescue
			puts "some thing went wrong"
		end
	end
end

Search.new