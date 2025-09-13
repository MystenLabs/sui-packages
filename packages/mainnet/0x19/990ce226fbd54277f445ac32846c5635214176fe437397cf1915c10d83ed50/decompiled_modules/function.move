module 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::function {
    struct Function has copy, drop, store {
        package: address,
        module_name: 0x1::ascii::String,
        function_name: 0x1::ascii::String,
    }

    public fun create(arg0: address, arg1: 0x1::ascii::String, arg2: 0x1::ascii::String) : Function {
        Function{
            package       : arg0,
            module_name   : arg1,
            function_name : arg2,
        }
    }

    public fun function_name(arg0: &Function) : &0x1::ascii::String {
        &arg0.function_name
    }

    public fun module_name(arg0: &Function) : &0x1::ascii::String {
        &arg0.module_name
    }

    public fun package(arg0: &Function) : address {
        arg0.package
    }

    // decompiled from Move bytecode v6
}

