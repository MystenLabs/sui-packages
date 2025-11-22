module 0x334d46ed6eb6f4fe21e290425f73fbecb018e41ecfdfde810f62b60329efc440::merkle_proof {
    public fun create_leaf(arg0: address, arg1: u64, arg2: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<address>(&arg0));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg1));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg2));
        0x1::hash::sha2_256(v0)
    }

    public fun hash_pair(arg0: &vector<u8>, arg1: &vector<u8>) : vector<u8> {
        let v0 = *arg0;
        0x1::vector::append<u8>(&mut v0, *arg1);
        0x1::hash::sha2_256(v0)
    }

    public fun verify(arg0: &vector<vector<u8>>, arg1: &vector<u8>, arg2: vector<u8>, arg3: u64) : bool {
        let v0 = arg2;
        let v1 = 0;
        while (v1 < 0x1::vector::length<vector<u8>>(arg0)) {
            let v2 = if (arg3 % 2 == 0) {
                hash_pair(&v0, 0x1::vector::borrow<vector<u8>>(arg0, v1))
            } else {
                hash_pair(0x1::vector::borrow<vector<u8>>(arg0, v1), &v0)
            };
            v0 = v2;
            arg3 = arg3 / 2;
            v1 = v1 + 1;
        };
        &v0 == arg1
    }

    // decompiled from Move bytecode v6
}

