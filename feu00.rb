def draw_rectangle(width, height)
  if width < 1 || height < 1
    puts "error"
    return
  end

  top_and_bottom = 'o' + '-' * (width - 2) + 'o'
  middle = '|' + ' ' * (width - 2) + '|'

  puts top_and_bottom
  (height - 2).times { puts middle } if height > 1
  puts top_and_bottom if height > 1
end

# Récupération des arguments
if ARGV.length != 2 || !ARGV.all? { |arg| arg.to_i.to_s == arg }
  puts "error"
else
  width = ARGV[0].to_i
  height = ARGV[1].to_i
  draw_rectangle(width, height)
end
