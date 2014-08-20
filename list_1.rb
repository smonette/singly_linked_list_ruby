class List

## Start List Node
  class Node
    attr_accessor :value, :next
  end

## Then the Basic List

  def initialize()
  end

  # empty?

  # head

  # head=

  # prepend

  # ==

  # eql?

  # tail

## Then the Insertion Methods

  def insert(index, value)
  end
  
  def insert_before(index, value)
  end

  def insert_after(index, value)
  end

  def shift
  end

  def unshift(val)
  end

## Then the Iterator Methods

  def each
  end

  def map!
  end

  def map(&b)
  end

## Then Extra methods

  def append(list)
  end

  def reverse
  end

  def reverse!
  end

  def clone
  end

  def [](index)
  end

  def []=(index,value)
  end

  def to_s
  end
end
