module 0x7e009c69fcaab269617359fc9ea2b3a308e71c82165af30f3b91ffc445800416::merkle {
    public(friend) fun leaf(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: address, arg4: u64, arg5: u64) : vector<u8> {
        let v0 = x"00626c6173742d686f6c6465722d726577617264732d7631";
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<0x2::object::ID>(&arg0));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg1));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg2));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<address>(&arg3));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg4));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg5));
        0x2::hash::blake2b256(&v0)
    }

    fun node(arg0: vector<u8>, arg1: vector<u8>) : vector<u8> {
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
        let v0 = if (0x1::vector::length<vector<u8>>(arg4) != proof_depth(arg3)) {
            true
        } else {
            let v1 = 0;
            let v0;
            while (v1 < 0x1::vector::length<vector<u8>>(arg4)) {
                if (!(0x1::vector::length<u8>(0x1::vector::borrow<vector<u8>>(arg4, v1)) == 32)) {
                    v0 = !false;
                    /* goto 7 */
                } else {
                    /* goto 18 */
                };
            };
            v0
        };
        /* label 7 */
        if (v0) {
            return false
        };
        let v2 = 0;
        while (v2 < 0x1::vector::length<vector<u8>>(arg4)) {
            let v3 = if (arg2 % 2 == 0) {
                node(arg1, *0x1::vector::borrow<vector<u8>>(arg4, v2))
            } else {
                node(*0x1::vector::borrow<vector<u8>>(arg4, v2), arg1)
            };
            arg1 = v3;
            arg2 = arg2 / 2;
            v2 = v2 + 1;
        };
        arg1 == arg0
    }

    // decompiled from Move bytecode v7
}

