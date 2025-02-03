module 0x4a25c9153d59dd70d1ec7b27aca3bac94606233154c6dd27fb78261d71ad6080::to_string {
    public fun to_string(arg0: u128) : 0x1::ascii::String {
        if (arg0 == 0) {
            return 0x1::ascii::string(b"0")
        };
        let v0 = 0x1::vector::empty<u8>();
        while (arg0 != 0) {
            0x1::vector::push_back<u8>(&mut v0, ((48 + arg0 % 10) as u8));
            arg0 = arg0 / 10;
        };
        0x1::vector::reverse<u8>(&mut v0);
        0x1::ascii::string(v0)
    }

    public fun bytes_to_hex_string(arg0: &vector<u8>) : 0x1::ascii::String {
        let v0 = b"0x";
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(arg0)) {
            let v2 = *0x1::vector::borrow<u8>(arg0, v1);
            let v3 = b"0123456789abcdef";
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(&mut v3, ((v2 >> 4 & 15) as u64)));
            let v4 = b"0123456789abcdef";
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(&mut v4, ((v2 & 15) as u64)));
            v1 = v1 + 1;
        };
        0x1::ascii::string(v0)
    }

    public fun to_hex_string(arg0: u128) : 0x1::ascii::String {
        if (arg0 == 0) {
            return 0x1::ascii::string(b"0x00")
        };
        let v0 = 0;
        while (arg0 != 0) {
            v0 = v0 + 1;
            arg0 = arg0 >> 8;
        };
        to_hex_string_fixed_length(arg0, v0)
    }

    public fun to_hex_string_fixed_length(arg0: u128, arg1: u128) : 0x1::ascii::String {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 < arg1 * 2) {
            let v2 = b"0123456789abcdef";
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(&mut v2, ((arg0 & 15) as u64)));
            arg0 = arg0 >> 4;
            v1 = v1 + 1;
        };
        assert!(arg0 == 0, 1);
        0x1::vector::append<u8>(&mut v0, b"x0");
        0x1::vector::reverse<u8>(&mut v0);
        0x1::ascii::string(v0)
    }

    // decompiled from Move bytecode v6
}

