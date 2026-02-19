module 0xde72a9a75251a99a63f318569763f7c520283f6a876851b42abf15c688c7221::helper {
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

