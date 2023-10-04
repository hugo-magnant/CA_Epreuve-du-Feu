def is_valid?(board, row, col, num)
  9.times do |i|
    return false if board[row][i] == num
    return false if board[i][col] == num
  end

  start_row, start_col = 3 * (row / 3), 3 * (col / 3)
  3.times do |i|
    3.times do |j|
      return false if board[i + start_row][j + start_col] == num
    end
  end

  true
end

def solve!(board)
  9.times do |row|
    9.times do |col|
      if board[row][col] == 0
        (1..9).each do |num|
          if is_valid?(board, row, col, num)
            board[row][col] = num
            return true if solve!(board)
            board[row][col] = 0
          end
        end
        return false
      end
    end
  end
  true
end

def print_board(board)
  board.each do |row|
    puts row.join
  end
end

# Vérifier les arguments
if ARGV.length != 1
  puts 'error'
  exit(1)
end

# Lire le fichier
begin
  lines = File.readlines(ARGV[0]).map(&:chomp)
  if lines.length != 9 || lines.any? { |line| line.length != 9 }
    puts 'error'
    exit(1)
  end

  board = lines.map { |line| line.chars.map { |char| char == '.' ? 0 : char.to_i } }

  # Résoudre le Sudoku
  if solve!(board)
    print_board(board)
  else
    puts 'Pas de solution'
  end
rescue
  puts 'error'
end
