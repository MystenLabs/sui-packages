module 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::common {
    public(friend) fun apply_log2_factor(arg0: u128, arg1: u128) : u128 {
        0x1::option::destroy_some<u128>(0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::u128::mul_div(arg0, arg1, 1000000000000000000000000000, 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::rounding::down()))
    }

    public(friend) fun div_away_u256(arg0: u256, arg1: u256) : u256 {
        let v0 = arg0 / arg1;
        if (v0 * arg1 == arg0) {
            v0
        } else {
            v0 + 1
        }
    }

    public(friend) fun raw_log2(arg0: u128) : (bool, u128) {
        assert!(arg0 > 0, 13835058909980655617);
        let v0 = 1000000000;
        let v1 = 1000000000000000000;
        let (v2, v3, v4) = if (arg0 >= v0) {
            let v5 = 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::u128::log2(arg0 / v0, 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::rounding::down());
            (false, v5, arg0 >> v5)
        } else {
            let v6 = 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::u128::msb(v0) - 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::u128::msb(arg0);
            let v7 = v6;
            let v8 = arg0 << v6;
            let v9 = v8;
            if (v8 < v0) {
                v7 = v6 + 1;
                v9 = v8 << 1;
            };
            (true, v7, v9)
        };
        let v10 = v4 * v0;
        let v11 = 0;
        let v12 = v1 / 2;
        while (v12 > 0) {
            v10 = v10 * v10 / v1;
            if (v10 >= 2 * v1) {
                v11 = v11 + v12;
                v10 = v10 >> 1;
            };
            v12 = v12 >> 1;
        };
        let v13 = if (v2) {
            (v3 as u128) * v1 - v11
        } else {
            (v3 as u128) * v1 + v11
        };
        (v2, v13)
    }

    // decompiled from Move bytecode v7
}

