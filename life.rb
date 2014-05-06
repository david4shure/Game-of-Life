# The Ruby Solution
# David Shure
# Conway's Game of Life

# The Rules of John Conway's Game of Life:
# ========================================
# 1. Any live cell with fewer than two live neighbours dies, as if caused by under-population.
# 2. Any live cell with two or three live neighbours lives on to the next generation.
# 3. Any live cell with more than three live neighbours dies, as if by overcrowding.
# 4. Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.

$canvas = []
$width = 0
$height = 0


# initializes board with life in random places according to spawn factor
def init_canvas(spawn_factor)
  $canvas = Array.new($height) { Array.new($width) { Random.new.rand(1...100) < spawn_factor ? 1 : 0 } }
end

# prints canvas to stdout
def print_canvas()
  for x in 0...$canvas.size()
    for y in 0...$height
      print $canvas[x][y] == 1 ? " * " : "   "
    end
    puts
  end
end

# According to the rules of the game of life
# this function updates the canvas
def update_canvas()
  for x in 0...$width
    for y in 0...$height
      
      neighbor_count = count_neighbors(x, y)

      if $canvas[x][y] == 1
        if neighbor_count < 2 or neighbor_count > 3
          $canvas[x][y] = 0
        end
      else
        if neighbor_count == 3
          $canvas[x][y] = 1
        end
      end
    end
  end
end

# The (somewhat) tricky part
# This function figures out how many neighbors
# a cell at (x, y) has
def count_neighbors(x, y)
  return count_left(x, y) + count_right(x, y) + count_up(x, y) + count_down(x, y) + count_diagonals(x, y)
end

# =================
# Helper functions
# =================

# Counts the neighbor to the square
# directly to the left of the current cell
def count_left(x, y)
  if x - 1 < 0
    return 0
  end
  return $canvas[x - 1][y] == 1 ? 1 : 0
end

# Counts the neighbor to the square
# directly to the right of the current cell
def count_right(x, y)
  if x + 1 >= $width
    return 0
  end
  return $canvas[x + 1][y] == 1 ? 1 : 0
end

# Counts the neighbor to the square
# directly up from the current cell
def count_up(x, y)
  if y + 1 >= $height
    return 0
  end
  return $canvas[x][y + 1] == 1 ? 1 : 0
end

# Counts the neighbors to the square
# directly down from the current cell
def count_down(x, y)
  if y - 1 < 0
    return 0
  end
  return $canvas[x][y - 1] == 1 ? 1 : 0
end


# Counts the neighbors to the squares
# that are diagonal to the square at (x, y)
def count_diagonals(x, y)
  total_count = 0
  
  # Upper Left
  if x - 1 >= 0 and y + 1 < $height and $canvas[x - 1][y + 1] == 1 then total_count += 1 end
  # Bottom Left
  if x - 1 >= 0 and y - 1 >= 0 and $canvas[x - 1][y - 1] == 1 then total_count += 1 end
  # Upper Right
  if x + 1 < $width and y + 1 < $height and $canvas[x + 1][y + 1] == 1  then total_count += 1 end
  # Bottom Right
  if x + 1 < $width and y - 1 >= 0 and $canvas[x + 1][y - 1] == 1 then total_count += 1 end

  return total_count
end


# Calling function
def main()
  print "Enter board width (integer): "
  $width = gets.chomp().to_i
  print "Enter board height (integer): "
  $height = gets.chomp().to_i
  print "Enter spawn factor (for best results enter number between 8 and 11): "
  spawn_factor = gets.chomp().to_i
  print "Enter maximum number of generations: "
  max_generations = gets.chomp().to_i
  
  init_canvas(spawn_factor)
  
  current_gen = 0

  while current_gen < 1000 do
    IO.popen("clear")
    print_canvas()
    update_canvas()
    sleep(0.15)
    current_gen += 1
  end

  puts "Simulation Complete. Goodbye."
end

main()
