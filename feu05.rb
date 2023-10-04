require 'queue'

def bfs(map, start, finish)
  visited = {}
  queue = Queue.new
  queue.push([start, 0])

  while !queue.empty?
    coords, steps = queue.pop
    x, y = coords

    next if visited[[x, y]]
    visited[[x, y]] = steps

    return steps if [x, y] == finish

    [[x+1, y], [x-1, y], [x, y+1], [x, y-1]].each do |nx, ny|
      next if map[ny][nx] == '*'
      next if visited[[nx, ny]]
      queue.push([[nx, ny], steps+1])
    end
  end

  nil
end

# Vérifier les arguments et lire le fichier
if ARGV.length != 1
  puts 'error'
  exit(1)
end

begin
  lines = File.readlines(ARGV[0]).map(&:chomp)
  meta, *map = lines

  rows, cols, full, empty, path, entry, exit = meta.split('')
  rows = rows.to_i
  cols = cols.to_i

  start = []
  finish = []

  rows.times do |y|
    cols.times do |x|
      start = [x, y] if map[y][x] == entry
      finish = [x, y] if map[y][x] == exit
    end
  end

  distance = bfs(map, start, finish)

  if distance
    puts map.map(&:join).join("\n")
    puts "=> SORTIE ATTEINTE EN #{distance} COUPS !"
  else
    puts 'PAS DE SOLUTION'
  end

rescue
  puts 'error'
end
