module 0xa9b94307de472ebe7c1a24ea862eb013d954c9c003a0484e045861d05b31435::utils {
    public fun str(arg0: u64) : 0x1::string::String {
        if (arg0 == 0) {
            return 0x1::string::utf8(b"0")
        };
        let v0 = 0x1::vector::empty<u8>();
        while (arg0 > 0) {
            let v1 = ((arg0 % 10) as u8);
            arg0 = arg0 / 10;
            0x1::vector::push_back<u8>(&mut v0, v1 + 48);
        };
        0x1::vector::reverse<u8>(&mut v0);
        0x1::string::utf8(v0)
    }

    // decompiled from Move bytecode v6
}

