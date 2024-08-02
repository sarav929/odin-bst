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
  
  def insert(data, node = @root)

    new_node = Node.new(data)
    
    return new_node if node.nil? #found position
    if data < node.data
      node.left = insert(data, node.left)
    elsif data > node.data
      node.right = insert(data, node.right)
    end

    return node
  end

  #####
  
  def delete(data, node = @root)

    return node if node.nil? 

    if data < node.data
      node.left = delete(data, node.left)
    elsif data > node.data
      node.right = delete(data, node.right)
    else
      #1. Node to be deleted is a leaf (no children): Simply remove the node.
      return nil if node.left.nil? && node.right.nil?    
      #2.Node to be deleted has one child: Replace the node with its child.
      return node.left if node.right.nil?
      return node.right if node.left.nil? 
    
      #3. Node to be deleted has two children:
      #Find the in-order successor (the smallest value in the right subtree)
      successor = find_min(node.right)
      #Replace the node's value with the in-order successor.
      node.data = successor.data
      #Recursively delete the in-order successor.
      node.right = delete(successor.data, node.right)
      
    end
    return node
  end

  ######

  def find(data, node = @root)
    return node if node.data == data
    return nil if node.nil?

    if data < node.data
      find(data, node.left)
    elsif data > node.data
      find(data, node.right)
    end
  end

  #######
  
  def level_order(node = @root, &block)
    return [] if node.nil? 

    result = []
    queue = [node]

    while !queue.empty? 
      current = queue.shift
      result << current
      queue << current.left if current.left
      queue << current.right if current.right
      yield current if block.given? 
    end

    return result
  end

  #####
  def inorder(node = @root, result = [], &block) # left, root, right
    return result if node.nil? 
    inorder(node.left, result, &block)
    if block_given?
      yield node
    else
      result << node.data
    end
    inorder(node.right, result, &block)
    result
  end

  ###
  def postorder(node = @root, result = [], &block) # left, right, root
    return result if node.nil? 
    postorder(node.left, result, &block)
    postorder(node.right, result, &block)
    if block_given? 
      yield node
    else
      result << node.data
    end 
    result
  end

  ###
  def preorder(node = @root, result = [], &block) # root, left, right
    return result if node.nil?
    if block_given?
      yield node
    else
      result << node.data
    end 
    preorder(node.left, result, &block)
    preorder(node.right, result, &block)
    result
  end

  ####
  def height(node)
    return -1 if node.nil?

    left_height = height(node.left)
    right_height = height(node.right)

    return [left_height, right_height].max + 1
  end

  ####
  
  def depth(node, current_node = @root, depth = 0)

    return -1 if node.nil? || current_node.nil? 
    return depth if current_node == node 
    
    left_depth = depth(node, current_node.left, depth + 1)
    return left_depth if left_depth != -1
    right_depth = depth(node, current_node.right, depth + 1)
    return right_depth if right_depth != -1

    return -1 #if not found
  end



  private 
  def find_min(node)
    current = node
    current = node.left while node.left #go through left subtree of right node
    current   
  end

  

end