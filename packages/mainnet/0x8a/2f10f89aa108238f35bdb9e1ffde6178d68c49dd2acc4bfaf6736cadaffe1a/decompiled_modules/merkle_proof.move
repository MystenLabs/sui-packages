module 0x8a2f10f89aa108238f35bdb9e1ffde6178d68c49dd2acc4bfaf6736cadaffe1a::merkle_proof {
    public fun leaf(arg0: u8, arg1: vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v0, arg0);
        0x1::vector::append<u8>(&mut v0, arg1);
        0x1::hash::sha3_256(v0)
    }

    public fun verify(arg0: &vector<u8>, arg1: vector<u8>, arg2: u64, arg3: &vector<vector<u8>>) {
        let v0 = if (0x1::vector::length<u8>(arg0) == 32) {
            if (0x1::vector::length<vector<u8>>(arg3) <= 64) {
                0x1::vector::length<u8>(&arg1) == 32
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 13835058166951313409);
        let v1 = 0;
        while (v1 < 0x1::vector::length<vector<u8>>(arg3)) {
            let v2 = *0x1::vector::borrow<vector<u8>>(arg3, v1);
            assert!(0x1::vector::length<u8>(&v2) == 32, 13835058184131182593);
            let v3 = x"ff";
            if (arg2 % 2 == 0) {
                0x1::vector::append<u8>(&mut v3, arg1);
                0x1::vector::append<u8>(&mut v3, v2);
            } else {
                0x1::vector::append<u8>(&mut v3, v2);
                0x1::vector::append<u8>(&mut v3, arg1);
            };
            arg1 = 0x1::hash::sha3_256(v3);
            arg2 = arg2 / 2;
            v1 = v1 + 1;
        };
        assert!(arg2 == 0 && &arg1 == arg0, 13835339702057697283);
    }

    // decompiled from Move bytecode v7
}

