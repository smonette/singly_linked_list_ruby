require "./list_1"

describe List do
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
end