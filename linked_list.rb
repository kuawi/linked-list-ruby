class Node
  attr_accessor :value, :next_node

  def initialize(value = nil, next_node = nil)
    @value = value
    @next_node = next_node
  end
end

class LinkedList # rubocop:todo Metrics/ClassLength
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

  def at(index)
    return nil if index >= @size || index.negative?

    node = head
    index.times { node = node.next_node }
    node
  end

  def shift
    prev_head = @head
    @head = at(1)
    @size -= 1
    prev_head
  end

  def pop # rubocop:todo Metrics/MethodLength
    return 'Cannot pop empty list' if @size.zero?

    prev_node = nil
    current_node = @head
    while current_node.next_node
      prev_node = current_node
      current_node = current_node.next_node
    end
    if @size == 1 then @head = @tail = nil
    else
      prev_node.next_node = nil
      @tail = prev_node
    end
    @size -= 1
    current_node
  end

  def contains?(value)
    coincidence = false
    current_node = @head
    while current_node
      coincidence = current_node.value == value
      break if coincidence

      current_node = current_node.next_node
    end
    coincidence
  end

  def find(value) # rubocop:todo Metrics/MethodLength
    coincidence = false
    current_node = @head
    index = 0
    while current_node
      coincidence = current_node.value == value
      break if coincidence

      current_node = current_node.next_node
      index += 1
    end
    return nil unless coincidence

    index
  end

  def insert_at(value, index)
    return prepend(value) if index.zero?
    return append(value) if index == @size

    prev_node = at(index - 1)
    return 'Invalid index' unless prev_node

    prev_node.next_node = Node.new(value, at(index))
    @size += 1
    prev_node.next_node.value
  end

  def delete_at(index)
    return 'Invalid index' if index >= @size
    return pop if index == @size - 1
    return shift if index.zero?

    prev_node = at(index - 1)
    return 'Invalid index' unless prev_node

    del_node = prev_node.next_node
    prev_node.next_node = del_node.next_node
    @size -= 1
    del_node
  end
end

my_list = LinkedList.new
('a'..'e').each { |i| my_list.append(i) }
puts my_list
