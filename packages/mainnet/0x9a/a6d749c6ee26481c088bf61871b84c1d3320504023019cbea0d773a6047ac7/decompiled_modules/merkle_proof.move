module 0x9aa6d749c6ee26481c088bf61871b84c1d3320504023019cbea0d773a6047ac7::merkle_proof {
    fun efficient_hash(arg0: vector<u8>, arg1: vector<u8>) : vector<u8> {
        0x1::vector::append<u8>(&mut arg0, arg1);
        0x1::hash::sha3_256(arg0)
    }

    fun hash_hair(arg0: vector<u8>, arg1: vector<u8>) : vector<u8> {
        if (lt(&arg0, &arg1)) {
            efficient_hash(arg0, arg1)
        } else {
            efficient_hash(arg1, arg0)
        }
    }

    public fun lt(arg0: &vector<u8>, arg1: &vector<u8>) : bool {
        let v0 = 0;
        let v1 = 0x1::vector::length<u8>(arg0);
        assert!(v1 == 0x1::vector::length<u8>(arg1), 0);
        while (v0 < v1) {
            let v2 = *0x1::vector::borrow<u8>(arg0, v0);
            let v3 = *0x1::vector::borrow<u8>(arg1, v0);
            if (v2 < v3) {
                return true
            };
            if (v2 > v3) {
                return false
            };
            v0 = v0 + 1;
        };
        false
    }

    fun process_proof(arg0: vector<vector<u8>>, arg1: vector<u8>) : vector<u8> {
        let v0 = arg1;
        let v1 = 0;
        while (v1 < 0x1::vector::length<vector<u8>>(&arg0)) {
            v0 = hash_hair(v0, *0x1::vector::borrow<vector<u8>>(&arg0, v1));
            v1 = v1 + 1;
        };
        v0
    }

    public fun verify(arg0: vector<vector<u8>>, arg1: vector<u8>, arg2: vector<u8>) : bool {
        process_proof(arg0, arg2) == arg1
    }

    // decompiled from Move bytecode v6
}

