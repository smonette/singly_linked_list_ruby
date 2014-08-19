class List
  class Node
    attr_accessor :value, :next
    def initialize(value=nil, next_val=nil)
      @value = value
      @next = next_val
    end
  end

  def initialize()
    @node = nil
  end

  def empty?
    @node == nil
  end

  def head
    @node ? @node.value: nil
  end

  def head=(value)
    unless empty?
      @node.value = value
    else
      @node = Node.new(value)
    end
    self
  end

  def prepend(value)
    @node = Node.new(value, @node)
    self
  end

  def append(list)
    unless list.empty?
      count = 0
      first = last = nil
      list.each do |val|
        if count > 0
          last.next = Node.new(val)
          last = last.next
        else
          first = last = Node.new(val)
          count += 1
        end
      end

      unless empty?
        last = @node
        while last.next
          last = last.next
        end
        last.next = first
      else
        @node = first
      end
    end
    self
  end

  def reverse
    new_list = List.new
    each do |val|
      new_list.prepend(val)
    end
    new_list
  end

  def reverse!
    return self if empty? || @node.next.nil?
    next_node = @node.next
    current_node = @node
    current_node.next = nil
    while next_node
      hldr = next_node.next
      next_node.next = current_node
      current_node = next_node
      next_node = hldr
    end
    @node = current_node
    self
  end

  def clone
    reverse.reverse!
  end

  def ==(other)
    return false unless other.instance_of? List
    is_eql = true
    current = @node
    other.each do |val|
      return false if current.nil? || !is_eql
      is_eql = current.value == val
      current = current.next
    end
    is_eql
  end

  def eql?(other)
    self == other
  end

  def tail
    raise NoMethodError if empty?
    new_list = clone
    new_list.shift
    new_list
  end

  def shift
    old_head = head
    unless empty?
      @node = @node.next
    end
    old_head
  end

  def unshift(val)
    prepend(val)
    self
  end

  def insert(index, value)
    return prepend(value) if index == 0
    current = @node
    count = 0
    while count < index - 1 && current
      count += 1
      current = current.next
    end
    raise RangeError unless current && index > 0
    current.next = Node.new(value, current.next)
    self
  end
  
  def insert_before(index, value)
    insert(index, value)
  end

  def insert_after(index, value)
    return prepend(value) if empty? && index == 0
    insert(index + 1, value)
  end

  def each
    current = @node
    until current.nil?
      yield current.value
      current =  current.next
    end
    self
  end

  def map!
    current = @node
    until current.nil?
      current.value = yield current.value
      current = current.next
    end
    self
  end

  def map(&b)
    reverse.map!(&b).reverse!
  end

  def [](index)
    count = 0
    each do |value|
      if count == index
        return value
      end
      count += 1
    end
    nil
  end

  def []=(index,value)
    count = 0
    @node = @node || Node.new
    current = @node
    until count == index
      if current.next.nil?
        current.next = Node.new
      end
      current = current.next
      count += 1
    end
    current.value = value
  end

  def to_s
    unless empty?
      print_list = "(#{@node.value || "nil"}"
      current = @node.next
      while current
        print_list += ", #{current.value|| "nil"}"
        current = current.next
      end
      print_list += ")"
    else
      "()"
    end
  end
end
