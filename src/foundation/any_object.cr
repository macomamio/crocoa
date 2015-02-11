require "./nsobject_helper"

module Crocoa
  class AnyObject
    def initialize(pointer : UInt8*)
      @obj = pointer
      # retain
    end

    def to_objc
      @obj.not_nil!
    end

    def nsclass
      @nsclass ||= NSClass.new(LibObjC.object_getClass(to_objc))
      @nsclass.not_nil!
    end

    def as(nsclass)
      # TODO runtime type check
      nsclass.new(to_objc)
    end

    macro method_missing(name, args, block)
      method = nsclass.instance_method({{name}})
      objc_method_body {{name}}, nil, method.return_type
    end
  end
end
