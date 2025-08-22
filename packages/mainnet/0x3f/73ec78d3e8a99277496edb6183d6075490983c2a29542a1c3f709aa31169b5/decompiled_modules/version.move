module 0x3f73ec78d3e8a99277496edb6183d6075490983c2a29542a1c3f709aa31169b5::version {
    public fun base() : 0x1::string::String {
        0x1::string::utf8(b"0.5.0")
    }

    public fun with_module(arg0: vector<u8>) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"0.5.0");
        0x1::string::append(&mut v0, 0x1::string::utf8(b" - "));
        0x1::string::append(&mut v0, 0x1::string::utf8(arg0));
        v0
    }

    // decompiled from Move bytecode v6
}

