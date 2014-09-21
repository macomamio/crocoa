require "../../src/crocoa"
include Crocoa

objc_class :MyAppDelegate do
end

# $x_MyAppDelegate_objc_class_initWithCoder_imp = ->(obj : UInt8*, _cmd : LibObjC::SEL, _coder : UInt8*) {
#   `touch /Users/bcardiff/Work/Manas/crystal/crocoa/samples/bundled_application/xx-init-coder.txt`
#   obj
# }
# LibObjC.class_addMethod2($x_MyAppDelegate_objc_class.obj, "initWithCoder:".to_sel.to_objc, $x_MyAppDelegate_objc_class_initWithCoder_imp, "@@:@")

# $x_MyAppDelegate_objc_class_init_imp = ->(obj : UInt8*, _cmd : LibObjC::SEL) {
#   `touch /Users/bcardiff/Work/Manas/crystal/crocoa/samples/bundled_application/xx-init.txt`
#   obj
# }
# LibObjC.class_addMethod3($x_MyAppDelegate_objc_class.obj, "init".to_sel.to_objc, $x_MyAppDelegate_objc_class_init_imp, "@@:")


# a = LibObjC.objc_msgSend($x_MyAppDelegate_objc_class.obj, "alloc".to_sel.to_objc)
# LibObjC.objc_msgSend(a, "init".to_sel.to_objc)
# `touch /Users/bcardiff/Work/Manas/crystal/crocoa/samples/bundled_application/xx-foo.txt`

LibObjC.class_addProtocol($x_MyAppDelegate_objc_class.obj,LibObjC.objc_getProtocol("NSApplicationDelegate"))

$AppDel_didFinishLaunching = -> (obj : UInt8*, _cmd : LibObjC::SEL, aNotification : UInt8*) {
  Crocoa.nslog "didFinishLaunching"
}

LibObjC.class_addMethod4($x_MyAppDelegate_objc_class.obj, "applicationDidFinishLaunching:".to_sel.to_objc, $AppDel_didFinishLaunching, "v@:@")


LibAppKit.ns_application_main 0u32, nil

# objc_class :Foo do
#   def mySelector()
#     $t2.value = $t1.value
#     puts "Hi there"
#   end

#   objc_export "mySelector:"
# end

