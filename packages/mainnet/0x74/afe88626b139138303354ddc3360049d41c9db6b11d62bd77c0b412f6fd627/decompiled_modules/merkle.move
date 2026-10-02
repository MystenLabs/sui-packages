module 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::merkle {
    public fun address_leaf(arg0: address) : vector<u8> {
        let v0 = x"02";
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg0));
        0x1::hash::sha2_256(v0)
    }

    fun less_or_equal(arg0: &vector<u8>, arg1: &vector<u8>) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u8>(arg0)) {
            if (*0x1::vector::borrow<u8>(arg0, v0) != *0x1::vector::borrow<u8>(arg1, v0)) {
                return *0x1::vector::borrow<u8>(arg0, v0) < *0x1::vector::borrow<u8>(arg1, v0)
            };
            v0 = v0 + 1;
        };
        true
    }

    public fun node(arg0: vector<u8>, arg1: vector<u8>) : vector<u8> {
        let v0 = x"01";
        if (less_or_equal(&arg0, &arg1)) {
            0x1::vector::append<u8>(&mut v0, arg0);
            0x1::vector::append<u8>(&mut v0, arg1);
        } else {
            0x1::vector::append<u8>(&mut v0, arg1);
            0x1::vector::append<u8>(&mut v0, arg0);
        };
        0x1::hash::sha2_256(v0)
    }

    public fun season_leaf(arg0: address, arg1: u64) : vector<u8> {
        let v0 = x"00";
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg0));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg1));
        0x1::hash::sha2_256(v0)
    }

    public fun verify(arg0: &vector<u8>, arg1: vector<u8>, arg2: &vector<vector<u8>>) : bool {
        let v0 = arg1;
        let v1 = 0;
        while (v1 < 0x1::vector::length<vector<u8>>(arg2)) {
            let v2 = v0;
            v0 = node(v2, *0x1::vector::borrow<vector<u8>>(arg2, v1));
            v1 = v1 + 1;
        };
        &v0 == arg0
    }

    // decompiled from Move bytecode v7
}

