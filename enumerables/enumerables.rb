class Array
  def my_each(&prc)
    i = 0

    while i < self.length
      prc.call(self[i])
      i += 1
    end

    self
  end

  def my_select(&prc)
    arr = []
    self.my_each { |ele| arr << ele if prc.call(ele) }
    arr
  end

  def my_reject(&prc)
    self.my_select { |ele| !prc.call(ele) }
  end

  def my_any?(&prc)
    self.my_each { |ele| return true if prc.call(ele) }
    false
  end

  def my_all?(&prc)
    self.my_each { |ele| return false if !prc.call(ele) }
    true
  end

  def my_flatten
    return self if !self.my_any? {|ele| ele.is_a?(Array)}
    flat = []

    self.my_each do |ele|
        if ele.is_a?(Integer)
            flat << ele
        else
            flat += ele.my_flatten
        end
    end

    flat
  end

  def my_zip(*args)
    arr = []

    self.each_with_index do |ele_self, i|
        arr << [ele_self]
        args.each {|subarray| arr[i] += [subarray[i]]}
    end

    arr
  end

  def my_rotate(int = 1)
    new_arr = self.map(&:clone)

    int.abs.times do
        if int > 0
            new_arr.push(new_arr.shift)
        else
            new_arr.unshift(new_arr.pop)
        end
    end

    new_arr
  end

  def my_join(connector = "")
    new_str = ""

    if connector == ""
      self.each { |char| new_str += char }
      return new_str
    end
    
    self.each_with_index { |char, i| (i != self.length-1) ? (new_str += char + connector) : new_str += char }

    new_str
  end

  def my_reverse
    return self if self.length == 1

    arr = []
    i = self.length - 1
    while i >= 0
        arr << self[i]
        i -= 1
    end

    arr
  end


    def bubble_sort!(&prc)
        prc ||= Proc.new {|a, b| a <=> b}

        sorted = false
        while !sorted
            sorted = true
            
            (0...self.length - 1).each do |i|
                if prc.call(self[i], self[i + 1]) == 1
                    self[i], self[i + 1] = self[i + 1], self[i]
                    sorted = false 
                end
            end
        end

        self
    end

    def bubble_sort(&prc)
        arr = self.map(&:clone)
        prc ||= Proc.new {|a, b| a <=> b}

        sorted = false
        while !sorted
            sorted = true
            
            (0...arr.length - 1).each do |i|
                if prc.call(arr[i], arr[i + 1]) == 1
                    arr[i], arr[i + 1] = arr[i + 1], arr[i]
                    sorted = false 
                end
            end
        end

        arr
    end

end

# p [2, 1, 3].bubble_sort! {|a, b| b <=> a}
# p [2, 1, 3].bubble_sort {|a, b| b <=> a}

def factors(num)
    arr = []
    (1..num).each {|n| arr << n if num % n == 0}
    arr
end

# p factors(12)
# p factors(13)
# p factors(52)

def substrings(string)
  arr = []
  i = 0

  while i < string.length
    i2 = i

    while i2 < string.length
      arr << string[i..i2]

      i2 += 1
    end

    i += 1
  end

  arr
end

# p substrings("abcd")
# p substrings("#>PID%><")

def subwords(word, dictionary)
  dictionary.select { |sub| word.include?sub }
end

# p subwords("cat index dog cranberry", ["cranberry", "index", "clock"])