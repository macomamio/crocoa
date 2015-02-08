require "./nscontrol_spec"

def new_text_field
  NSTextField.new(NSRect.new(0, 0, 200, 200))
end

describe "NSTextField" do
  describe_nscontrol new_text_field

  it "value can be get/set" do
    c = new_text_field
    c.value = "Lorem ipsum"
    c.value.to_s.should eq("Lorem ipsum")
  end
end
