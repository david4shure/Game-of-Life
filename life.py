# David Shure
# Problem: John Conway's Game of Life

# The Rules of John Conway's Game of Life:
# ========================================
# 1. Any live cell with fewer than two live neighbours dies, as if caused by under-population.
# 2. Any live cell with two or three live neighbours lives on to the next generation.
# 3. Any live cell with more than three live neighbours dies, as if by overcrowding.
# 4. Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.

# This is our empty canvas, or petri dish for "life"
# NOTE, the canvas is in theory infinite, but computers 
# don't have infinite memory yet. (Joking)

import sys, os, time
from random import randint

canvas = []

# initializes a board with life in random places
def initialize_canvas(width, height, spawn_factor):
    global canvas

    for x in range(0, width):
        canvas.append([])
        for y in range(0, height):
            canvas[x].append( 1 if randint(0, 100) <  spawn_factor else 0 )

# prints out our canvas
def print_canvas():
    global canvas

    for x in range(0, len(canvas)):
        for y in range(0, len(canvas[0])):
            # for newline suppression
            sys.stdout.write( " * " if canvas[x][y] == 1 else "  " )
        # for the end of a row
        print

# According to the rules of the game of life
# this function updates the canvas
def update_canvas():
    global canvas
    
    for x in range(0, len(canvas)):
        for y in range(0, len(canvas[x])):
            
            neighbor_count = count_neighbors(x, y)

            if canvas[x][y] == 1:
                # Starvation
                if neighbor_count < 2 or neighbor_count > 3:
                    canvas[x][y] = 0
            elif canvas[x][y] == 0:
                # Propagation
                if neighbor_count == 3:
                    canvas[x][y] = 1
                

# The clever part
def count_neighbors(x, y):
    return count_left(x, y) + count_right(x, y) + count_up(x, y) + count_down(x, y) + count_diagonals(x, y)

# Helper functions
# =================

# Counts the neighbors to the square
# directly to the left of the current cell
def count_left(x, y):
    global canvas
    try:
        if canvas[x - 1][y] == 1:
            return 1
        else:
            return 0
    except IndexError, e:
        return 0

# Counts the neighbors to the square
# directly to the right of the current cell
def count_right(x, y):
    global canvas
    try:
        if canvas[x + 1][y] == 1:
            return 1
        else:
            return 0
    except IndexError, e:
        return 0
    

# Counts the neighbors to the square
# directly up from the current cell
def count_up(x, y):
    global canvas
    try:
        if canvas[x][y + 1] == 1:
            return 1
        else:
            return 0
    except IndexError, e:
        return 0

# Counts the neighbors to the square
# directly down from the current cell
def count_down(x, y):
    global canvas
    try:
        if canvas[x][y - 1] == 1:
            return 1
        else:
            return 0
    except IndexError, e:
        return 0

# Counts the neighbors to the squares
# that are diagonal to the square at (x, y)
def count_diagonals(x, y):
    global canvas
    total_count = 0

    # Upper left
    try:
        if canvas[x - 1][y + 1] == 1:
            total_count += 1
    except IndexError, e:
        total_count += 0

    # Bottom left
    try:
        if canvas[x - 1][y - 1] == 1:
            total_count += 1
    except IndexError, e:
        total_count += 0

    # Upper right
    try:
        if canvas[x + 1][y + 1] == 1:
            total_count += 1
    except IndexError, e:
        total_count += 0

    # Bottom right
    try:
        if canvas[x + 1][y - 1] == 1:
            total_count += 1
    except IndexError, e:
        total_count += 0

    return total_count



# C programming habits die hard.
# Nonetheless, I felt that for this specific
# problem, a main function was warranted.
def main():
    board_width = int(raw_input("Enter Board width (integer): "))
    board_height = int(raw_input("Enter Board height (integer): "))
    spawn_factor = int(raw_input("Enter Spawn Factor (chance out of 100 that the current square will be alive), number in the range 7 - 9 has interesting results: "))
    num_generations = int(raw_input("Enter the number of generations: "))

    initialize_canvas(board_width, board_height, spawn_factor)
    
    current_generation = 0

    while current_generation < num_generations:
        os.system("clear")
        print_canvas()
        update_canvas()
        time.sleep(0.15)
        current_generation += 1

    print "Simulation Complete. Goodbye."

main()
