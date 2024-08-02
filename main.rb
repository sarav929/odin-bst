require_relative 'lib/node'
require_relative 'lib/tree'

def pretty_print(node = @root, prefix = '', is_left = true)
  pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
  puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
  pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
end

# test

array = (Array.new(15) { rand(1..100) })

tree = Tree.new(array)

pretty_print(tree.root)

if tree.balanced?(tree.root) 
  puts "The tree is balanced" 
else 
  puts "The tree is not balanced"
end

puts "Level-order: #{tree.level_order(tree.root).join(', ')}"
puts "In-order: #{tree.inorder(tree.root).join(', ')}"
puts "Pre-order: #{tree.preorder(tree.root).join(', ')}"
puts "Post-order: #{tree.postorder(tree.root).join(', ')}"

tree.insert(104)
tree.insert(110)
tree.insert(150)
tree.insert(126)

if tree.balanced?(tree.root) 
  puts "The tree is balanced" 
else 
  puts "The tree is not balanced"
end

puts "Rebalancing..."
tree.rebalance(tree)

if tree.balanced?(tree.root) 
  puts "The tree is balanced" 
else 
  puts "The tree is not balanced"
end

puts "Level-order: #{tree.level_order(tree.root).join(', ')}"
puts "In-order: #{tree.inorder(tree.root).join(', ')}"
puts "Pre-order: #{tree.preorder(tree.root).join(', ')}"
puts "Post-order: #{tree.postorder(tree.root).join(', ')}"

