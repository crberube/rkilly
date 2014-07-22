module Rkilly
  require 'rubygems'
  require 'commander/import'

  program :version, '0.0.2'
  program :description, 'Easily kill processes'
 
  command :kill do |c|
    c.syntax = 'kill [process name]'
    c.summary = 'Easily kill a process'
    c.description = 'Finds all processes that match [process name] and allows you to kill any specific match or all matches.'
    c.action do |args, options|
      pname = args[0]
      data_array = %x(ps aux | grep -i #{pname} | grep -v grep | awk '{print $2, $11, $12, $13}').split("\n").drop(1)
    
      container_array = []
      data_array.each do |cols|
        elements = cols.split(' ')
        elements = [elements.first, elements[1...elements.size].join(' ')]
        elements.each_slice(2) { |slice| container_array << slice }
      end

      choose 'Which would you like to kill?' do |menu|
        container_array.map { |e| e.last }.each_with_index do |choice, index|
          menu.choice(choice) do
            %x(kill -9 #{container_array[index].first.to_i})
          end
        end

        menu.choice('All') do
          container_array.map { |e| e.first }.each do |pid|
            %x(kill -9 #{pid.to_i})
          end
        end
      end
    end
  end
end
