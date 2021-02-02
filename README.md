# Circular Linked List

Implementation for the circular linked list data structure for Ruby.

List is composed by nodes, which have each one a value and a next item.

## Installation

Just add to your Gemfile:

```
gem "circular_linked"
```

Then

```
$ bundle install
```

Or you can install the gem directly from terminal:

```
$ gem install circular_linked
```

## Usage

```ruby
items_list = CircularLinked::List.new(1, 2, 3)
empty_list = CircularLinked::List.new

items_list.head #=> #<Node:0x... @value=1 ...
empty_list.head #=> nil

items_list.add(4) # List now have nodes with the values: 1, 2, 3, 4

items_list.last_node #=> 4
empty_list.last_node #=> nil

items_list.find(2) #=> #<Node:0x... @value=2 ...
empty_list.find(2) #=> nil

items_list.remove(3) # List now have nodes with the values: 1, 2, 4
empty_list.remove(3) # List remains empty

items_list.items_value #=> [1,2,4]
empty_list.items_value #=> []

items_list.length #=> 3
empty_list.length #=> 0

items_list.each {|node| puts node.value }
#=> 1
#=> 2
#=> 4
empty_list.each {|node| puts node.value }
#=>
```

## Development

Just run `bundle install` to install the dependencies and you are ready.

## Tests

To run the specs, after installing the dependecies as said above, you can just run in the main folder:

```
$ rspec .
```

## Contributing

Feel free to open pull requests/issues or to fork this repo.
