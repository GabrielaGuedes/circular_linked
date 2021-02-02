require_relative '../../lib/circular_linked/node.rb'

RSpec.describe CircularLinked::Node do
  describe "#initialize" do
    let(:value) { "Value" }

    context "when there is no next_node" do
      let(:value) { "Value" }
      subject(:new_node) { described_class.new(value) }

      it "saves the params passed" do
        expect(new_node.value).to eq(value)
        expect(new_node.next).to eq(nil)
      end
    end

    context "when there is next_node" do
      let(:next_node) { described_class.new("Next node value")}
      subject(:new_node) { described_class.new(value, next_node) }

      it "saves the params passed" do
        expect(new_node.value).to eq(value)
        expect(new_node.next).to eq(next_node)
      end
    end
  end
end
