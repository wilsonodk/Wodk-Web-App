#!/usr/bin/env ruby

about = "Wodk Web App Builder Script"
version = "0.0.1"
values = Hash.new
regex = /%%(\w+)%%/

# Get all of our values for replacement
puts "Site Name: A human readable site name. Example: Football Challenge, D&D Encounter Builder"
temp = gets.chomp
values['site_name'] = temp.size == 0 ? "Site Name" : temp
# Base URI
puts "Base URL: The URI where the app is being loaded. If the site is loading from http://example.com/myApp, the base URI is /myApp"
temp = gets.chomp
values['base_uri'] = temp.size == 0 ? "#{values['site_name'].downcase}/" : "#{temp}/"
# Host
puts "Database Host Name. Default is localhost"
temp = gets.chomp
values['db_hostname'] = temp.size == 0 ? "'localhost'" : "'#{temp}'"
# Port
puts "Database Port Number. Default is NULL"
temp = gets.chomp
values['db_port'] = temp.size == 0 ? "NULL" : "#{temp}"
# Name
puts "Database Name. Default is default."
temp = gets.chomp
values['db_database'] = temp.size == 0 ? "'default'" : "'#{temp}'"
# User
puts "Database Username. Default is root."
temp = gets.chomp
values['db_username'] = temp.size == 0 ? "'root'" : "'#{temp}'"
# Password
puts "Database Password. Default is root."
temp = gets.chomp
values['db_password'] = temp.size == 0 ? "'root'" : "'#{temp}'"
# Socket
puts "Database Socket Number. Default is NULL."
temp = gets.chomp
values['db_socket'] = temp.size == 0 ? "NULL" : "#{temp}"
# Prefix
puts "Database table prefix. Default is '' (empty string)"
temp = gets.chomp
values['db_prefix'] = temp.size == 0 ? "''" : "'#{temp}'"

puts " 
Putting the values into place
 "

# Have all the variables, now do replacement for them
files = [".htaccess", "index.php"]
files.each do |file_name|
	text = File.read(file_name)
	replace = text.gsub(regex) do |m| 
		values[$1]
	end
	File.open(file_name, "w") { |file| file.puts replace }
	puts "Updated '#{file_name}'"
end

# Clean up the .git folders
puts " 
Removing github files and folders"
`rm -rf .git/; rm -f .gitignore;`
puts "..."

# Web App Ready
puts "You're all set. Get started!"
