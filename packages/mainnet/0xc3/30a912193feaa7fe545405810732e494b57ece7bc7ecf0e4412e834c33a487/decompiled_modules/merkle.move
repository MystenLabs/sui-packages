module 0xc330a912193feaa7fe545405810732e494b57ece7bc7ecf0e4412e834c33a487::merkle {
    fun bytes_lte(arg0: &vector<u8>, arg1: &vector<u8>) : bool {
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
        v0 <= v1
    }

    public fun compute_leaf(arg0: address, arg1: u64) : vector<u8> {
        let v0 = 0x1::bcs::to_bytes<address>(&arg0);
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg1));
        0x2::hash::keccak256(&v0)
    }

    fun hash_pair(arg0: vector<u8>, arg1: vector<u8>) : vector<u8> {
        0x1::vector::append<u8>(&mut arg0, arg1);
        0x2::hash::keccak256(&arg0)
    }

    public fun verify_proof(arg0: &vector<vector<u8>>, arg1: &vector<u8>, arg2: vector<u8>) : bool {
        let v0 = 0x1::vector::length<vector<u8>>(arg0);
        assert!(v0 <= 20, 7);
        let v1 = arg2;
        let v2 = 0;
        while (v2 < v0) {
            let v3 = 0x1::vector::borrow<vector<u8>>(arg0, v2);
            let v4 = if (bytes_lte(&v1, v3)) {
                hash_pair(v1, *v3)
            } else {
                hash_pair(*v3, v1)
            };
            v1 = v4;
            v2 = v2 + 1;
        };
        &v1 == arg1
    }

    // decompiled from Move bytecode v7
}

