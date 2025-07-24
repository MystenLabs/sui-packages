module 0xbfaed21cb5cd1d294346d93cbd83f5b4f85c4b255885795d991b31b3298625af::practica_sui {
    public fun practica() {
        let v0 = 0x1::string::utf8(b"Hello, World!");
        0x1::debug::print<0x1::string::String>(&v0);
    }

    // decompiled from Move bytecode v6
}

