module 0x9f74af29bc56dba5aeba39e75daae64727b62c5bfc4f6141bb22ad5cf011b3a0::Hash {
    fun address_to_bytes(arg0: address) : vector<u8> {
        let v0 = 0x2::address::to_string(arg0);
        hex_to_bytes(0x1::string::sub_string(&v0, 2, 0x1::string::length(&v0)))
    }

    public fun hash_address(arg0: address) : vector<u8> {
        0x1::hash::sha3_256(address_to_bytes(arg0))
    }

    public fun hash_bytes(arg0: &vector<u8>) : vector<u8> {
        0x1::hash::sha3_256(*arg0)
    }

    public fun hash_stamp_and_sender(arg0: &vector<u8>, arg1: address) : vector<u8> {
        let v0 = *arg0;
        0x1::vector::append<u8>(&mut v0, address_to_bytes(arg1));
        0x1::hash::sha3_256(v0)
    }

    fun hex_char_to_nibble(arg0: u8) : u8 {
        if (arg0 >= 48 && arg0 <= 57) {
            arg0 - 48
        } else if (arg0 >= 97 && arg0 <= 102) {
            arg0 - 87
        } else {
            assert!(arg0 >= 65 && arg0 <= 70, 1);
            arg0 - 55
        }
    }

    fun hex_to_bytes(arg0: 0x1::string::String) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0x1::string::bytes(&arg0);
        let v2 = 0;
        while (v2 < 0x1::string::length(&arg0)) {
            0x1::vector::push_back<u8>(&mut v0, hex_char_to_nibble(*0x1::vector::borrow<u8>(v1, v2)) << 4 | hex_char_to_nibble(*0x1::vector::borrow<u8>(v1, v2 + 1)));
            v2 = v2 + 2;
        };
        v0
    }

    // decompiled from Move bytecode v6
}

