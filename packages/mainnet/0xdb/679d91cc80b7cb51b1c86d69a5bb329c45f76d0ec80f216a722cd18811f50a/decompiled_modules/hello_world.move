module 0xdb679d91cc80b7cb51b1c86d69a5bb329c45f76d0ec80f216a722cd18811f50a::hello_world {
    public fun hello_world() : 0x1::string::String {
        0x1::string::utf8(b"Hello, World!")
    }

    // decompiled from Move bytecode v6
}

