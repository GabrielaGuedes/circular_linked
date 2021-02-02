require_relative '../../lib/circular_linked/node.rb'
require_relative '../../lib/circular_linked/list.rb'

RSpec.describe CircularLinked::List do
  let(:value1) { "Node1" }
  let(:value2) { "Node2" }
  let(:value3) { "Node3" }
  let(:empty_list) { described_class.new }
  let(:head_list) { described_class.new(value1) }
  let(:two_item_list) { described_class.new(value1, value2) }
  let(:three_item_list) { described_class.new(value1, value2, value3) }

  describe "#initialize" do
    context "with no params" do
      it "just initializes empty list" do
        expect(empty_list.head).to eq(nil)
      end
    end

    context "with 1 item" do
      it "initializes list with just a head" do
        expect(head_list.head.value).to eq(value1)
        expect(head_list.head.next).to eq(head_list.head)
      end
    end
    
    context "with two items" do
      it "initializes a circular list" do
        expect(two_item_list.head.value).to eq(value1)
        expect(two_item_list.head.next.value).to eq(value2)
        expect(two_item_list.head.next.next).to eq(two_item_list.head)
      end
    end
  end

  describe "#last_node" do
    context "when list is empty" do
      it "returns nil" do
        expect(empty_list.last_node).to eq(nil)
      end
    end

    context "when list has only head" do
      it "returns head" do
        expect(head_list.last_node.value).to eq(value1)
      end
    end

    context "when list has three nodes" do
      it "returns last node" do
        expect(three_item_list.last_node.value).to eq(value3)        
      end
    end
  end

  describe "#add" do
    let(:new_value) { "New Value" }

    context "when list is empty" do
      it "adds the element as the head" do
        expect{empty_list.add(new_value)}.to change{empty_list.head&.value}
          .from(nil).to(new_value)
        expect(empty_list.head.next).to eq(empty_list.head)
      end
    end

    context "when list has only head" do      
      it "adds another element" do
        expect{head_list.add(new_value)}.to change{head_list.last_node.value}
          .from(head_list.head.value).to(new_value)
        expect(head_list.head.next).not_to eq(head_list.head)
        expect(head_list.last_node.next).to eq(head_list.head)
      end
    end

    context "when list has already three nodes" do
      let!(:old_last_node) { three_item_list.last_node }

      it "adds fourth node" do
        expect{three_item_list.add(new_value)}.to change{three_item_list.last_node.value}
          .from(old_last_node.value).to(new_value)
        expect(old_last_node.next).not_to eq(three_item_list.head)
        expect(three_item_list.last_node.next).to eq(three_item_list.head)    
      end
    end
  end

  describe "#find" do
    let(:value_outside_list) { "MissingNode" }

    context "when list is empty" do
      it "returns nil" do
        expect(empty_list.find(value_outside_list)).to eq(nil)
      end
    end

    context "when list has only head" do
      it "returns nil if head is not the element" do
        expect(head_list.find(value_outside_list)).to eq(nil)
      end

      it "returns the node if head is the element" do
        expect(head_list.find(value1)).to eq(head_list.head)        
      end
    end

    context "when list has three elements" do
      it "returns nil if value is not in list" do
        expect(three_item_list.find(value_outside_list)).to eq(nil)        
      end

      it "returns the node if value is in list" do
        expect(three_item_list.find(value3)).to eq(three_item_list.last_node)
      end
    end
  end

  describe "#remove" do
    context "when trying to remove non existing value" do
      it "does nothing" do
        expect{two_item_list.remove("Non existing Node")}.not_to change{two_item_list.head}
        expect{two_item_list.remove("Non existing Node")}.not_to change{two_item_list.head.next}
        expect{empty_list.remove("Non existing Node")}.not_to change{empty_list.head}
      end
    end

    context "when removing a value" do
      it "removes the node and update the links" do
        expect{three_item_list.remove(value2)}.to change{three_item_list.head.next.value}
          .from(value2).to(value3)
        expect(three_item_list.find(value2)).to eq(nil)
        expect(three_item_list.head.value).to eq(value1)
        expect(three_item_list.last_node.value).to eq(value3)
      end

      it "removes the head when is a head_list" do
        head_list.remove(value1)
        expect(head_list.head).to eq(nil)
        expect(head_list.find(value1)).to eq(nil)
      end

      it "removes the head when the removed value is the head" do
        expect{two_item_list.remove(value1)}.to change{two_item_list.head.value}
          .from(value1).to(value2)
        expect(two_item_list.find(value1)).to eq(nil)
        expect(two_item_list.last_node.value).to eq(value2)
      end

      it "removes the last note when the removed value is it" do
        expect{three_item_list.remove(value3)}.to change{three_item_list.head.next.next.value}
          .from(value3).to(value1)
        expect(three_item_list.find(value3)).to eq(nil)
        expect(three_item_list.head.value).to eq(value1)
        expect(three_item_list.last_node.value).to eq(value2)
      end
    end
  end

  describe "#items_value" do
    context "when list is empty" do
      it "returns empty array" do
        expect(empty_list.items_value).to eq([])
      end
    end
    
    context "when list has only head" do
      it "returns array with one value" do
        expect(head_list.items_value).to eq([value1])
      end
    end
    
    context "when list has three items" do
      it "returns array with three values" do
        expect(three_item_list.items_value).to eq([value1, value2, value3])        
      end
    end
  end

  describe "#length" do
    it { expect(empty_list.length).to eq(0) }
    it { expect(head_list.length).to eq(1) }
    it { expect(two_item_list.length).to eq(2) }
    it { expect(three_item_list.length).to eq(3) }
  end  
end
