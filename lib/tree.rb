require_relative 'node'

class Tree 

  attr_accessor :root 
  
  def initialize(array)
    @root = build_tree(array.sort.uniq) 
  end

  #####
  
  def build_tree(array, start = 0, end_index = array.length - 1)

    return nil if start > end_index
    mid = (start + end_index) / 2

    root_node = Node.new(array[mid])
    root_node.left = build_tree(array, start, mid - 1)
    root_node.right = build_tree(array, mid + 1, end_index)

    return root_node
  end

  ######
  
  def insert(data, root = @root)
    
    new_node = Node.new(data)
    
    return new_node if root.nil? #found position
    if data < root.data
      root.left = insert(data, root.left)
    elsif data > root.data
      root.right = insert(data, root.right)
    end

    return root
  end

end