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
end