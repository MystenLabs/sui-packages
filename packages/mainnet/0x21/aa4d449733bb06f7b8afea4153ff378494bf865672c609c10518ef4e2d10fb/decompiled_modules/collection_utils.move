module 0x21aa4d449733bb06f7b8afea4153ff378494bf865672c609c10518ef4e2d10fb::collection_utils {
    public fun compare_ascii_strings(arg0: &0x1::ascii::String, arg1: &0x1::ascii::String) : u8 {
        compare_vector(0x1::ascii::as_bytes(arg0), 0x1::ascii::as_bytes(arg1))
    }

    public fun compare_vector(arg0: &vector<u8>, arg1: &vector<u8>) : u8 {
        let v0 = 0;
        while (v0 < 0x2::math::min(0x1::vector::length<u8>(arg0), 0x1::vector::length<u8>(arg1))) {
            if (*0x1::vector::borrow<u8>(arg0, v0) > *0x1::vector::borrow<u8>(arg1, v0)) {
                return 2
            };
            if (*0x1::vector::borrow<u8>(arg0, v0) < *0x1::vector::borrow<u8>(arg1, v0)) {
                return 1
            };
            v0 = v0 + 1;
        };
        0
    }

    public fun concat_ascii_strings(arg0: 0x1::ascii::String, arg1: 0x1::ascii::String) : 0x1::ascii::String {
        let (v0, v1) = if (compare_ascii_strings(&arg0, &arg1) == 1) {
            (arg0, arg1)
        } else {
            (arg1, arg0)
        };
        let v2 = 0x1::ascii::into_bytes(v0);
        0x1::vector::append<u8>(&mut v2, 0x1::ascii::into_bytes(v1));
        0x1::ascii::string(v2)
    }

    public fun get_composite_key(arg0: 0x1::ascii::String, arg1: 0x1::ascii::String) : vector<u8> {
        0x1::hash::sha3_256(0x1::ascii::into_bytes(concat_ascii_strings(arg0, arg1)))
    }

    // decompiled from Move bytecode v6
}

