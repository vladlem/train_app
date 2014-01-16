require "#{Dir.getwd}/gifts.rb"
require 'io/console'

# Check existing or installing gem 'libnotify'
lib_notify = 'libnotify'
gdep = Gem::Dependency.new(lib_notify)
# find latest that satisifies
found_gspec = gdep.matching_specs.sort_by(&:version).last
# instead of using Gem::Dependency, you can also do:
# Gem::Specification.find_all_by_name(gem_name, *gem_ver_reqs)

unless found_gspec
  puts "Requirement '#{gdep}' not satisfied; installing..."
  ver_args = gdep.requirements_list.map{|s| ['-v', s] }.flatten
  # multi-arg is safer, to avoid injection attacks
  system('gem', 'install', lib_notify, *ver_args)
end

require lib_notify

gift = Gifts.new

message = gift.process_gift

until(message.nil?)
  Libnotify.show summary: "#{Date.today}", body: message

  #quite = $stdin.readlines[0]
  #break if quite

  sleep 30
end


