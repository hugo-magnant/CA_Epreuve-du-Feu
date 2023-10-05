# Fonction pour lire un fichier et le convertir en tableau 2D
def read_board_from_file(file)
  board = []
  File.open(file, "r") do |f|
    f.each_line do |line|
      board << line.chomp.split("")
    end
  end
  board
end

# Fonction pour trouver une forme dans un plateau
def find_shape(board, shape)
  board.each_with_index do |row, row_index|
    row.each_with_index do |_col, col_index|
      found = true
      shape.each_with_index do |shape_row, shape_row_index|
        shape_row.each_with_index do |shape_col, shape_col_index|
          board_row = board[row_index + shape_row_index]
          if board_row.nil?
            found = false
            break
          end
          board_col = board_row[col_index + shape_col_index]
          if board_col.nil? || (shape_col != " " && shape_col != board_col)
            found = false
            break
          end
        end
        break unless found
      end
      return [row_index, col_index] if found
    end
  end
  nil
end

# Vérification des arguments
if ARGV.length != 2
  puts "error"
  exit(1)
end

begin
  # Lecture des fichiers
  board = read_board_from_file(ARGV[0])
  shape = read_board_from_file(ARGV[1])

  # Recherche de la forme
  coordinates = find_shape(board, shape)

  if coordinates.nil?
    puts "Introuvable"
  else
    puts "Trouvé !"
    puts "Coordonnées : #{coordinates.reverse.join(",")}"

    # Remplacer les caractères du tableau original par des tirets
    new_board = board.map { |row| row.map { |cell| "-" } }

    # Remplacer la forme trouvée par la forme d'origine
    shape.each_with_index do |shape_row, shape_row_index|
      shape_row.each_with_index do |shape_col, shape_col_index|
        new_board[coordinates[0] + shape_row_index][coordinates[1] + shape_col_index] = shape_col
      end
    end

    # Afficher le nouveau tableau
    new_board.each { |row| puts row.join("") }
  end
rescue Exception => e
  puts "error"
end
