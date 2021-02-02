module CircularLinked
  class List

    attr_accessor :head
  
    def initialize(*values)
      nodes = values.map {|v| Node.new(v) }
      @head = nodes.first
      nodes.each_with_index {|node, i| node.next = nodes[i+1] || @head }
    end
  
    def add(value)
      new_node = Node.new(value, head)
      
      @head ||= new_node
      new_node.next ||= head
      
      last_node.next = new_node
    end
  
    def last_node
      return nil unless head
  
      node = head
      node = node.next while node.next != head
      node
    end
  
    def find(value)
      return nil unless head
  
      node = head
      while node.value != value
        node = node.next
        return nil if node == head
      end
      
      node
    end
  
    def remove(value)
      node = find(value)
      return unless node
  
      if head.next == head
        @head = nil
        return
      end
  
      node_before = head
      node_before = node_before.next while node_before.next != node
      node_before.next = node.next
      
      @head = node.next if node == head
    end
  
    def items_value
      values = []
      return values unless head
      
      each {|node| values.push(node.value) }
      values
    end
  
    def length
      length = 0
      return length unless head
  
      each { length += 1 }
      length
    end
  
    def each
      return unless head 
      
      node = head
      loop do
        yield(node)
        node = node.next
        break if node == head        
      end
    end
  end  
end