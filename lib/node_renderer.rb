require_relative 'dom_parser'

class NodeRenderer
  attr_reader :tree
  def initialize( tree )
    @tree = tree
  end

  def render( node = nil )
    node = @tree.root if node.nil?
    puts "Node attributes : type= #{node.type}, classes= #{node.classes}, id= #{node.id}, 
        depth= #{node.depth}, parent=#{node.parent}"

    stack = [node]
    count = 0 
    arr_type = []
    while current_node = stack.pop
      unless current_node.children.empty?
        current_node.children.each do |child|
          stack << child unless child.type == "text"
          count += 1 unless child.type == "text"
          arr_type << child.type
        end
      end
    end

    group = arr_type.inject(Hash.new(0)) { |h, name| h[name] += 1; h}
    group.each do |name, times|
      puts "#{name} was found #{times} times"
    end
    puts "There is #{count} element under the Node"
  end
end
tree = Parser.new
tree.parse_html

renderer = NodeRenderer.new( tree )
renderer.render