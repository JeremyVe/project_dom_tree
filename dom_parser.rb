require_relative "file_loader"

Tag = Struct.new(:type, :classes, :id, :name, :text, :children, :parent, :depth, :closing)

class Parser

  TYPE_R = /<(\w*)\b/
  CLASS_R = /class\s*=\s*'(.*?)'/
  ID_R = /id\s*=\s*'(.*?)'/
  NAME_R = /name\s*=\s*'(.*?)'/
  ALL_TAG_R = /(<.*?>)/
  OPEN_TAG_R = /(<\w*?>)/
  CLOSE_TAG_R = /(<\/\w*?>)/


  def initialize
    @file_loader = FileLoader.new
    @html_string = ""
    @root = Tag.new("document", nil, nil, nil, nil, [])
    @root.depth = 0
    @element_text = nil
    @count = 0
  end

  def build_tree( file_name = "/minitest.html")
    @html_string = @file_loader.load(file_name)
    parse_html
  end


  def parse_html( string = @html_string )
    depth = 0
    @element_text = string.split(ALL_TAG_R).map { |element| element.strip }

    current_node = @root
    @element_text.each_with_index do |element, index|
      if element.match(OPEN_TAG_R)
        current_node.children << set_attributes_tag(element, depth, current_node)
        current_node = current_node.children.last
        depth += 1
        @count += 1
      elsif
        element.match(CLOSE_TAG_R)
        current_node.children.last.closing = element.match(CLOSE_TAG_R)[0]
        current_node = current_node.parent
        depth -= 1
      else # its text
        current_node.children << set_text_tag(element, depth, current_node)
        @count += 1
      end
    end
  end

  def set_attributes_tag(tag_info, depth, parent)
    new_tag = Tag.new(nil, nil, nil, nil, nil, [], parent)
    new_tag.type = tag_info.match(TYPE_R).captures[0]
    new_tag.classes = tag_info.match(CLASS_R).captures.join.split(" ") if tag_info.match(CLASS_R)
    new_tag.id = tag_info.match(ID_R).captures.join.split(" ") if tag_info.match(ID_R)
    new_tag.name = tag_info.match(NAME_R).captures[0] if tag_info.match(NAME_R)
    new_tag.depth = depth

    new_tag
  end

  def set_text_tag(text, depth, parent)
    new_tag = Tag.new(nil, nil, nil, nil, nil, [], parent)
    new_tag.type = "text"
    new_tag.text = text
    new_tag.depth = depth

    new_tag
  end

  def print_tree
    stack = [@root.children.last]
    while current_node = stack.pop
      if current_node.text.nil?
        print " " * current_node.depth + "<#{current_node.type}> \n"
        stack << current_node.children.pop until current_node.children.empty?
      else
        print " " * current_node.depth + current_node.text + "\n"

      end
      print " " * (current_node.depth-1) + current_node.closing + "\n" if current_node.closing 
    end
  end

end

dom = Parser.new
html_string = "<div>  div text before  <p>    p text  </p>  <div>    more div text  </div>  div text after</div>"

dom.parse_html(html_string)

dom.print_tree



















