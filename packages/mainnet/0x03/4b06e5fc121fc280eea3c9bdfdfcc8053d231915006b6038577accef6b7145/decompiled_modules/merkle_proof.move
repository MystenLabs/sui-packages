module 0xfd770f276ba8a35b0f19ac4547d50eeba5a3be779d4b829e425f7b391645cd9f::merkle_proof {
    fun hash_concat(arg0: &vector<u8>, arg1: &vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v0, 2);
        0x1::vector::append<u8>(&mut v0, *arg0);
        0x1::vector::append<u8>(&mut v0, *arg1);
        0x2::hash::keccak256(&v0)
    }

    fun hash_leaf(arg0: &vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v0, 1);
        0x1::vector::append<u8>(&mut v0, *arg0);
        0x2::hash::keccak256(&v0)
    }

    fun hash_pair(arg0: &vector<u8>, arg1: &vector<u8>) : vector<u8> {
        if (is_less_than(arg0, arg1)) {
            hash_concat(arg0, arg1)
        } else {
            hash_concat(arg1, arg0)
        }
    }

    fun is_less_than(arg0: &vector<u8>, arg1: &vector<u8>) : bool {
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
            if (v4 < v5) {
                return true
            };
            if (v4 > v5) {
                return false
            };
            v3 = v3 + 1;
        };
        v0 < v1
    }

    public fun verify(arg0: &vector<vector<u8>>, arg1: &vector<u8>, arg2: &vector<u8>) : bool {
        let v0 = hash_leaf(arg2);
        let v1 = 0;
        while (v1 < 0x1::vector::length<vector<u8>>(arg0)) {
            let v2 = &v0;
            v0 = hash_pair(v2, 0x1::vector::borrow<vector<u8>>(arg0, v1));
            v1 = v1 + 1;
        };
        &v0 == arg1
    }

    // decompiled from Move bytecode v6
}

