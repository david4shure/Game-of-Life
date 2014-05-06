# The Ruby Solution
# David Shure
# Conway's Game of Life

$canvas = []
$width = 0
$height = 0


def init_canvas(spawn_factor)
  $canvas = Array.new($height) { Array.new($width) { Random.new.rand(1...100) < spawn_factor ? 1 : 0 } }
end

def print_canvas()
  for x in 0...$canvas.size()
    for y in 0...$height
      print $canvas[x][y] == 1 ? " * " : "   "
    end
    puts
  end
end

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

def count_neighbors(x, y)
  return count_left(x, y) + count_right(x, y) + count_up(x, y) + count_down(x, y) + count_diagonals(x, y)
end

def count_left(x, y)
  if x - 1 < 0
    return 0
  end
  return $canvas[x - 1][y] == 1 ? 1 : 0
end

def count_right(x, y)
  if x + 1 >= $width
    return 0
  end
  return $canvas[x + 1][y] == 1 ? 1 : 0
end

def count_up(x, y)
  if y + 1 >= $height
    return 0
  end
  return $canvas[x][y + 1] == 1 ? 1 : 0
end

def count_down(x, y)
  if y - 1 < 0
    return 0
  end
  return $canvas[x][y - 1] == 1 ? 1 : 0
end

def count_diagonals(x, y)
  total_count = 0

  if x - 1 >= 0 and y + 1 < $height and $canvas[x - 1][y + 1] == 1 then total_count += 1 end
  if x - 1 >= 0 and y - 1 >= 0 and $canvas[x - 1][y - 1] == 1 then total_count += 1 end
  if x + 1 < $width and y + 1 < $height and $canvas[x + 1][y + 1] == 1  then total_count += 1 end
  if x + 1 < $width and y - 1 >= 0 and $canvas[x + 1][y - 1] == 1 then total_count += 1 end

  return total_count
end

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
