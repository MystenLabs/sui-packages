module 0xcfdb2854aa5f2b2039a4c0f4c5265adcfd847f9cb1426d7127218793dac37908::utils {
    public fun byte_to_hex(arg0: u8) : 0x1::string::String {
        let v0 = b"0123456789abcdef";
        let v1 = 0x1::string::utf8(b"");
        0x1::string::append(&mut v1, 0x1::string::utf8(0x1::vector::singleton<u8>(*0x1::vector::borrow<u8>(&v0, ((arg0 >> 4 & 15) as u64)))));
        0x1::string::append(&mut v1, 0x1::string::utf8(0x1::vector::singleton<u8>(*0x1::vector::borrow<u8>(&v0, ((arg0 & 15) as u64)))));
        v1
    }

    public fun vector_to_hex_string(arg0: vector<u8>) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"");
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(&arg0)) {
            0x1::string::append(&mut v0, byte_to_hex(*0x1::vector::borrow<u8>(&arg0, v1)));
            v1 = v1 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v6
}

