require 'dom_parser'

describe Parser do
  let(:dom){Parser.new}
  it 'should handle simple tags' do
    dom.parse_html("<div>i'm a div</div><p>and i'm a paragraph</p>")
    expect(dom.count).to eq(2)
  end

  it "should handle tags with attributes"

  it 'should handle simple nested tags'

  it 'should handle text both before and after a nested tag'

  it 'should have the correct number of total nodes'
end