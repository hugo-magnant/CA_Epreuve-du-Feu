def solve_maze(filename)
  puts "Programme démarré"

  lines = File.readlines(filename).map(&:chomp)
  maze_info, *maze = lines

  rows, cols, full, empty, path, entry, exit = maze_info.match(/^(\d{2})x(\d{2})(.)(.)(.)(.)(.)$/).captures

  start = nil
  goal = nil
  maze.each_with_index do |row, y|
    row.chars.each_with_index do |cell, x|
      start = [y, x] if cell == entry
      goal = [y, x] if cell == exit
    end
  end

  if start.nil? || goal.nil?
    puts "Entrée ou sortie manquante"
    return
  end

  puts "Start trouvé à : #{start.inspect}"
  puts "Goal trouvé à : #{goal.inspect}"

  queue = [start]
  visited = { start => nil }
  while queue.any?
    current = queue.shift
    y, x = current

    if current == goal
      while current
        y, x = current
        maze[y][x] = path if maze[y][x] == empty
        current = visited[current]
      end

      puts maze.join("\n")
      return puts "=> SORTIE ATTEINTE EN #{visited.size} COUPS !"
    end

    [[-1, 0], [1, 0], [0, -1], [0, 1]].each do |dy, dx|
      neighbor = [y + dy, x + dx]
      if maze[neighbor[0]][neighbor[1]] != full && !visited.has_key?(neighbor)
        queue << neighbor
        visited[neighbor] = current
      end
    end
  end

  # Ajout d'un message d'erreur si aucun trajet n'est trouvé
  puts "Aucun trajet n'a été trouvé entre l'entrée et la sortie."
end

if ARGV.count == 1
  solve_maze(ARGV[0])
else
  puts "Usage: ruby exo.rb [filename]"
end
