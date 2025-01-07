module 0x21aa4d449733bb06f7b8afea4153ff378494bf865672c609c10518ef4e2d10fb::merkle_tree {
    fun hash_pair(arg0: vector<u8>, arg1: vector<u8>) : vector<u8> {
        if (0x21aa4d449733bb06f7b8afea4153ff378494bf865672c609c10518ef4e2d10fb::collection_utils::compare_vector(&arg0, &arg1) == 1) {
            0x1::vector::append<u8>(&mut arg0, arg1);
            0x1::hash::sha3_256(arg0)
        } else {
            0x1::vector::append<u8>(&mut arg1, arg0);
            0x1::hash::sha3_256(arg1)
        }
    }

    public fun verify(arg0: &vector<u8>, arg1: vector<vector<u8>>, arg2: vector<u8>) {
        let v0 = arg2;
        let v1 = 0;
        while (v1 < 0x1::vector::length<vector<u8>>(&arg1)) {
            let v2 = v0;
            v0 = hash_pair(v2, *0x1::vector::borrow<vector<u8>>(&arg1, v1));
            v1 = v1 + 1;
        };
        assert!(0x21aa4d449733bb06f7b8afea4153ff378494bf865672c609c10518ef4e2d10fb::collection_utils::compare_vector(&v0, arg0) == 0, 0);
    }

    // decompiled from Move bytecode v6
}

