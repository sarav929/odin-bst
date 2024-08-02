require_relative 'lib/node'
require_relative 'lib/tree'

def pretty_print(node = @root, prefix = '', is_left = true)
  pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
  puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
  pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
end

# test

array = [1,2,3,4,5,6,7,8,9,10]

tree = Tree.new(array)

pretty_print(tree.root)

tree.delete(2)

pretty_print(tree.root)