def ns(s)
  NSString.new(s)
end

describe "NSString" do

  it "maps cococa NSString class" do
    NSString.nsclass.name.should eq("NSString")
  end

  it "length" do
    ns("").length.should eq(0)
    ns("a").length.should eq(1)
    ns("lorem").length.should eq(5)
  end

  it "[]" do
    ns("a")[0].should eq('a')
    ns("lorem")[2].should eq('r')
  end

  it "to_s" do
    ns("lorem").to_s.should eq("lorem")
  end

  it "should be a NSObject" do
    ns("lorem").is_a?(NSObject)
  end
end
