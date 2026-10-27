module 0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::merkle {
    public fun allow_leaf(arg0: address, arg1: u64) : vector<u8> {
        let v0 = 0x2::bcs::to_bytes<address>(&arg0);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg1));
        leaf(v0)
    }

    fun before(arg0: &vector<u8>, arg1: &vector<u8>) : bool {
        let v0 = 0x1::vector::length<u8>(arg0);
        let v1 = 0x1::vector::length<u8>(arg1);
        let v2 = 0;
        while (v2 < v0 && v2 < v1) {
            let v3 = *0x1::vector::borrow<u8>(arg0, v2);
            let v4 = *0x1::vector::borrow<u8>(arg1, v2);
            if (v3 != v4) {
                return v3 < v4
            };
            v2 = v2 + 1;
        };
        v0 < v1
    }

    public fun join(arg0: &vector<u8>, arg1: &vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v0, 1);
        if (before(arg0, arg1)) {
            0x1::vector::append<u8>(&mut v0, *arg0);
            0x1::vector::append<u8>(&mut v0, *arg1);
        } else {
            0x1::vector::append<u8>(&mut v0, *arg1);
            0x1::vector::append<u8>(&mut v0, *arg0);
        };
        0x2::hash::blake2b256(&v0)
    }

    public fun leaf(arg0: vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v0, 0);
        0x1::vector::append<u8>(&mut v0, arg0);
        0x2::hash::blake2b256(&v0)
    }

    public fun token_leaf(arg0: u64, arg1: &vector<0x1::string::String>, arg2: &vector<0x1::string::String>) : vector<u8> {
        let v0 = 0x2::bcs::to_bytes<u64>(&arg0);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<vector<0x1::string::String>>(arg1));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<vector<0x1::string::String>>(arg2));
        leaf(v0)
    }

    public fun verify(arg0: &vector<u8>, arg1: vector<u8>, arg2: &vector<vector<u8>>) : bool {
        let v0 = arg1;
        let v1 = 0;
        while (v1 < 0x1::vector::length<vector<u8>>(arg2)) {
            let v2 = &v0;
            v0 = join(v2, 0x1::vector::borrow<vector<u8>>(arg2, v1));
            v1 = v1 + 1;
        };
        v0 == *arg0
    }

    // decompiled from Move bytecode v7
}

