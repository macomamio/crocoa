module Crocoa
  struct NSRect
    def initialize(x, y, w, h)
      @origin = NSPoint.new(x, y)
      @size = NSSize.new(w, h)

      @obj = LibCF::Rect.new
      @obj.origin = @origin.to_objc
      @obj.size = @size.to_objc
    end

    def to_objc
      @obj
    end

    property :origin
    property :size

    delegate x, @origin
    delegate y, @origin
    delegate height, @size
    delegate width, @size
  end
end
