module 0x1db3a54b99c2741bf8b8aaa8266d6e7b6daf0c702a5ef5b0d6e9e6cf12527a90::evm {
    fun is_hex_vec(arg0: vector<u8>) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u8>(&arg0)) {
            let v1 = *0x1::vector::borrow<u8>(&arg0, v0);
            let v2 = if (v1 >= 48 && v1 <= 57) {
                true
            } else if (v1 >= 97 && v1 <= 102) {
                true
            } else {
                v1 >= 65 && v1 <= 70
            };
            if (!v2) {
                return false
            };
            v0 = v0 + 1;
        };
        true
    }

    public fun is_valid_evm_address(arg0: 0x1::ascii::String) : bool {
        if (0x1::ascii::length(&arg0) != 42) {
            return false
        };
        let v0 = 0x1::ascii::into_bytes(arg0);
        if (*0x1::vector::borrow<u8>(&v0, 0) != 48 || *0x1::vector::borrow<u8>(&v0, 1) != 120) {
            return false
        };
        0x1::vector::remove<u8>(&mut v0, 0);
        0x1::vector::remove<u8>(&mut v0, 0);
        is_hex_vec(v0)
    }

    // decompiled from Move bytecode v6
}

