puts "Enter values separated by commas"
array_of_values = gets.chomp
array_of_values = array_of_values.split(',') #convert to array
array_of_values = array_of_values.map{|value| value = value.to_f} #convert each element to float

#now we need an averager

sum = 0.0

array_of_values.each do |value|
	sum += value
end

sum /= (array_of_values.length.to_f)

array_of_values.each do |value|
	deviation = value - sum
	if deviation < 0
		puts (deviation * -1)
	else
		puts deviation
	end
end

