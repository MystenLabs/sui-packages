module 0x9a1525c42321041861bf5abba19d2a91f6f0e8ccbff30e5dd24ff83aac926b98::utils {
    public fun u64_to_string(arg0: u64) : 0x1::string::String {
        if (arg0 == 0) {
            return 0x1::string::from_ascii(0x1::ascii::string(b"0"))
        };
        let v0 = 0x1::vector::empty<u8>();
        while (arg0 != 0) {
            0x1::vector::push_back<u8>(&mut v0, ((48 + arg0 % 10) as u8));
            arg0 = arg0 / 10;
        };
        0x1::vector::reverse<u8>(&mut v0);
        0x1::string::from_ascii(0x1::ascii::string(v0))
    }

    // decompiled from Move bytecode v6
}

