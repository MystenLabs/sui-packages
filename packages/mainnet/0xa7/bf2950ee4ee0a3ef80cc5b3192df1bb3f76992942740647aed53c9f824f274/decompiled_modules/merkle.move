module 0xa7bf2950ee4ee0a3ef80cc5b3192df1bb3f76992942740647aed53c9f824f274::merkle {
    fun bytes_less_or_equal(arg0: &vector<u8>, arg1: &vector<u8>) : bool {
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

    public fun claim_leaf(arg0: vector<u8>, arg1: u64, arg2: address, arg3: u64) : vector<u8> {
        assert!(0x1::vector::length<u8>(&arg0) == 32, 1);
        let v0 = b"YOSO_REFERRAL_LEAF_V1";
        0x1::vector::append<u8>(&mut v0, arg0);
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg1));
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg2));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg3));
        0x2::hash::blake2b256(&v0)
    }

    public fun parent_hash(arg0: vector<u8>, arg1: vector<u8>) : vector<u8> {
        assert!(0x1::vector::length<u8>(&arg0) == 32, 1);
        assert!(0x1::vector::length<u8>(&arg1) == 32, 1);
        let v0 = b"YOSO_REFERRAL_NODE_V1";
        if (bytes_less_or_equal(&arg0, &arg1)) {
            0x1::vector::append<u8>(&mut v0, arg0);
            0x1::vector::append<u8>(&mut v0, arg1);
        } else {
            0x1::vector::append<u8>(&mut v0, arg1);
            0x1::vector::append<u8>(&mut v0, arg0);
        };
        0x2::hash::blake2b256(&v0)
    }

    public fun proof_root(arg0: vector<u8>, arg1: vector<vector<u8>>) : vector<u8> {
        assert!(0x1::vector::length<u8>(&arg0) == 32, 1);
        assert!(0x1::vector::length<vector<u8>>(&arg1) <= 64, 2);
        let v0 = arg0;
        0x1::vector::reverse<vector<u8>>(&mut arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<vector<u8>>(&arg1)) {
            let v2 = 0x1::vector::pop_back<vector<u8>>(&mut arg1);
            assert!(0x1::vector::length<u8>(&v2) == 32, 1);
            v0 = parent_hash(v0, v2);
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<vector<u8>>(arg1);
        v0
    }

    // decompiled from Move bytecode v7
}

