module 0x5a30c103cb5a32071ca208ec9ce13fa580da8093ddc3f1a15618c4bda72cc063::string {
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

