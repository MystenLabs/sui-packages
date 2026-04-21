module 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::merkle_proof {
    fun hash_pair(arg0: vector<u8>, arg1: vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, arg0);
        0x1::vector::append<u8>(&mut v0, arg1);
        0x2::hash::keccak256(&v0)
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

    public fun verify(arg0: &vector<vector<u8>>, arg1: &vector<u8>, arg2: vector<u8>) : bool {
        let v0 = arg2;
        let v1 = 0;
        while (v1 < 0x1::vector::length<vector<u8>>(arg0)) {
            let v2 = *0x1::vector::borrow<vector<u8>>(arg0, v1);
            if (is_less_than(&v0, &v2)) {
                let v3 = v0;
                v0 = hash_pair(v3, v2);
            } else {
                let v4 = v0;
                v0 = hash_pair(v2, v4);
            };
            v1 = v1 + 1;
        };
        v0 == *arg1
    }

    // decompiled from Move bytecode v6
}

