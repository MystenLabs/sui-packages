module 0x6827c30e3cde4f1cd4775a8fedb0c442a97d55b7adc5f82a202434c907efce1::merkle {
    public fun hash_pair(arg0: &vector<u8>, arg1: &vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v0, 1);
        if (le(arg0, arg1)) {
            0x1::vector::append<u8>(&mut v0, *arg0);
            0x1::vector::append<u8>(&mut v0, *arg1);
        } else {
            0x1::vector::append<u8>(&mut v0, *arg1);
            0x1::vector::append<u8>(&mut v0, *arg0);
        };
        0x2::hash::blake2b256(&v0)
    }

    fun le(arg0: &vector<u8>, arg1: &vector<u8>) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u8>(arg0)) {
            let v1 = *0x1::vector::borrow<u8>(arg0, v0);
            let v2 = *0x1::vector::borrow<u8>(arg1, v0);
            if (v1 < v2) {
                return true
            };
            if (v1 > v2) {
                return false
            };
            v0 = v0 + 1;
        };
        true
    }

    public fun leaf_bytes(arg0: u64, arg1: address, arg2: u64) : vector<u8> {
        let v0 = b"PLAYS_AIRDROP_LEAF_V1";
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg0));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(&arg1));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg2));
        v0
    }

    public fun leaf_domain() : vector<u8> {
        b"PLAYS_AIRDROP_LEAF_V1"
    }

    public fun leaf_hash(arg0: u64, arg1: address, arg2: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v0, 0);
        0x1::vector::append<u8>(&mut v0, leaf_bytes(arg0, arg1, arg2));
        0x2::hash::blake2b256(&v0)
    }

    public fun verify(arg0: &vector<u8>, arg1: vector<u8>, arg2: &vector<vector<u8>>) : bool {
        if (0x1::vector::length<u8>(arg0) != 32 || 0x1::vector::length<u8>(&arg1) != 32) {
            return false
        };
        let v0 = 0x1::vector::length<vector<u8>>(arg2);
        if (v0 > 64) {
            return false
        };
        let v1 = arg1;
        let v2 = 0;
        while (v2 < v0) {
            let v3 = 0x1::vector::borrow<vector<u8>>(arg2, v2);
            if (0x1::vector::length<u8>(v3) != 32) {
                return false
            };
            let v4 = &v1;
            v1 = hash_pair(v4, v3);
            v2 = v2 + 1;
        };
        &v1 == arg0
    }

    // decompiled from Move bytecode v7
}

