module 0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::merkle {
    public fun hash_leaf(arg0: &vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v0, 0);
        0x1::vector::append<u8>(&mut v0, *arg0);
        0x2::hash::keccak256(&v0)
    }

    fun hash_node(arg0: &vector<u8>, arg1: &vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v0, 1);
        if (lt(arg0, arg1)) {
            0x1::vector::append<u8>(&mut v0, *arg0);
            0x1::vector::append<u8>(&mut v0, *arg1);
        } else {
            0x1::vector::append<u8>(&mut v0, *arg1);
            0x1::vector::append<u8>(&mut v0, *arg0);
        };
        0x2::hash::keccak256(&v0)
    }

    fun lt(arg0: &vector<u8>, arg1: &vector<u8>) : bool {
        let v0 = 0x1::vector::length<u8>(arg0);
        let v1 = 0x1::vector::length<u8>(arg1);
        let v2 = if (v0 < v1) {
            v0
        } else {
            v1
        };
        let v3 = 0;
        while (v3 < v2) {
            let v4 = *0x1::vector::borrow<u8>(arg0, v3);
            let v5 = *0x1::vector::borrow<u8>(arg1, v3);
            if (v4 != v5) {
                return v4 < v5
            };
            v3 = v3 + 1;
        };
        v0 < v1
    }

    public fun verify_proof(arg0: &vector<u8>, arg1: &vector<u8>, arg2: &vector<u8>) : bool {
        let v0 = 0x1::vector::length<u8>(arg1);
        if (v0 % 32 != 0) {
            return false
        };
        let v1 = hash_leaf(arg0);
        let v2 = 0;
        while (v2 < v0) {
            let v3 = b"";
            let v4 = 0;
            while (v4 < 32) {
                0x1::vector::push_back<u8>(&mut v3, *0x1::vector::borrow<u8>(arg1, v2 + v4));
                v4 = v4 + 1;
            };
            let v5 = &v1;
            v1 = hash_node(v5, &v3);
            v2 = v2 + 32;
        };
        &v1 == arg2
    }

    // decompiled from Move bytecode v7
}

