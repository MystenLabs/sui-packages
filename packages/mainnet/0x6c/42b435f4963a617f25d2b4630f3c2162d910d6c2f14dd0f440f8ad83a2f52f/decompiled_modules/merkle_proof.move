module 0x6c42b435f4963a617f25d2b4630f3c2162d910d6c2f14dd0f440f8ad83a2f52f::merkle_proof {
    fun efficient_hash(arg0: vector<u8>, arg1: vector<u8>) : vector<u8> {
        0x1::vector::append<u8>(&mut arg0, arg1);
        0x1::hash::sha3_256(arg0)
    }

    fun hash_pair(arg0: vector<u8>, arg1: vector<u8>) : vector<u8> {
        if (0x6c42b435f4963a617f25d2b4630f3c2162d910d6c2f14dd0f440f8ad83a2f52f::vectors::lt(arg0, arg1)) {
            efficient_hash(arg0, arg1)
        } else {
            efficient_hash(arg1, arg0)
        }
    }

    fun process_proof(arg0: &vector<vector<u8>>, arg1: vector<u8>) : vector<u8> {
        let v0 = arg1;
        let v1 = 0;
        while (v1 < 0x1::vector::length<vector<u8>>(arg0)) {
            v0 = hash_pair(v0, *0x1::vector::borrow<vector<u8>>(arg0, v1));
            v1 = v1 + 1;
        };
        v0
    }

    public fun verify(arg0: &vector<vector<u8>>, arg1: vector<u8>, arg2: vector<u8>) : bool {
        process_proof(arg0, arg2) == arg1
    }

    public fun verify_with_index(arg0: &vector<vector<u8>>, arg1: vector<u8>, arg2: vector<u8>) : (bool, u256) {
        let v0 = arg2;
        let v1 = 0;
        let v2 = 0;
        while (v1 < 0x1::vector::length<vector<u8>>(arg0)) {
            let v3 = v2 * 2;
            v2 = v3;
            let v4 = *0x1::vector::borrow<vector<u8>>(arg0, v1);
            let v5 = if (0x6c42b435f4963a617f25d2b4630f3c2162d910d6c2f14dd0f440f8ad83a2f52f::vectors::lt(v0, v4)) {
                efficient_hash(v0, v4)
            } else {
                v2 = v3 + 1;
                efficient_hash(v4, v0)
            };
            v0 = v5;
            v1 = v1 + 1;
        };
        (v0 == arg1, v2)
    }

    // decompiled from Move bytecode v6
}

