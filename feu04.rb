# Vérifier les arguments et lire le fichier
if ARGV.length != 1
  puts "error"
  exit(1)
end

begin
  lines = File.readlines(ARGV[0]).map(&:chomp)
  meta, *map = lines

  elements = meta.split(".")

  rows = elements[0].to_i
  symbols = ".xo"

  empty, obstacle, full = symbols.chars

  rows += 1 # Add 1 here to include the metadata row

  if rows.zero? || map.length != rows || !map.all? { |line| line.length == map[0].length }
    puts "error"
    exit(1)
  end

  matrix = Array.new(rows) { Array.new(map[0].length, 0) }
  max_size = 0
  max_x = 0
  max_y = 0

  rows.times do |i|
    map[0].length.times do |j|
      if map[i][j] == obstacle
        matrix[i][j] = 0
      else
        matrix[i][j] = 1
        if i > 0 && j > 0
          matrix[i][j] += [matrix[i - 1][j], matrix[i][j - 1], matrix[i - 1][j - 1]].min
        end
        if matrix[i][j] > max_size
          max_size = matrix[i][j]
          max_x = i
          max_y = j
        end
      end
    end
  end

  if max_size > 0
    (max_x - max_size + 1..max_x).each do |i|
      (max_y - max_size + 1..max_y).each do |j|
        if i.between?(0, rows - 1) && j.between?(0, map[0].length - 1)
          map[i][j] = full
        else
          puts "Index out of bounds: i=#{i}, j=#{j}"
        end
      end
    end
  else
    puts "No square found."
  end

  puts map.join("\n")
rescue => e
  puts "Erreur attrapée : #{e}"
end
