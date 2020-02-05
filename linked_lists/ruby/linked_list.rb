class LinkedList
  attr_reader :count,
              :head

  def initialize()
    @count = 0
    @head  = nil
  end

  def push(data)
    new_node = Node.new(data)
    if @head == nil
      @head = new_node
    else
      prev = @head
      while prev.next_node != nil
        prev = prev.next_node
      end
      prev.next_node = new_node
    end
    @count += 1
  end

  def pop()
    return nil unless @head
    if @head.next_node.nil?
      data = @head.data
      @head = nil
      @count -= 1
      return data
    end

    prev = @head
    curr = prev.next_node

    while curr.next_node != nil
      prev = prev.next_node
      curr = curr.next_node
    end
    prev.next_node = nil
    
    @count -= 1
    return curr.data
  end

  def delete(data)
    return 0 unless @head
    if @head.data == data
      @head = @head.next_node
      return @count -= 1
    end

    prev = @head
    curr = prev.next_node

    while curr
      if curr.data == data
        prev.next_node = curr.next_node
        return  @count -= 1
      end
      prev = prev.next_node
      curr = curr.next_node
    end
    @count
  end

  def to_a
    return [] unless @head
    array = []
    curr = @head
    while curr
      array.push(curr.data)
      curr = curr.next_node
    end
    array
  end

  def last_node
    return nil unless @head

    curr = @head
    while curr.next_node
      curr = curr.next_node
    end
    curr
  end

  def head_node
    @head
  end

  def include?(data)
    return find(data) ? true : false
  end

  def find(data)
    return nil unless @head
    return @head if @head.data == data

    curr = @head.next_node
    while curr
      return curr if curr.data == data
      curr = curr.next_node
    end
    curr
  end

  def index(data)
    return -1 unless @head
    return 0 if @head.data == data

    i = 1
    curr = @head.next_node
    while curr
      return i if curr.data == data
      curr = curr.next_node
      i += 1
    end
    -1
  end

  def insert(i, data)
    return nil if i > @count
    @count += 1
    return @head = Node.new(data, @head) if i == 0

    currIndex = 1
    curr = @head
    while currIndex < i
      currIndex += 1
      curr = curr.next_node
    end

    curr.next_node = Node.new(data, curr.next_node)
  end

  def insert_after(prev_data, data)
    found_node = find(prev_data)
    found_node.next_node = Node.new(data, found_node.next_node) if found_node
  end

  def distance(first_data, second_data)
    return -1 if count < 2
    x = nil
    y = nil

    curr = @head
    currIndex = 0
    while curr
      if curr.data == first_data || curr.data == second_data
        x ? y = currIndex : x = currIndex
        return (x - y).abs if y
      end
      curr = curr.next_node
      currIndex += 1
    end
    return -1
  end
end