module 0x87a0c2528de695acc0da24f60e5a71695b7249f998b8742d41ff8f0bc0081b66::hello_world {
    public fun hello_world() : 0x1::string::String {
        0x1::string::utf8(b"Hello, World!")
    }

    // decompiled from Move bytecode v6
}

