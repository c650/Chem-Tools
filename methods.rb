require 'colored'
class Float
  def signif(signs)
    Float("%.#{signs}g" % self)
  end
end
module Calculations
	#METHOD TO CALCULATE SUM OF VALUES
	def Calculations.sigfigs(array_of_values)
		((array_of_values.map{|value| (value.to_s.length - 1)}.sort.first) + 1)
	end
	def Calculations.sum_of_values(array_of_values)
		#initialize empty float for sum
		sum = 0.0 
		array_of_values.map{|value| sum += value}
		sum.signif(Calculations.sigfigs(array_of_values)).to_f
	end
	#METHOD TO CALCULATE ARTIHMETIC MEAN OF VALUES
	def Calculations.mean(array_of_values)
		(Calculations.sum_of_values(array_of_values) / (array_of_values.length.to_f)).signif(Calculations.sigfigs(array_of_values)).to_f
	end
	#METHOD TO CALCULATE REGULAR -- NOT STANDARD -- DEVIATION
	def Calculations.regular_deviation(array_of_values)
		#initializes empty array for holding each value's deviation
		deviation_array = Array.new
		#iterates through supplied/given values
		array_of_values.each do |value|
			#calculates deviation for each value
			deviation = value - Calculations.mean(array_of_values) 
			#absolute value workaround
			if deviation < 0 
				deviation *= -1
			end
			#adds each deviation to the array of deviations
			deviation_array.push(deviation.signif(Calculations.sigfigs(array_of_values)).to_f) 
		end
		return deviation_array
	end

	#METHOD FOR STANDARD -- STANDARD -- DEVIATION
	def Calculations.standard_deviation(array_of_values)
		#initializes empty array for holding each value's deviation
		deviation_array = Array.new
		#iterates through supplied/given values
		array_of_values.each do |value|
			#calculates deviation for each value
			deviation = value - Calculations.mean(array_of_values) 
			#absolute value workaround
			if deviation < 0 
				deviation *= -1
			end
			#adds each deviation to the array of deviations
			deviation_array.push(deviation) 
		end
		#square each element in the array of deviations
		deviation_array = deviation_array.map{|value| value = value ** 2}
		#initialize a quotient variable for mean-like calculation
		#determine the (n - 1) mean 
		quotient = (Calculations.sum_of_values(array_of_values)) / (array_of_values.length - 1).to_f
		#square root
		std_dev = quotient ** 0.5
		#return the final result (sigma), standard deviation
		return std_dev.signif(Calculations.sigfigs(array_of_values)).to_f
	end
	#METHOD TO CHECK FOR PRESENCE OF ACCEPTED VALUE
	def Calculations.check_for_accepted
		if ($ACCEPTED_VALUE == nil) #ensures that an accepted value has been entered
			#if not, the machine will prompt user for an accepted value
			puts "Please input the accepted value to calculate errors:".blue
			print "/>/ ".red
			$ACCEPTED_VALUE = gets.to_f
		end
	end
	#METHOD TO CALCULATE REGULAR ERROR
	def Calculations.error(array_of_values)
		Calculations.check_for_accepted
		#make array to hold error values
		error_array = Array.new
		#iterate through array of values
		array_of_values.each do |value|
			#calculate error for each value
			error = value - $ACCEPTED_VALUE
			#absolute value workaround
			if error < 0
				#negate error if negative
				error *= -1 
			end
			error_array.push(error.signif(Calculations.sigfigs(array_of_values)).to_f)
		end
		return error_array
	end
	#METHOD TO CALCULATE PERCENT ERROR
	def Calculations.percent_error(array_of_values)
		Calculations.check_for_accepted
		#make array to hold error values
		percent_error_array = Array.new
		#iterate through array of values
		array_of_values.each do |value|
			#calculate error for each value
			prcnt_error = ((value - $ACCEPTED_VALUE) / $ACCEPTED_VALUE) * 100.0
			#absolute value workaround
			if prcnt_error < 0
				#negate prcnt_error if negative
				prcnt_error *= -1 
			end
			percent_error_array.push(prcnt_error.signif(Calculations.sigfigs(array_of_values)).to_f)
		end
		return percent_error_array
	end
end
module Printer
	def Printer.print_simple(type, method)
		puts "#{type.capitalize}:".red + "#{method}"
	end
	def Printer.print_complex(type,method)
		return_data = method
		puts "#{type.red}:"
		return_data.each do |value|
			puts "  Value ##{return_data.index(value) + 1}: #{value}"
		end
	end
	def Printer.print_all(array_of_values)
		Printer.print_simple("Mean",Calculations.mean(array_of_values))
		Printer.print_complex("Deviation",Calculations.regular_deviation(array_of_values))
		Printer.print_simple("Standard Deviation",Calculations.standard_deviation(array_of_values))
		Printer.print_complex("Error",Calculations.error(array_of_values))
		Printer.print_complex("Percent Error (%)",Calculations.percent_error(array_of_values))
	end
end