require "./list_1"

describe List do
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