require "./list_1"

describe List do

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
end
