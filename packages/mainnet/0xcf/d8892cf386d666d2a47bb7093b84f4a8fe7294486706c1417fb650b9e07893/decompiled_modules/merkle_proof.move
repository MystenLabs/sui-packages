module 0xcfd8892cf386d666d2a47bb7093b84f4a8fe7294486706c1417fb650b9e07893::merkle_proof {
    fun efficient_hash(arg0: vector<u8>, arg1: vector<u8>) : vector<u8> {
        0x1::vector::append<u8>(&mut arg0, arg1);
        0x1::hash::sha3_256(arg0)
    }

    fun hash_pair(arg0: vector<u8>, arg1: vector<u8>) : vector<u8> {
        if (lt(arg0, arg1)) {
            efficient_hash(arg0, arg1)
        } else {
            efficient_hash(arg1, arg0)
        }
    }

    fun lt(arg0: vector<u8>, arg1: vector<u8>) : bool {
        let v0 = 0;
        let v1 = 0x1::vector::length<u8>(&arg0);
        assert!(v1 == 0x1::vector::length<u8>(&arg1), 0);
        while (v0 < v1) {
            if (*0x1::vector::borrow<u8>(&arg0, v0) < *0x1::vector::borrow<u8>(&arg1, v0)) {
                return true
            };
            if (*0x1::vector::borrow<u8>(&arg0, v0) > *0x1::vector::borrow<u8>(&arg1, v0)) {
                return false
            };
            v0 = v0 + 1;
        };
        false
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
            let v5 = if (lt(v0, v4)) {
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

