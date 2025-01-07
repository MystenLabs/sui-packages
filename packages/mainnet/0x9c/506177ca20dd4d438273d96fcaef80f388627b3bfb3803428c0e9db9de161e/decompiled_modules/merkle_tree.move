module 0x9c506177ca20dd4d438273d96fcaef80f388627b3bfb3803428c0e9db9de161e::merkle_tree {
    fun hashPair(arg0: vector<u8>, arg1: vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        if (vector_is_smaller_than(arg0, arg1)) {
            0x1::vector::append<u8>(&mut v0, arg0);
            0x1::vector::append<u8>(&mut v0, arg1);
        } else {
            0x1::vector::append<u8>(&mut v0, arg1);
            0x1::vector::append<u8>(&mut v0, arg0);
        };
        0x2::hash::keccak256(&v0)
    }

    fun processProofCalldata(arg0: vector<vector<u8>>, arg1: vector<u8>) : vector<u8> {
        let v0 = 0;
        let v1 = arg1;
        while (v0 < 0x1::vector::length<vector<u8>>(&arg0)) {
            v1 = hashPair(v1, *0x1::vector::borrow<vector<u8>>(&arg0, v0));
            v0 = v0 + 1;
        };
        v1
    }

    fun vector_is_smaller_than(arg0: vector<u8>, arg1: vector<u8>) : bool {
        let v0 = 0x1::vector::length<u8>(&arg0);
        let v1 = 0x1::vector::length<u8>(&arg1);
        let v2 = 0;
        while (v2 < v0 && v2 < v1) {
            let v3 = *0x1::vector::borrow<u8>(&arg0, v2);
            let v4 = *0x1::vector::borrow<u8>(&arg1, v2);
            if (v3 < v4) {
                return true
            };
            if (v3 > v4) {
                return false
            };
            v2 = v2 + 1;
        };
        v0 < v1
    }

    public(friend) fun verify_calldata(arg0: vector<vector<u8>>, arg1: vector<u8>, arg2: vector<u8>) : bool {
        processProofCalldata(arg0, arg2) == arg1
    }

    // decompiled from Move bytecode v6
}

