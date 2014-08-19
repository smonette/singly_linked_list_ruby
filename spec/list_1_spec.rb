require "./list_1"

describe List do
  describe "::Node" do
    describe "accessors" do
      before(:each) do
        @node = List::Node.new
      end

      it "should include \#value and \#value=" do
        expect(@node).to respond_to :value
        expect(@node).to respond_to :value=
      end

      it "should include \#next and \#next=" do
        expect(@node).to respond_to :next
        expect(@node).to respond_to :next=
      end
    end

    describe "default behaviors" do
      it "should initialize value and next to nil" do 
        node = List::Node.new
        expect(node.value).to be(nil)
        expect(node.next).to be(nil)
      end

      it "should accept :value and :next in the constructor" do
        node = List::Node.new("foo", "bar")
        expect(node.value).to eql("foo")
        expect(node.next).to eql("bar")
      end
    end
  end

  describe "accessors" do
    before(:each) do
      @list = List.new
    end

    it "should include \#head" do
      expect(@list).to respond_to :head
    end

    it "should include \#head=" do
      expect(@list).to respond_to :head=
    end

    it "should include \#tail" do
      expect(@list).to respond_to :tail
    end
  end

  describe "#head and #head=" do 
    before(:each) do
      @list = List.new
    end

    it "should update the head" do
      @list.head = 2
      expect(@list.head).to eql(2)
    end

    it "should create a node to update an empty list" do
      expect(List::Node).to receive(:new).with(1)
      @list.head = 1
    end

    it "should return the head" do
      @list.head = 1
      expect(@list.head).to eql(1)
    end

  end

 
  describe "#prepend" do
   
    it "should create a node for prepended value" do
      list = List.new
      expect(List::Node).to receive(:new).with(1,nil)
      list.prepend(1)
      expect(List::Node).to receive(:new).with(2, anything())
      list.prepend(2)
    end

    it "should update head if empty" do
      list = List.new
      list.prepend 1 
      expect(list.head).to eql(1)
    end
    
    it "should insert at head if not empty" do
      list = List.new
      list.prepend(3).prepend(2)
      expect(list.tail.head).to eql(3)
    end
  end

  describe "#emtpy?" do
    it "should return true if head node is nil" do
      list = List.new
      expect(list.empty?).to be(true)
    end

    it "should return true if head node is not null" do
      list = List.new.prepend(1)
      expect(list.empty?).to be(false)
    end
  end

  describe "#tail" do
    before(:each) do
      @list = List.new
      @list.prepend(3).prepend(2).prepend(1)
    end

    it "should return an empty for 1 item list" do
      list = List.new.prepend(1)
      expect(list.tail.empty?).to be(true)
    end
    it "should return the correct tail" do
      tail_list = List.new
      tail_list.prepend(3).prepend(2)
      expect(@list.tail).to eql(tail_list)
    end

    it "should return an Error for empty list" do
      new_list = List.new
      expect{new_list.tail}.to raise_error(NoMethodError)
    end
  end

  describe "#==" do
    it "should return true for emtpy lists" do
      expect(List.new == List.new).to be(true)
    end
    it "should return true lists with same node values" do
      list_one = List.new.prepend(1).prepend(2)
      list_two = List.new.prepend(1).prepend(2)
      expect(list_one == list_two).to be(true)
    end
  end

  describe "#eql?" do
    it "should return true for empty lists" do
      expect(List.new).to eql(List.new)
    end

    it "should return true lists with same node values" do
      list_one = List.new.prepend(1).prepend(2)
      list_two = List.new.prepend(1).prepend(2)
      expect(list_one).to eql(list_two)
    end
  end

  describe "#[]" do
    it "should return nil for index out of range" do
      list = List.new
      expect(list[1]).to be(nil)
    end

    it "should return value at index if within range" do
      list = List.new.prepend(2).prepend(1)
      expect(list[1]).to be(2)
      expect(list[0]).to be(1)
    end
  end

  describe "#[]=" do
    it "should update value for index in valid range" do
      list = List.new.prepend(2).prepend(1)
      list[1] = 3
      expect(list[1]).to be(3)
    end

    it "should create node at nonexistant index" do
      list = List.new.prepend(1)
      list[2] = 3
      expect(list[0]).to be(1)
      expect(list[2]).to be(3)
    end

    it "should create nil nodes for index greater than length" do
      list = List.new
      list[2] = 1
      expect(list[0]).to be(nil)
      expect(list[1]).to be(nil)
    end
  end

  describe "#append" do
    it "appending an empty list should not change the list" do
      list_one = List.new
      list_one.prepend 1
      list_two = List.new
      list_one.append(list_two).append(list_two)
      expect(list_one.tail.empty?).to be(true)
    end

    it "should add list values to end of a list" do
      list_one = List.new().prepend(2).prepend(3)
      list_two = List.new().prepend(0).prepend(1)
      list_three = List.new()
      (0..3).each do |num|
        list_three.prepend(num)
      end
      expect(list_one.append(list_two)).to eql(list_three)
    end
    
    it "should add allow a list to append itself" do
      list = List.new().prepend(2).prepend(1)
      new_list = List.new
      [2,1,2,1].each do |num|
        new_list.prepend(num)
      end
      expect(list.append(list)).to eql(new_list)
    end
  end

  describe "#reverse!" do
    before(:each) do
      @list = List.new
      @new_list = List.new
      (1..5).each do |num|
        @list.prepend(num)
        @new_list.prepend(6-num)
      end
    end

    it "should return a reversed list" do
      expect(@list.reverse!).to eql(@new_list)
    end

    it "should be destructive" do
      expect(@list.reverse!).to be(@list)
    end
  end

  describe "#reverse" do
    before(:each) do
      @list = List.new
      @new_list = List.new
      (1..5).each do |num|
        @list.prepend(num)
        @new_list.prepend(6-num)
      end
    end

    it "should return a reversed list" do
      expect(@list.reverse).to eql(@new_list)
    end

    it "should not be destructive" do
      expect(@list.reverse).not_to be(@list)
    end
  end

  describe "#clone" do
     before(:each) do
      @list = List.new
      (1..5).each do |num|
        @list.prepend(num)
      end
      @clone = @list.clone
    end

    it "should return a new list" do
      expect(@clone).to_not be(@list)
    end

    it "should be eql to list" do
      expect(@clone).to eql(@list)
    end
  end
  
  describe "#unshift" do
     before(:each) do
      @list = List.new
      @new_list = List.new
      (1..5).each do |num|
        @list.prepend(num)
        @new_list.unshift(num)
      end
    end

    it "should prepend elements to front of a list" do
      expect(@new_list).to eql(@list)
    end

    it "should return self" do
      expect(@new_list.prepend(6)).to be(@new_list)
    end
  end
 
  describe "#shift" do
    before(:each) do
      @list = List.new
      @new_list = List.new
      (1..5).each do |num|
        @list.prepend(num)
        if num < 5
         @new_list.prepend(num)
        end
      end
    end

    it "should remove the head node" do
      @list.shift
      expect(@list).to eql(@new_list)
    end

    it "should return the shifted head value" do 
      expect(@list.shift).to eql(5)
    end

    it "should return nil if empty" do
      expect(List.new.shift).to be(nil)
    end
  end

  describe "to_s" do
    it "should return '()' for an empty list" do
      expect(List.new.to_s).to eql("()")
    end

    it "should return a comma separated list" do
      list = List.new
      (1..5).each {|n| list.prepend(n) }
      expect(list.to_s).to eql("(5, 4, 3, 2, 1)")
    end
  end

  describe "#each" do
    before(:each) do
      @list = List.new
      @new_list = List.new
      (1..5).each do |num|
        @list.prepend(num)
      end
    end

    it "should iterate over each value" do
      @list.reverse.each do |num|
        @new_list.prepend num
      end
      expect(@new_list).to eql(@list)
    end

    it "should return self" do
      @list.prepend(1).prepend(2)
      expect(@list.each {}).to be(@list)
    end
  end

  describe "#map" do
    before(:each) do
      @list = List.new
      (1..5).each do |n|
        @list.prepend(n)
      end
    end
    
    it "should return a list" do
      new_list = @list.map {|n| n}
      expect(new_list.instance_of?(List)).to be(true)
    end

    it "should use List#each to iterate" do
      expect(@list).to receive(:each).once
      @list.map {}
    end

    it "should map each value to a new value in a list" do
      target_list = List.new
      @list.reverse.each {|n| target_list.prepend(2*n)}
      expect(@list.map {|n| 2*n}).to eql(target_list)
    end

  end

  describe "insertion" do
    before(:each) do
      @list = List.new
      @populated_list = List.new
      (0..5).each do |num|
        @populated_list.prepend(num)
      end
    end

    describe "#insert" do

      it "should prepend if insert at 0 index" do
        target_list = List.new
        target_list.prepend(1).prepend(2)
        @list.insert(0,1).insert(0,2)
        expect(@list).to eql(target_list)
      end

      it "should raise an error if index greater than length of list" do
        expect {@populated_list.insert(7,6)}.to raise_error(RangeError)
      end

      it "should raise an error for a negative index" do
        expect {@populated_list.insert(-1,0)}.to raise_error(RangeError)
      end

      it "should return self" do
        expect(@populated_list.insert(6,6)).to be(@populated_list)
      end

      it "should insert before a given index" do
        @populated_list.insert(3,3.5)
        expect(@populated_list[3]).to eql(3.5)
      end
    end

    describe "#insert_before" do
      it "should be an alias for List#insert" do
        expect(@populated_list).to receive(:insert).once
        @populated_list.insert_before(3,3.5)
      end
    end
    
    describe "#insert_after" do
      
      it "should call List#insert for indexes > -1" do
        expect(@populated_list).to receive(:insert).with(3, 3.5)
        @populated_list.insert_after(2,3.5)
      end

      it "should call prepend if empty and index 0" do
        expect(@list).to receive(:prepend).with(1)
        @list.insert_after(0, 1)
      end
    end
  end
end
