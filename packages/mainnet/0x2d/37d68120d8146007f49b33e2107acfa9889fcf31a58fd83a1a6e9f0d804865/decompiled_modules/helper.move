module 0x2d37d68120d8146007f49b33e2107acfa9889fcf31a58fd83a1a6e9f0d804865::helper {
    public fun create_pair_key(arg0: 0x1::ascii::String, arg1: 0x1::ascii::String) : 0x1::ascii::String {
        assert!(0x1::ascii::length(&arg0) > 0, 5000);
        assert!(0x1::ascii::length(&arg1) > 0, 5000);
        assert!(arg0 != arg1, 5001);
        0x1::ascii::append(&mut arg0, 0x1::ascii::string(b"-"));
        0x1::ascii::append(&mut arg0, arg1);
        arg0
    }

    // decompiled from Move bytecode v6
}

