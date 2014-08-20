require "./list_1"

describe List do
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
end