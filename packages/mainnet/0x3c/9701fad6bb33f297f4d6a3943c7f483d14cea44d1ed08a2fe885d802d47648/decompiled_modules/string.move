module 0x3c9701fad6bb33f297f4d6a3943c7f483d14cea44d1ed08a2fe885d802d47648::string {
    public fun u256_to_string(arg0: u256) : 0x1::string::String {
        if (arg0 == 0) {
            return 0x1::string::utf8(b"0")
        };
        let v0 = 0x1::string::utf8(b"");
        while (arg0 > 0) {
            0x1::string::insert(&mut v0, 0, 0x1::string::utf8(0x1::vector::singleton<u8>(((48 + arg0 % 10) as u8))));
            arg0 = arg0 / 10;
        };
        v0
    }

    public fun u64_to_string(arg0: u64) : 0x1::string::String {
        u256_to_string((arg0 as u256))
    }

    public fun u8_to_string(arg0: u8) : 0x1::string::String {
        u256_to_string((arg0 as u256))
    }

    // decompiled from Move bytecode v6
}

