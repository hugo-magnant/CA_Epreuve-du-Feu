if ARGV.count != 3
  puts "params needed: x y density"
  exit
end

x = ARGV[0].to_i
y = ARGV[1].to_i
density = ARGV[2].to_i

puts "#{y}.xo"
for i in 0..y
  for j in 0..x
    print ((rand(y) * 2 < density) ? "x" : ".")
  end
  print "\n"
end
