module 0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::merkle {
    fun hash_pair(arg0: &vector<u8>, arg1: &vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v0, 1);
        if (less_than(arg0, arg1)) {
            0x1::vector::append<u8>(&mut v0, *arg0);
            0x1::vector::append<u8>(&mut v0, *arg1);
        } else {
            0x1::vector::append<u8>(&mut v0, *arg1);
            0x1::vector::append<u8>(&mut v0, *arg0);
        };
        0x1::hash::sha2_256(v0)
    }

    public fun leaf_hash(arg0: 0x2::object::ID, arg1: u64, arg2: address, arg3: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v0, 0);
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<0x2::object::ID>(&arg0));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg1));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<address>(&arg2));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg3));
        0x1::hash::sha2_256(v0)
    }

    fun less_than(arg0: &vector<u8>, arg1: &vector<u8>) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u8>(arg0)) {
            let v1 = *0x1::vector::borrow<u8>(arg0, v0);
            let v2 = *0x1::vector::borrow<u8>(arg1, v0);
            if (v1 != v2) {
                return v1 < v2
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun verify(arg0: &vector<u8>, arg1: vector<u8>, arg2: &vector<vector<u8>>) : bool {
        if (0x1::vector::length<vector<u8>>(arg2) > 32 || 0x1::vector::length<u8>(arg0) != 32) {
            return false
        };
        let v0 = arg1;
        let v1 = true;
        let v2 = 0;
        while (v2 < 0x1::vector::length<vector<u8>>(arg2)) {
            let v3 = 0x1::vector::borrow<vector<u8>>(arg2, v2);
            if (0x1::vector::length<u8>(v3) != 32) {
                v1 = false;
            } else {
                let v4 = &v0;
                v0 = hash_pair(v4, v3);
            };
            v2 = v2 + 1;
        };
        v1 && &v0 == arg0
    }

    // decompiled from Move bytecode v7
}

