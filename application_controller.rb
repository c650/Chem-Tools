require 'colored'
require './methods.rb'
#not-so-simple introductory text
line1 = "Chem-Tools"
line2 = "by Charles Bailey"
puts "|#{"-"*31}|"
puts "|#{" "*(15 - line1.length/2)}#{line1.red}#{" "*(16 - line1.length/2)}|"
puts "|#{"-"*31}|"
puts "|#{" "*(15 - line2.length/2)}#{line2.red}#{" "*(15 - line2.length/2)}|"
puts "|#{"-"*31}|"
#this is the application controller/console for the tools
puts "Enter values separated by commas:"
print "/>/ ".red #simply a prompt style
array_of_values = gets
array_of_values = array_of_values.split(',') #convert to array
#we need an error checker to see for incorrect input
array_of_values = array_of_values.map{|value| value = value.to_f} #convert each element to float
valid = false #bool to control validity of choice entered below
until valid == true do #implementation of error checking
	puts "Now choose which thing to calculate:"
	print " 1) Arithmetic Mean\n 2) Normal Deviation\n 3) Standard Deviation\n"
	print " 4) Error\n 5) Percent Error"
	puts "Type [#{"ALL".red}] for all (default)."
	puts "Type [#{"EXIT".red}] to exit."
	print "/>/ ".red
	choice = gets.chomp #gets selection from user

	if choice.to_s.downcase == "all" #checks if choice is 'all'
		valid = true
		Calculations.all(array_of_values)
	elsif choice.to_s.downcase == "exit" #checks if choice is 'exit'
		print "Exiting"
		3.times do |time| #artsy little 'animation' where .'s print out
			sleep(0.33)
			print "."
			sleep(0.33)
		end
		exit
	else
		case choice #checking for number selections.
		when "1"
			valid = true
			puts "#{"Mean:".red} \n#{Calculations.mean(array_of_values)}"
			puts ""
		when "2"
			valid = true
			puts "#{"Regular Deviation:".red}"
			puts "#{Calculations.regular_deviation(array_of_values)}"
			puts ""
		when "3"
			valid = true
			puts "#{"Standard Deviation:".red}"
			puts "#{Calculations.standard_deviation(array_of_values)}"
			puts ""
		when "4"
			valid = true
			puts "-"*33
			Calculations.check_for_accepted
			puts "-"*33
			puts "#{"Error:".red}"
			puts Calculations.error(array_of_values)
		when "5"
			valid = true
			puts "-"*33
			Calculations.check_for_accepted
			puts "-"*33
			puts "#{"Percent Error:".red}"
			puts Calculations.percent_error(array_of_values)
		else #error handeling for invalid options... shoots back up to option prompt afterwards
			valid = false
			puts "#{"ERROR:".red} Invalid option. Please enter again."
		end
	end
end
