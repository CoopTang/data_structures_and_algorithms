class LinkedList
  attr_reader :count,
              :head

  def initialize()
    @count = 0
    @head  = nil
  end

  def push(data)
    @count += 1
    return @head = Node.new(data) unless @head
    push_recursive(data, @head)
  end

  def push_recursive(data, curr)
    curr.next_node ? push_recursive(data, curr.next_node)
                   : curr.next_node = Node.new(data)
  end

  def pop()
    return nil unless @head
    @count -= 1
    
    if @head.next_node.nil?
      data = @head.data
      @head = nil
      return data
    end

    pop_recursive(@head.next_node, @head)
  end

  def pop_recursive(curr, prev)
    if curr.next_node
      pop_recursive(curr.next_node, curr)
    else
      prev.next_node = nil
      curr.data
    end
  end

  def delete(data)
    return nil unless @head
    if @head.data == data
      @count -= 1
      return @head = @head.next_node
    end
    delete_recursive(@head, data)
  end

  def delete_recursive(curr, data, prev = nil)
    return nil unless curr
    if curr.data == data
      prev.next_node = curr.next_node
      @count -= 1
    end
    delete_recursive(curr.next_node, data, curr)
  end

  def to_a
    return [] unless @head
    array = []
    to_a_recursive(@head, array)
    array
  end

  def to_a_recursive(curr, array)
    array.push(curr.data)
    to_a_recursive(curr.next_node, array) if curr.next_node
  end

  def last_node(curr = @head)
    curr.next_node ? last_node(curr.next_node) : curr
  end

  def head_node
    @head
  end

  def include?(data)
    return find(data) ? true : false
  end

  def find(data)
    return nil unless @head
    find_recursive(data)
  end

  def find_recursive(data, curr = @head)
    return curr if curr.data == data
    find_recursive(data, curr.next_node) if curr.next_node
  end

  def index(data)
    return -1 unless @head
    index_recursive(data, @head, 0)
  end

  def index_recursive(data, curr, curr_index)
    if curr.data == data
      curr_index
    else 
      curr.next_node ? index_recursive(data, curr.next_node, curr_index + 1)
                     : -1
    end
  end

  def insert(i, data)
    return nil if i > @count
    @count += 1
    return @head = Node.new(data, @head) if i == 0

    insert_recursive(i, @head, 1, data)
  end

  def insert_recursive(i, curr, curr_index, data)
    curr_index < i ? insert_recursive(i, curr.next_node, curr_index + 1, data)
                   : curr.next_node = Node.new(data, curr.next_node)
  end

  def insert_after(prev_data, data)
    found_node = find(prev_data)
    found_node.next_node = Node.new(data, found_node.next_node) if found_node
  end

  def distance(first_data, second_data)
    return -1 if count < 2
    node_a = find_with_index(first_data)
    node_b = find_with_index(second_data, node_a[:node], node_a[:index])
    (node_a[:index] - node_b[:index]).abs
  end

  def find_with_index(data, curr = @head, curr_index = 0)
    return nil unless @head

    find_with_index_recursive(data, curr, curr_index)
  end

  def find_with_index_recursive(data, curr, curr_index)
    if curr.data == data
      { node: curr, index: curr_index }
    else 
      if curr.next_node 
        find_with_index_recursive(data, curr.next_node, curr_index + 1)
      else 
        { node: nil, index: -1 }
      end
    end
  end
end