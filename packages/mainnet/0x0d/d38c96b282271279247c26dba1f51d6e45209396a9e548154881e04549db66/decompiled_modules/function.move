module 0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::function {
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

