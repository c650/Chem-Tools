require 'colored'
module Calculations
	#METHOD TO CALCULATE MEAN
	def Calculations.mean(array_of_values)
		sum = 0.0 #initialize empty float for sum

		array_of_values.each do |value| #iterate through values and add to sum
			sum += value
		end

		sum /= (array_of_values.length.to_f) #divide sum by number of terms, making it a mean
	end
	#METHOD TO CALCULATE REGULAR -- NOT STANDARD -- DEVIATION
	def Calculations.regular_deviation(array_of_values)
		array_of_values.each do |value| #iterate through the array
			deviation = value - Calculations.mean(array_of_values) #calc deviation by subracting given value from mean of values(terms)
			if deviation < 0 #absolute value workaround
				deviation *= -1 #if the deviation is negative it'll negated to turn it positive
			end
			#prints out the results accordingly
			puts "Data #{array_of_values.index(value) + 1} deviation: #{deviation}"
		end
	end
	#METHOD FOR STANDARD -- STANDARD -- DEVIATION
	def Calculations.standard_deviation(array_of_values)
		deviation_array = Array.new #initializes empty array for holding each value's deviation
		array_of_values.each do |value| #iterates through supplied/given values
			deviation = value - Calculations.mean(array_of_values) #calculates deviation for each value
			if deviation < 0 #absolute value workaround
				deviation *= -1
			end
			deviation_array.push(deviation) #adds each deviation to the array of deviations
		end
		#square each element in the array of deviations
		deviation_array = deviation_array.map{|value| value = value ** 2}
		#initialize a sum variable for mean-like calculation
		sum = 0.0
		#add each deviation to the sum variable
		deviation_array.each do |value|
			sum += value
		end
		#determine the (n - 1) mean 
		sum /= (array_of_values.length - 1).to_f
		#square root
		sum = sum ** 0.5
		#return the final result (sigma), standard deviation
		return sum
	end
	#METHOD TO CHECK FOR PRESENCE OF ACCEPTED VALUE
	def Calculations.check_for_accepted
		if ($ACCEPTED_VALUE == nil) #ensures that an accepted value has been entered
			#if not, the machine will prompt user for an accepted value
			puts "Please input the accepted value to calculate errors:"
			print "/>/ ".red
			$ACCEPTED_VALUE = gets.to_f
		end
	end
	#METHOD TO CALCULATE REGULAR ERROR
	def Calculations.error(array_of_values) 
		array_of_values.each do |value|	#iterate through array of values
			error = value - $ACCEPTED_VALUE #calculate error for each value
			if error < 0 #absolute value workaround
				error *= -1 #negate error if negative
			end
			#print data to console accordingly
			puts "Data #{array_of_values.index(value) + 1} error: #{error}"
		end
		nil
	end
	#METHOD TO CALCULATE PERCENT ERROR
	def Calculations.percent_error(array_of_values)
		array_of_values.each do |value| #calculate the error
			error = value - $ACCEPTED_VALUE
			if error < 0
				error *= -1
			end
			error /= $ACCEPTED_VALUE #divide error by accepted value to get decimal
			error *= 100.0	#multiple by 100 to convert to percentage
			#print data to console accordingly
			puts "Data #{array_of_values.index(value) + 1} percent error: #{error}"
		end
		nil
	end
	#METHOD TO EXECUTE ALL -- ALL -- CALCULATIONS
	def Calculations.all(array_of_values)
		#renders all calculations to console
		puts "#{"Mean:".red} \n#{Calculations.mean(array_of_values)}"
		puts ""
		puts "#{"Regular Deviation:".red}"
		puts "#{Calculations.regular_deviation(array_of_values)}"
		puts ""
		puts "#{"Standard Deviation:".red}"
		puts "#{Calculations.standard_deviation(array_of_values)}"
		puts ""
		puts "-"*33
		Calculations.check_for_accepted
		puts "-"*33
		puts "#{"Error:".red}"
		puts Calculations.error(array_of_values)
		puts "#{"Percent Error:".red}"
		puts Calculations.percent_error(array_of_values)
	end
end
