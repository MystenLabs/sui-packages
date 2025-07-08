module 0x2::address {
    public fun length() : u64 {
        32
    }

    public fun to_bytes(arg0: address) : vector<u8> {
        0x1::bcs::to_bytes<address>(&arg0)
    }

    public fun from_ascii_bytes(arg0: &vector<u8>) : address {
        assert!(0x1::vector::length<u8>(arg0) == 64, 0);
        let v0 = b"";
        let v1 = 0;
        while (v1 < 64) {
            0x1::vector::push_back<u8>(&mut v0, hex_char_value(*0x1::vector::borrow<u8>(arg0, v1)) << 4 | hex_char_value(*0x1::vector::borrow<u8>(arg0, v1 + 1)));
            v1 = v1 + 2;
        };
        from_bytes(v0)
    }

    native public fun from_bytes(arg0: vector<u8>) : address;
    native public fun from_u256(arg0: u256) : address;
    fun hex_char_value(arg0: u8) : u8 {
        if (arg0 >= 48 && arg0 <= 57) {
            arg0 - 48
        } else if (arg0 >= 65 && arg0 <= 70) {
            arg0 - 55
        } else {
            assert!(arg0 >= 97 && arg0 <= 102, 0);
            arg0 - 87
        }
    }

    public fun max() : u256 {
        115792089237316195423570985008687907853269984665640564039457584007913129639935
    }

    public fun to_ascii_string(arg0: address) : 0x1::ascii::String {
        0x1::ascii::string(0x2::hex::encode(to_bytes(arg0)))
    }

    public fun to_string(arg0: address) : 0x1::string::String {
        0x1::string::from_ascii(to_ascii_string(arg0))
    }

    native public fun to_u256(arg0: address) : u256;
    // decompiled from Move bytecode v6
}

