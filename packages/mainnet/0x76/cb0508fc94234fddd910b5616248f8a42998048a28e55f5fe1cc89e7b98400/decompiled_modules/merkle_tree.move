module 0x76cb0508fc94234fddd910b5616248f8a42998048a28e55f5fe1cc89e7b98400::merkle_tree {
    public(friend) fun digest_length() : u64 {
        32
    }

    public(friend) fun node(arg0: vector<u8>, arg1: vector<u8>) : vector<u8> {
        let v0 = x"01";
        0x1::vector::append<u8>(&mut v0, arg0);
        0x1::vector::append<u8>(&mut v0, arg1);
        0x2::hash::blake2b256(&v0)
    }

    fun proof_depth(arg0: u64) : u64 {
        let v0 = 0;
        while (arg0 > 1) {
            arg0 = 0x1::u64::div_ceil(arg0, 2);
            v0 = v0 + 1;
        };
        v0
    }

    public(friend) fun verify(arg0: vector<u8>, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: &vector<vector<u8>>) : bool {
        let v0 = if (0x1::vector::length<u8>(&arg0) != 32) {
            true
        } else if (0x1::vector::length<u8>(&arg1) != 32) {
            true
        } else if (arg3 == 0) {
            true
        } else {
            arg2 >= arg3
        };
        if (v0) {
            return false
        };
        let v1 = if (0x1::vector::length<vector<u8>>(arg4) != proof_depth(arg3)) {
            true
        } else {
            let v2 = 0;
            let v1;
            while (v2 < 0x1::vector::length<vector<u8>>(arg4)) {
                if (!(0x1::vector::length<u8>(0x1::vector::borrow<vector<u8>>(arg4, v2)) == 32)) {
                    v1 = !false;
                    /* goto 16 */
                } else {
                    /* goto 27 */
                };
            };
            v1
        };
        /* label 16 */
        if (v1) {
            return false
        };
        let v3 = 0;
        while (v3 < 0x1::vector::length<vector<u8>>(arg4)) {
            let v4 = if (arg2 % 2 == 0) {
                node(arg1, *0x1::vector::borrow<vector<u8>>(arg4, v3))
            } else {
                node(*0x1::vector::borrow<vector<u8>>(arg4, v3), arg1)
            };
            arg1 = v4;
            arg2 = arg2 / 2;
            v3 = v3 + 1;
        };
        arg1 == arg0
    }

    // decompiled from Move bytecode v7
}

