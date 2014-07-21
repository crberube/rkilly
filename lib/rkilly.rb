module Rkilly
  require 'rubygems'
  require 'commander/import'
  require 'rainbow/ext/string'

  program :version, '0.0.2'
  program :description, 'Easily kill processes'
 
  command :kill do |c|
    c.syntax = 'kill [process name]'
    c.summary = 'Easily kill a process'
    c.description = 'Finds all processes that match [process name] and allows you to kill any specific match or all matches.'
    c.action do |args, options|
      pname = args[0]
      data_array = %x(ps aux | grep #{pname} | grep -v grep | awk '{print $2, $11, $12, $13}').split("\n").drop(1)
    
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

  command :rkelly do |c|
    c.syntax = 'rkelly'
    c.summary = 'Releases R. Kelly from the closet'
    c.action do |args, options|
      puts "                         . . ::77ODODODO8Z:..                                   
                     ....ZDDD88888OOOOO8DD8D8OO,..                              
                   .,8D8ZZOZO8OOOZ88DOZ8Z$7?7888OO: ...                         
               ....OO8ZDDMNNNMMNMNMNO8DDD8O$$7I7ZZZOZ?. .                       
               ..$ODNN88DD8O8888O8O887$ZOOZ77ZO88$77Z88:...                     
            ...ODN8O87?++=++=I+~++?ZZ$$$?$$??======++++=+~.                     
            .ZN8OO+7Z8Z8$OOZ8OZ$OZ77II??~=~~~~==+=++++++?=,..                   
         . .8D8I7ZZ88Z8O8O8O8ZZOO7$??===~~~~~~~=====++????++. .                 
       . .=D87ZZ8DDOD$NDNNMMNNMDO7+=++~~~~~~~~~~~=~=++++?II??:.                 
         .88?O8DN8NNMN8D8OO88Z$O7+7???+~=~~~~~~~~=+++++???IIII=..               
       ..8N?O88NMNDDDDZ88O77Z77ZII$$I?7=~~~~~=~=~==++??IIIIIIII=.               
       .$NIO8DMNDNDD8ZZ$7II+?+?7Z7$++I?:~~~~~~~====+???IIII777II:.              
      .:DOZ8DMDDOD8OZII7Z77$7$ZZI?7I?==~==~~==~===+??III77777777I..             
       8D$DNMNDZO7$$$78OO8ZZ$88$7I?7?+===~=~=~===+????III777777$7,              
     ..DDDNNNDO$7$O88DD8D8NDDDO$I+?II=++==+=~~===+++????????I7777I.             
     ..8ZNNMNZ$ZO8O8NONDNNN8N8Z?I7I7?+?+======~====++?++?III7I777I,.            
     .INO8MDN7Z8D8DMMMND8ZOOI$$$$$7III?++===~~==~~~==??I7I7777III7I..           
     .INNDMNZO8DND8NN8OZO$I77?ZI7$7+???+?++==~=+~~~=?:8NNNNNNNZOI7I~....        
     .7NNNN87DDN8NNDD88O7$77I7$OZ7?7I?+?+++++?=~~=I~NNNMMMMNNN,N8$~+,:=.        
     .$N8DNZODNNM8ZZZ8Z8OZ8ZO8ZZ$$I??II?=++=+?~?~=7NNNMMMMMIMM?NMZ8~M$?.        
     .:NDMN$DDDNN$7ZZZO~~:::::,::ZIIII????ZI=:$,..~NNNNMNMMMNMMMM$.78I$,        
     ..DDMDZDD8NO$7+++?ZD8OZZOZ$ZOZZ$?+~=?:I?+$7+~+NMMMMMMMNNNNNN$M8??7:        
       DDN8ZDDMOZI?O?ZOZII7ZO8ZOZZ$7I????++=+7$Z8D8DDNNNMNNNNNNND+$+787~.       
      .?DMDODNM8I?7I$Z7O?7I$OOOZO$77I7?III??????I7D8DDNNNNDNNDN8O7I778I:.       
      ..DNM8DNM8$Z$?$$7DZ$I7$ZZOOZ$7IIIIIII+I???I78O88DDDD888DO7$==++?+.        
       .~DMDD8N$ZZ7+Z8~78?++7ZOZDOZ$7Z$III?++?+?IIOOOO888888OOOO=~~~~++.        
       . DNNNNM8$7?7O~IIO?+=I$ZOOOZZ$$$$77?++=+??I7DZOOOOO8OZZ?+=+=~=+?I..      
         ?NMDNNOOIIIO?=7Z7?+I7ZZ8OOZZZZ$ZZ77?????777$D8OO888OZII+==??I7I=.      
          8DNDN8Z$II$~I$=$O=?$$$8O8ZOZ$Z$ZZ$$$II?II7$777$7ZO$7??$8N8Z$ZO..      
         .,NNDNDODZIZI?+?III?$$ZOOZZ8OZ$Z$$Z$7III??I??I77$ZZZ$ZDDO$8DOO..       
          .D8MMN88DZ?II?+II?$$$$O8Z$$ZZZZZZO777III?IIII7$$OIIOD8Z$O87..         
          .:DNNDD8ODD8Z7??Z,8Z$$ZZO$OZZZZ7$$$77?IIIIII$$$ZI?I??II$$ZZ..         
          .OMNNND8OOOODNDO8.8OZ$ZOO8ZZ$$Z$ZZ77IIZIIIII7$$7??I?II77$ZZ~ .        
         .,8MNDND8O8OOOZZ?$.OOOZOO8ZOOZ7ZO8ZZO7$777I$7777I77I7$ZZOO888:.        
         .DDNNZNDOOOOOOZZZDOOOOOZO88Z8OO$8OO8O$Z7II77?I777Z8OOOZIIZ8Z7~.        
         .D8MN=N8OOOOOOOZZOZOOZOZO88OOOZ888O8ZZO7$$I??77ODDDOO88D8888?.         
         ?N+M..IOOZOOOOZOOZOOOOOOO8888O8OO8Z$88OO8ZZ77$ODD8Z$7?I+?7Z$,          
         OM.N ..$ZZOOOOOOOOOO8O8O8DD88D8D8D8888DO88OOZODD8$7II777I777I..        
        .8M~DZ..NZOOOOOOZOOZOO88888D88D888D8O8ND8OOO8D8DD$777$ZOO88D8O...       
         .N?:.M.MZOOOOOOOZOOOO88DD8DDNNDD8DD8D88DDNO8NDD8ZZZZOO8DNNN8.          
         .M7...D8ZZOOOOOOZZOZOO8DDDDDNNDNDDD888DDDDDDDDDD88OO8O8DND8+.          
         .~N: ..~8OOOOOOOOOOO8O88DDDDDDNNDDDNNNDDDDDD8DNNDD88OOZOO8O:.          
          .$Z...NODO8OOOOOZOOO8O8DDDNNNNNNNNNNNNDDNNNNDNNDNDD88ZZ888O.          
           .M..DM8NO8OOOOOOOOOOO88DDDDNNNNNNNNMNNNDNNMNNDNNDDD88DDDDN..         
          ..Z DDMD8D8OOOOOOOOO8O888DDDNNNNNMMNNNMMMMMMNNNNDNNNNNNNND8.          
.          .I~DNNNDN8OOOOOOOOOO88D8DD8DDDNDDDNNMMMMMMMMNMMNNNMMMMMND..          
          ..8IDNNNDN888OOOOOOO8ZOO888DDNDDDDDDDDNMMNDNDMMMMMMMMMMN+..           
        ...N.IDNNNMN888OOOOOZOZOO8OOODDNDDDD8DDNNNDDD8   .  .. ....             
       . Z.DDDNNNNMND8888OOOOOOZZO888888DDDDDDNNNNDDD8.                         
     ..:7ODDNNNNNMMNN8D8888OOO8OOOZOO88DD8DDNNNDNNDNDO,                         
      ..DDDNNNNNMMMMNMND88OOO8OOO888O88DDDDDDDNNNDDDDDM ".color(:red)


    end
  end

end
