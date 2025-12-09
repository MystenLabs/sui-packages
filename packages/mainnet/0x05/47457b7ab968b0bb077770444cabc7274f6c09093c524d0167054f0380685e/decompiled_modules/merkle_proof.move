module 0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::merkle_proof {
    fun hash_internal_node(arg0: vector<u8>, arg1: vector<u8>) : vector<u8> {
        let v0 = x"0000000000000000000000000000000000000000000000000000000000000001";
        0x1::vector::append<u8>(&mut v0, arg0);
        0x1::vector::append<u8>(&mut v0, arg1);
        0x2::hash::keccak256(&v0)
    }

    fun hash_pair(arg0: vector<u8>, arg1: vector<u8>) : vector<u8> {
        if (!vector_u8_gt(&arg0, &arg1)) {
            hash_internal_node(arg0, arg1)
        } else {
            hash_internal_node(arg1, arg0)
        }
    }

    public fun leaf_domain_separator() : vector<u8> {
        x"0000000000000000000000000000000000000000000000000000000000000000"
    }

    public fun merkle_root(arg0: vector<u8>, arg1: vector<vector<u8>>) : vector<u8> {
        let v0 = arg0;
        0x1::vector::reverse<vector<u8>>(&mut arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<vector<u8>>(&arg1)) {
            v0 = hash_pair(v0, 0x1::vector::pop_back<vector<u8>>(&mut arg1));
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<vector<u8>>(arg1);
        v0
    }

    public fun vector_u8_gt(arg0: &vector<u8>, arg1: &vector<u8>) : bool {
        let v0 = 0x1::vector::length<u8>(arg0);
        assert!(v0 == 0x1::vector::length<u8>(arg1), 1);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = *0x1::vector::borrow<u8>(arg0, v1);
            let v3 = *0x1::vector::borrow<u8>(arg1, v1);
            if (v2 > v3) {
                return true
            };
            if (v2 < v3) {
                return false
            };
            v1 = v1 + 1;
        };
        false
    }

    // decompiled from Move bytecode v6
}

