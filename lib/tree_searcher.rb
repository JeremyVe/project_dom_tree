require_relative 'dom_parser'
require_relative 'node_renderer'

class TreeSearcher
  attr_reader :tree, :matches
  def initialize( tree )
    @tree = tree
    @matches = []
  end

  def search_by( attribute, att_name )
    puts "You are searching for #{attribute}, #{att_name}"
    find_matches( attribute, att_name )
    puts "We find #{@matches.length} matches !"
    render_matches
  end

  def render_matches
    @matches.each do |node|
      puts "type: #{node.type} / classes: #{node.classes} / id: #{node.id}"
    end
  end

  def find_matches( attribute, attr_name, node = @tree.root )
    stack = [node]
    while current_node = stack.pop
      if current_node[attribute]
        @matches << current_node if current_node[attribute].include?(attr_name)
      end
      current_node.children.each { |child| stack << child }
    end
  end

  def search_children( attribute, attr_name, node )
    puts "You are searching for #{attribute}, #{att_name}"
    find_matches( attribute, att_name, node )
    puts "We find #{@matches.length} matches !"
    render_matches
  end

  def search_ancestror( attribute, attr_name, node )
    puts "You are searching for #{attribute}, #{att_name}"
    find_matches_ancestors( attribute, att_name, node )
    puts "We find #{@matches.length} matches !"
    render_matches
  end

  def find_matches_ancestors( attribute, attr_name, node )
    stack = [node]
    while current_node = stack.pop
      if current_node[attribute]
        @matches << current_node if current_node[attribute].include?(att_name)
      end
      stack << current_node.parent unless current_node.parent.nil?
    end
  end
end

tree = Parser.new
tree.parse_html

searcher = TreeSearcher.new( tree )
searcher.search_by(:type, "div")