#!/usr/bin/env ruby

about = "Wodk Web App Builder Script"
version = "1.0.5"
values = Hash.new
regex = /%%(\w+)%%/

puts "
Welcome to #{about} (version #{version}).

This script will help you setup your web application.

To get started, we'll ask you a couple of questions.

Let's get started...

"
sleep 1

# Get all of our values for replacement
puts "What is your human readable site name?
Example: Football Challenge or D&D Encounter Builder
The default value is 'Site Name'"
temp = gets.chomp
values['site_name'] = temp.size == 0 ? "'Site Name'" : "'#{temp}'"
# Base URI
puts "What is the URI where the app is being loaded?
For example, if the site is loading from `http://example.com/myApp`,
the URI is `/myApp`. The leading slash is needed.
The default value is `/`."
temp = gets.chomp
values['base_uri'] = temp.size == 0 ? "/" : "#{temp}/"
# Host
puts "What is your database's host name.
The default value is localhost."
temp = gets.chomp
values['db_hostname'] = temp.size == 0 ? "'localhost'" : "'#{temp}'"
# Port
puts "What is your database's port number?
The default value is NULL."
temp = gets.chomp
values['db_port'] = temp.size == 0 ? "NULL" : "#{temp}"
# Name
puts "What database are you using?
The default value is test."
temp = gets.chomp
values['db_database'] = temp.size == 0 ? "'test'" : "'#{temp}'"
# User
puts "What is the username to connect to the database?
The default value is root."
temp = gets.chomp
values['db_username'] = temp.size == 0 ? "'root'" : "'#{temp}'"
# Password
puts "What is the password to connect to the database?.
The default value is root."
temp = gets.chomp
values['db_password'] = temp.size == 0 ? "'root'" : "'#{temp}'"
# Socket
puts "What socket are you connecting to on the database?
The default value is NULL."
temp = gets.chomp
values['db_socket'] = temp.size == 0 ? "NULL" : "#{temp}"
# Prefix
puts "Are you using a table prefix for this web app?
The default is to not use a prefix."
temp = gets.chomp
values['db_prefix'] = temp.size == 0 ? "''" : "'#{temp}'"

puts "
Now that we have the values, we are going to put them to use...
"
sleep 1

# Have all the variables, now do replacement for them
%w(.htaccess db-dev.php db-prod.php index.php).each do |file_name|
  text = File.read(file_name)
  replace = text.gsub(regex) do |m|
    values[$1]
  end
  File.open(file_name, "w") { |file| file.puts replace }
  puts "Updated '#{file_name}'"
  sleep 1
end

# Clean up the .git folders
puts "
Removing github files and folders"
sleep 1
["rm -rf .git/", "rm -f .gitignore", "rm -f README.md"].each do |cmd|
  puts "#{cmd}"
  `#{cmd}`
  sleep 1
end

# Web App Ready
puts "
You're all set to get started!

You can now navigate to your web app in a browser.
"
