module 0x4472b4c4eb66235577d54ba829a3ca8c42ae7f282a3b5ce20a261a60a5c2064b::utils {
    fun hash_pair(arg0: vector<u8>, arg1: vector<u8>) : vector<u8> {
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

    fun process_proof_calldata(arg0: vector<vector<u8>>, arg1: vector<u8>) : vector<u8> {
        let v0 = 0;
        let v1 = arg1;
        while (v0 < 0x1::vector::length<vector<u8>>(&arg0)) {
            v1 = hash_pair(v1, *0x1::vector::borrow<vector<u8>>(&arg0, v0));
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
        process_proof_calldata(arg0, arg2) == arg1
    }

    // decompiled from Move bytecode v6
}

