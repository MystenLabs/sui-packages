module 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::helper {
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

