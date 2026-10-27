module 0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::merkle {
    fun before(arg0: &vector<u8>, arg1: &vector<u8>) : bool {
        let v0 = 0x1::vector::length<u8>(arg0);
        let v1 = 0x1::vector::length<u8>(arg1);
        let v2 = 0;
        while (v2 < v0 && v2 < v1) {
            let v3 = *0x1::vector::borrow<u8>(arg0, v2);
            let v4 = *0x1::vector::borrow<u8>(arg1, v2);
            if (v3 != v4) {
                return v3 < v4
            };
            v2 = v2 + 1;
        };
        v0 < v1
    }

    public fun contains(arg0: &vector<u8>, arg1: 0x2::object::ID, arg2: &vector<vector<u8>>) : bool {
        let v0 = leaf(arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<vector<u8>>(arg2)) {
            let v2 = &v0;
            v0 = join(v2, 0x1::vector::borrow<vector<u8>>(arg2, v1));
            v1 = v1 + 1;
        };
        v0 == *arg0
    }

    public fun join(arg0: &vector<u8>, arg1: &vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v0, 1);
        if (before(arg0, arg1)) {
            0x1::vector::append<u8>(&mut v0, *arg0);
            0x1::vector::append<u8>(&mut v0, *arg1);
        } else {
            0x1::vector::append<u8>(&mut v0, *arg1);
            0x1::vector::append<u8>(&mut v0, *arg0);
        };
        0x2::hash::blake2b256(&v0)
    }

    public fun leaf(arg0: 0x2::object::ID) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v0, 0);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&arg0));
        0x2::hash::blake2b256(&v0)
    }

    // decompiled from Move bytecode v7
}

