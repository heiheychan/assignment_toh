def game(h,r)
  puts "Welcome to Tower of Hanoi!"
  puts "Instructions:"
  puts "Enter where you'd like to move from and to"
  puts "in the format 1,3 (separate them by comma). Enter 'q' to quit."
  steps = 1
  current_pos = init(h,r)
  display(current_pos, steps)
  while true
    print ">"
    from, to = get_input
    if not valid?(from, to, current_pos)
      steps += 1
      puts "Your inputs are not valid. You waste a step!"
    else
      current_pos = swap(from, to, current_pos)
      display(current_pos, steps)
      if win?(current_pos)
        puts "You win! Yohoooooo!"
        puts "Took #{steps} steps"
        exit
      end
      steps += 1
    end
  end
end

def init(h,r)
  a = []
  temp = 1
  a << []
  while temp <= h
    a[0] << temp
    temp += 1
  end
  (2..r).each do |n|
    a << []
    h.times do
      a[n - 1] << 0
    end
  end
  a
end

def display(c,s)
  c_len = c[0].length
  puts "##{s} Current Board:"
  (0..(c_len - 1)).each do |n|
    r = ""
    c.each do |single_pole|
      bead_num =  single_pole[n]
      b_n_offset = single_pole.length - bead_num
      r << "#{"o"*bead_num}#{" "*b_n_offset} "
    end
    puts r
  end
  r = ""
  c.length.times do |n|
    c_offset = c[0].length - 1
    r << "#{n}#{" "*c_offset} "
  end
  puts r
end

def get_input
  input = gets.chomp
  if input == "q"
    puts "Happy to see you go!"
    exit
  end
  input = input.split(",")
  from = input[0].to_i
  to = input[1].to_i
  return from, to
end

def valid?(f,t,c)
  f_num = 0
  t_num = 0
  if c[f].nil? || c[t].nil? || c[f].count(0) == c[f].length
    return false
  end
  c[f].each do |x|
    if x != 0
      f_num = x
      break
    end 
  end
  c[t].each do |y|
    if y != 0
      t_num = y
      break
    end
  end
  if f_num > t_num
    if t_num == 0
      return true
    end
    return false
  end
  return true
end

def swap(f,t,c)
  f_num = 0
  c[f].each_with_index do |x, i|
    if x != 0
      f_num = x
      c[f][i] = 0
      break
    end 
  end
  if c[t].count(0) == c[t].length
    c[t][-1] = f_num
    return c
  end
  c[t].each_with_index do |y, i|
    if y != 0
      c[t][i - 1] = f_num
      return c
      break
    end
  end
end

def win?(c)
  (1..(c.length-1)).each do |n|
    unless c[n].include?(0)
      return true
    end
  end
  return false
end

game(8,6)
