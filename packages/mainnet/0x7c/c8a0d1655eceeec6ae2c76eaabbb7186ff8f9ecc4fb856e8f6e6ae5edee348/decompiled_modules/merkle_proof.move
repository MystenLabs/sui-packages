module 0x7cc8a0d1655eceeec6ae2c76eaabbb7186ff8f9ecc4fb856e8f6e6ae5edee348::merkle_proof {
    fun efficient_hash(arg0: vector<u8>, arg1: vector<u8>) : vector<u8> {
        0x1::vector::append<u8>(&mut arg0, arg1);
        0x1::hash::sha3_256(arg0)
    }

    fun hash_pair(arg0: vector<u8>, arg1: vector<u8>) : vector<u8> {
        if (0x7cc8a0d1655eceeec6ae2c76eaabbb7186ff8f9ecc4fb856e8f6e6ae5edee348::vectors::lt(&arg0, &arg1)) {
            efficient_hash(arg0, arg1)
        } else {
            efficient_hash(arg1, arg0)
        }
    }

    public fun multi_proof_verify(arg0: &vector<vector<u8>>, arg1: &vector<bool>, arg2: vector<u8>, arg3: &vector<vector<u8>>) : bool {
        process_multi_proof(arg0, arg1, arg3) == arg2
    }

    fun process_multi_proof(arg0: &vector<vector<u8>>, arg1: &vector<bool>, arg2: &vector<vector<u8>>) : vector<u8> {
        let v0 = 0x1::vector::length<vector<u8>>(arg2);
        let v1 = 0x1::vector::length<bool>(arg1);
        assert!(v0 + 0x1::vector::length<vector<u8>>(arg0) - 1 == v1, 0);
        let v2 = 0x1::vector::empty<vector<u8>>();
        let v3 = 0;
        let v4 = 0;
        let v5 = 0;
        let v6 = 0;
        while (v6 < v1) {
            let v7 = if (v3 < v0) {
                let v8 = v3 + 1;
                v3 = v8;
                *0x1::vector::borrow<vector<u8>>(arg2, v8)
            } else {
                let v9 = v4 + 1;
                v4 = v9;
                *0x1::vector::borrow<vector<u8>>(&v2, v9)
            };
            let v10 = if (*0x1::vector::borrow<bool>(arg1, v6)) {
                if (v3 < v0) {
                    let v11 = v3 + 1;
                    v3 = v11;
                    *0x1::vector::borrow<vector<u8>>(arg2, v11)
                } else {
                    let v12 = v4 + 1;
                    v4 = v12;
                    *0x1::vector::borrow<vector<u8>>(&v2, v12)
                }
            } else {
                let v13 = v5 + 1;
                v5 = v13;
                *0x1::vector::borrow<vector<u8>>(arg0, v13)
            };
            0x1::vector::push_back<vector<u8>>(&mut v2, hash_pair(v7, v10));
            v6 = v6 + 1;
        };
        if (v1 > 0) {
            *0x1::vector::borrow<vector<u8>>(&v2, v1 - 1)
        } else if (v0 > 0) {
            *0x1::vector::borrow<vector<u8>>(arg2, 0)
        } else {
            *0x1::vector::borrow<vector<u8>>(arg0, 0)
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

    // decompiled from Move bytecode v6
}

