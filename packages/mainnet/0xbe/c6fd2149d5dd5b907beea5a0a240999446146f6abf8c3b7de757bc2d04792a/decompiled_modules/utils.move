module 0xbec6fd2149d5dd5b907beea5a0a240999446146f6abf8c3b7de757bc2d04792a::utils {
    public(friend) fun assert_foreign_address_length(arg0: u64, arg1: &vector<u8>) {
        let v0 = if (arg0 == 1) {
            32
        } else {
            20
        };
        assert!(0x1::vector::length<u8>(arg1) == v0, 51);
    }

    // decompiled from Move bytecode v6
}

