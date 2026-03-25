module 0xc024179952471e2eb546be0cc6a6a2cdc1578502909ef0422e8b0a84a540b636::merkle {
    public fun verify_merkle_aggregation(arg0: u64, arg1: vector<u8>, arg2: vector<vector<u8>>, arg3: vector<u8>) : bool {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, x"00");
        0x1::vector::append<u8>(&mut v0, arg1);
        let v1 = 0x1::hash::sha2_256(v0);
        let v2 = 0;
        while (v2 < 0x1::vector::length<vector<u8>>(&arg2)) {
            let v3 = 0x1::vector::borrow<vector<u8>>(&arg2, v2);
            if (0x1::vector::length<u8>(v3) != 32) {
                return false
            };
            let v4 = 0x1::vector::empty<u8>();
            0x1::vector::append<u8>(&mut v4, x"01");
            let v5 = if (arg0 % 2 == 0) {
                0x1::vector::append<u8>(&mut v4, v1);
                0x1::vector::append<u8>(&mut v4, *v3);
                0x1::hash::sha2_256(v4)
            } else {
                0x1::vector::append<u8>(&mut v4, *v3);
                0x1::vector::append<u8>(&mut v4, v1);
                0x1::hash::sha2_256(v4)
            };
            v1 = v5;
            arg0 = arg0 / 2;
            v2 = v2 + 1;
        };
        v1 == arg3
    }

    // decompiled from Move bytecode v6
}

