module 0x55c5787f414c53450e2721c79eb9af4a4cc939b29ad789e628eb6829018f0dee::utils {
    public fun str(arg0: u64) : 0x1::string::String {
        if (arg0 == 0) {
            return 0x1::string::utf8(b"0")
        };
        let v0 = 0x1::vector::empty<u8>();
        while (arg0 > 0) {
            let v1 = arg0 % 10;
            arg0 = arg0 / 10;
            0x1::vector::push_back<u8>(&mut v0, (v1 as u8) + 48);
        };
        0x1::vector::reverse<u8>(&mut v0);
        0x1::string::utf8(v0)
    }

    // decompiled from Move bytecode v6
}

