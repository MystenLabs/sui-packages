module 0xd6a9a7efc7ea0a16305381f1fe588167fc9dc232a966f815627ca3537412ab5e::my_module_one {
    public fun hello_world() : 0x1::string::String {
        0x1::string::utf8(b"Hello, World!")
    }

    // decompiled from Move bytecode v6
}

