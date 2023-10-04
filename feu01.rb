if ARGV.length != 1
  puts "error"
  exit(1)
end

begin
  expression = ARGV[0]
  result = eval(expression)
  puts result
rescue Exception => e
  puts "error"
end
