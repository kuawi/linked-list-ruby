class Node
  attr_accessor :value, :next_node

  def initialize(value = nil, next_node = nil)
    @value = value
    @next_node = next_node
  end
end

class LinkedList
  attr_accessor :head, :tail, :size

  def initialize
    @head = @tail = nil
    @size = 0
  end

  def prepend(value = nil)
    @size += 1
    @head = Node.new(value, @head)
    @tail = @head if @size == 1
    @head.value
  end

  def append(value = nil)
    @size += 1
    temp = Node.new(value)
    if @tail
      @tail = @tail.next_node = temp
    else
      @head = @tail = temp
    end
    @tail.value
  end

  def to_s
    next_node = @head
    string = ''
    string = 'Empty list' unless next_node
    while next_node
      current_node = next_node
      string += "(#{current_node.value}) -> "
      next_node = current_node.next_node
      string += 'nil' unless next_node
    end
    string
  end
end
