module 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::log_exp {
    public fun exp2(arg0: u128) : u128 {
        let v0 = ((arg0 >> 64) as u8);
        assert!(v0 < 63 || v0 == 63 && arg0 & 18446744073709551616 - 1 == 0, 1);
        let v1 = (18446744073709551616 as u256);
        let v2 = (0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::sqrt::sqrt_u256(680564733841876926926749214863536422912) as u128);
        let v3 = 0;
        while (v3 < 63) {
            if (arg0 & 18446744073709551616 - 1 & 18446744073709551616 >> v3 + 1 != 0) {
                let v4 = v1 * (v2 as u256);
                v1 = v4 >> 64;
            };
            let v5 = 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::sqrt::sqrt_u256((v2 as u256) << 64);
            v2 = (v5 as u128);
            v3 = v3 + 1;
        };
        (v1 as u128) << v0
    }

    public fun ln_u64(arg0: u64) : u128 {
        (((log2_u64(arg0) as u256) * (12786308645202655660 as u256) >> 64) as u128)
    }

    public fun log2_u128(arg0: u128) : u256 {
        assert!(arg0 != 0, 0);
        let v0 = 0;
        let v1 = v0;
        let v2 = arg0;
        if (arg0 >= 18446744073709551616) {
            v2 = arg0 >> 64;
            v1 = v0 + 64;
        };
        if (v2 >= 4294967296) {
            v2 = v2 >> 32;
            v1 = v1 + 32;
        };
        if (v2 >= 65536) {
            v2 = v2 >> 16;
            v1 = v1 + 16;
        };
        if (v2 >= 256) {
            v2 = v2 >> 8;
            v1 = v1 + 8;
        };
        if (v2 >= 16) {
            v2 = v2 >> 4;
            v1 = v1 + 4;
        };
        if (v2 >= 4) {
            v2 = v2 >> 2;
            v1 = v1 + 2;
        };
        if (v2 >= 2) {
            v1 = v1 + 1;
        };
        let v3 = (v1 as u256) << 64;
        let v4 = if (v1 <= 63) {
            (arg0 as u256) << 63 - v1
        } else {
            (arg0 as u256) >> v1 - 63
        };
        let v5 = v4;
        let v6 = (18446744073709551616 as u256) >> 1;
        let v7 = 0;
        while (v7 < 63) {
            v5 = v5 * v5 >> 63;
            if (v5 >= 18446744073709551616) {
                v3 = v3 | v6;
                v5 = v5 >> 1;
            };
            v6 = v6 >> 1;
            v7 = v7 + 1;
        };
        v3
    }

    public fun log2_u64(arg0: u64) : u128 {
        assert!(arg0 != 0, 0);
        let v0 = 0;
        let v1 = v0;
        let v2 = arg0;
        if (arg0 >= 4294967296) {
            v2 = arg0 >> 32;
            v1 = v0 + 32;
        };
        if (v2 >= 65536) {
            v2 = v2 >> 16;
            v1 = v1 + 16;
        };
        if (v2 >= 256) {
            v2 = v2 >> 8;
            v1 = v1 + 8;
        };
        if (v2 >= 16) {
            v2 = v2 >> 4;
            v1 = v1 + 4;
        };
        if (v2 >= 4) {
            v2 = v2 >> 2;
            v1 = v1 + 2;
        };
        if (v2 >= 2) {
            v1 = v1 + 1;
        };
        let v3 = (v1 as u128) << 64;
        let v4 = (arg0 as u128) << 63 - v1;
        let v5 = 18446744073709551616 >> 1;
        let v6 = 0;
        while (v6 < 63) {
            v4 = v4 * v4 >> 63;
            if (v4 >= 18446744073709551616) {
                v3 = v3 | v5;
                v4 = v4 >> 1;
            };
            v5 = v5 >> 1;
            v6 = v6 + 1;
        };
        v3
    }

    // decompiled from Move bytecode v7
}

