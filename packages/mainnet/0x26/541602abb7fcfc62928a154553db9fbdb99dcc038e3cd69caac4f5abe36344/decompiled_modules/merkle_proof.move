module 0x26541602abb7fcfc62928a154553db9fbdb99dcc038e3cd69caac4f5abe36344::merkle_proof {
    fun efficient_hash(arg0: vector<u8>, arg1: vector<u8>) : vector<u8> {
        0x1::vector::append<u8>(&mut arg0, arg1);
        0x1::hash::sha2_256(arg0)
    }

    fun hash_pair(arg0: vector<u8>, arg1: vector<u8>) : vector<u8> {
        if (0x26541602abb7fcfc62928a154553db9fbdb99dcc038e3cd69caac4f5abe36344::vectors::lt(&arg0, &arg1)) {
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

    fun u64_to_ascii(arg0: u64) : vector<u8> {
        if (arg0 == 0) {
            return b"0"
        };
        let v0 = 0x1::vector::empty<u8>();
        while (arg0 > 0) {
            let v1 = arg0 % 10;
            arg0 = arg0 / 10;
            0x1::vector::push_back<u8>(&mut v0, (v1 as u8) + 48);
        };
        0x1::vector::reverse<u8>(&mut v0);
        v0
    }

    public fun verify(arg0: &vector<vector<u8>>, arg1: vector<u8>, arg2: vector<u8>) : bool {
        process_proof(arg0, arg2) == arg1
    }

    // decompiled from Move bytecode v6
}

