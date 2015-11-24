
class Object
  # to_objc is called in order to get value required to be
  # passed to objc
  abstract def to_objc
end

struct Nil
  def to_objc
    self
  end
end

struct Float
  def to_objc
    to_cgfloat
  end

  def to_nsuinteger
    self.to_u64
  end

  def to_nsinteger
    self.to_i64.to_nsinteger
  end

  def to_cgfloat
    to_f64
  end
end

struct Int
  def to_objc
    self
  end

  def to_nsuinteger
    self.to_u64
  end

  def to_nsinteger
    self.to_i64
  end

  def to_cgfloat
    self.to_f64.to_cgfloat
  end

  def as(nsclass)
    raise "not implemented"
  end
end

alias NSEnum = UInt64
alias CGFloat = Float64

struct Bool
  def to_objc
    self ? 0xFF_u8 : 0x00_u8
  end
end

struct Pointer(T)
  def to_objc
    self
  end
end

class String
  def to_nsstring
    NSString.new self
  end

  def to_objc
    self
  end
end

struct Tuple
  def map_to_objc
    {% if @type.size == 0 %}
      self
    {% else %}
      {
        {% for i in 0 ... @type.size %}
          self[{{i}}].to_objc,
        {% end %}
      }
    {% end %}
  end
end

module Crocoa
  def self.send_msg(objc_target, selector_name, *args)
    objc_target.not_nil!
    LibObjC.objc_msgSend(objc_target, selector_name.to_sel.to_objc, *args.map_to_objc)
  end

  def self.send_msg_float32(objc_target, selector_name)
    objc_target.not_nil!
    f = ->(obj : UInt8*, sel : LibObjC::SEL){
      LibObjC.objc_msgSend(obj, sel)
    }
    f2 = Proc(UInt8*, LibObjC::SEL, Float32).new(f.pointer, Pointer(Void).null)
    f2.call(objc_target, selector_name.to_sel.to_objc)
  end

  def self.send_msg_fpret(objc_target, selector_name, *args)
    objc_target.not_nil!
    LibObjC.objc_msgSend_fpret(objc_target, selector_name.to_sel.to_objc, *args.map_to_objc)
  end
end
