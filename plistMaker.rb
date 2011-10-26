#!/usr/bin/env ruby
require "plist"
require "fastimage"

#get the folder containing images
folder      = ARGV[0]
#get the output_filename
output_name = ARGV[1]
#get the extensions you want
extension   = ARGV[2]

objs = Array.new

if output_name == nil
  output_name = "output.plist" 
end

if extension == nil
  extension = "jpg"
end

#get the images in the folder
files = Dir.glob("#{folder}/*.#{extension}") do |f|
  #grab the image dimensions for each image
  dim = FastImage.size("#{f}")
  #p f #debugging

  obj = { height: dim[0],
          name: File.basename(f, ".#{extension}"),
          width: dim[1]}
  
  #add it to the objs array
  objs << obj
  
end

puts objs.to_plist

#write to file
aFile = File.new(output_name, "w")
aFile.write(objs.to_plist)
aFile.close
