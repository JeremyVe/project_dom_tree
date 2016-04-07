class Stack
  attr_accessor :stack, :length
  def initialize
    @stack = []
    @length = 0
  end

  def push element
    @stack[@length] = element
    @length += 1
    puts "you push #{element}"
    @stack
  end

  def pop
    if empty?
      puts "it's empty !" 
    else
      popped = @stack[@length-1]
      puts "you popped #{popped}"
      @stack[@length-1] = nil
      @length -= 1
      popped
    end
  end

  def peek
    puts "last item is #{@stack[@length-1]}"
    @stack[@length-1]
  end

  def empty?
    return true if @length == 0
  end
end
  
new_stack = Stack.new
new_stack.push 10
new_stack.push 20
new_stack.push 30
new_stack.peek
new_stack.pop
new_stack.pop
new_stack.empty?
new_stack.pop
new_stack.empty?

new_stack2 = Stack.new
"hello".split("").each do |char|
  new_stack2.push char
end
result = ""
new_stack2.length.times do
  result += new_stack2.pop
end
puts result







