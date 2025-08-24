module 0xca5ee81d9adb5bcd626566360a8daf37416ee7aac8f9d4a133b19b20f019d89b::hello_world {
    public fun hello_world() : 0x1::string::String {
        0x1::string::utf8(b"Hello, World!")
    }

    // decompiled from Move bytecode v6
}

