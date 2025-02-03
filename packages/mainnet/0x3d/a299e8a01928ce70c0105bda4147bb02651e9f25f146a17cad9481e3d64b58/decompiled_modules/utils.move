module 0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::utils {
    public fun decimal_to_hex_char(arg0: u8) : 0x1::string::String {
        let v0 = vector[b"0", b"1", b"2", b"3", b"4", b"5", b"6", b"7", b"8", b"9", b"a", b"b", b"c", b"d", b"e", b"f"];
        0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&v0, (arg0 as u64)))
    }

    public fun get_type<T0>() : 0x1::string::String {
        0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>()))
    }

    public fun power(arg0: u64, arg1: u64) : u64 {
        let v0 = 1;
        let v1 = 1;
        while (v1 <= arg1) {
            v0 = v0 * arg0;
            v1 = v1 + 1;
        };
        v0
    }

    public fun vector_to_hex_char(arg0: vector<u8>) : 0x1::string::String {
        let v0 = 0;
        let v1 = 0x1::string::utf8(b"0x");
        while (v0 < 0x1::vector::length<u8>(&arg0)) {
            let v2 = 0x1::vector::borrow<u8>(&arg0, v0);
            0x1::string::append(&mut v1, decimal_to_hex_char(*v2 / 16));
            0x1::string::append(&mut v1, decimal_to_hex_char(*v2 % 16));
            v0 = v0 + 1;
        };
        v1
    }

    // decompiled from Move bytecode v6
}

