module 0xa5e8cba532c46e056bbe9a21f7b488aa219d6c442f0b32266216da2b0a470358::merkle_proof {
    fun efficient_hash(arg0: vector<u8>, arg1: vector<u8>) : vector<u8> {
        0x1::vector::append<u8>(&mut arg0, arg1);
        0x2::hash::keccak256(&arg0)
    }

    fun hash_pair(arg0: vector<u8>, arg1: vector<u8>) : vector<u8> {
        if (0xa5e8cba532c46e056bbe9a21f7b488aa219d6c442f0b32266216da2b0a470358::vectors::lt(&arg0, &arg1)) {
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
        let v1 = 0x1::vector::length<vector<u8>>(arg0);
        let v2 = 0x1::vector::length<bool>(arg1);
        assert!(v0 + v1 - 1 == v2, 65536);
        let v3 = 0x1::vector::empty<vector<u8>>();
        let v4 = 0;
        let v5 = 0;
        let v6 = 0;
        let v7 = 0;
        while (v7 < v2) {
            let v8 = if (v4 < v0) {
                let v9 = v4 + 1;
                v4 = v9;
                *0x1::vector::borrow<vector<u8>>(arg2, v9)
            } else {
                let v10 = v5 + 1;
                v5 = v10;
                *0x1::vector::borrow<vector<u8>>(&v3, v10)
            };
            let v11 = if (*0x1::vector::borrow<bool>(arg1, v7)) {
                if (v4 < v0) {
                    let v12 = v4 + 1;
                    v4 = v12;
                    *0x1::vector::borrow<vector<u8>>(arg2, v12)
                } else {
                    let v13 = v5 + 1;
                    v5 = v13;
                    *0x1::vector::borrow<vector<u8>>(&v3, v13)
                }
            } else {
                let v14 = v6 + 1;
                v6 = v14;
                *0x1::vector::borrow<vector<u8>>(arg0, v14)
            };
            0x1::vector::push_back<vector<u8>>(&mut v3, hash_pair(v8, v11));
            v7 = v7 + 1;
        };
        if (v2 > 0) {
            assert!(v6 == v1, 65536);
            *0x1::vector::borrow<vector<u8>>(&v3, v2 - 1)
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

