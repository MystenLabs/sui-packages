module 0x1a554b6daf1730c0d3bb8103e1c5253682dcd9a50c77cc35121346e7bb5dcdbb::numerical {
    public fun average(arg0: u64, arg1: u64) : u64 {
        (arg0 & arg1) + ((arg0 ^ arg1) >> 1)
    }

    public fun ceil_log_2(arg0: u64) : u8 {
        if (arg0 <= 1) {
            return 0
        };
        1 + floor_log_2(arg0 - 1)
    }

    public fun clp2(arg0: u64) : u64 {
        if (arg0 == 0) {
            return 1
        };
        let v0 = arg0 - 1;
        let v1 = v0 | v0 >> 1;
        let v2 = v1 | v1 >> 2;
        let v3 = v2 | v2 >> 4;
        let v4 = v3 | v3 >> 8;
        let v5 = v4 | v4 >> 16;
        let v6 = v5 | v5 >> 32;
        if (v6 == 18446744073709551615) {
            return 0
        };
        v6 + 1
    }

    public fun floor_log_2(arg0: u64) : u8 {
        let v0 = 0;
        let v1 = v0;
        let v2 = arg0 >> 32;
        if (v2 != 0) {
            v1 = v0 + 32;
            arg0 = v2;
        };
        let v3 = arg0 >> 16;
        if (v3 != 0) {
            v1 = v1 + 16;
            arg0 = v3;
        };
        let v4 = arg0 >> 8;
        if (v4 != 0) {
            v1 = v1 + 8;
            arg0 = v4;
        };
        let v5 = arg0 >> 4;
        if (v5 != 0) {
            v1 = v1 + 4;
            arg0 = v5;
        };
        let v6 = arg0 >> 2;
        if (v6 != 0) {
            v1 = v1 + 2;
            arg0 = v6;
        };
        if (arg0 >> 1 != 0) {
            return v1 + 1
        };
        v1
    }

    public fun flp2(arg0: u64) : u64 {
        let v0 = arg0 | arg0 >> 1;
        let v1 = v0 | v0 >> 2;
        let v2 = v1 | v1 >> 4;
        let v3 = v2 | v2 >> 8;
        let v4 = v3 | v3 >> 16;
        let v5 = v4 | v4 >> 32;
        v5 ^ v5 >> 1
    }

    public fun int_exp(arg0: u64, arg1: u64) : u64 {
        let v0 = 1;
        loop {
            if (arg1 & 1 != 0) {
                v0 = arg0 * v0;
            };
            arg1 = arg1 >> 1;
            if (arg1 == 0) {
                break
            };
            arg0 = arg0 * arg0;
        };
        v0
    }

    public fun int_exp_128(arg0: u128, arg1: u64) : u128 {
        let v0 = 1;
        loop {
            if (arg1 & 1 != 0) {
                v0 = arg0 * v0;
            };
            arg1 = arg1 >> 1;
            if (arg1 == 0) {
                break
            };
            arg0 = arg0 * arg0;
        };
        v0
    }

    public fun leading_zeros(arg0: u64) : u8 {
        let v0 = 64;
        let v1 = v0;
        let v2 = arg0 >> 32;
        if (v2 != 0) {
            v1 = v0 - 32;
            arg0 = v2;
        };
        let v3 = arg0 >> 16;
        if (v3 != 0) {
            v1 = v1 - 16;
            arg0 = v3;
        };
        let v4 = arg0 >> 8;
        if (v4 != 0) {
            v1 = v1 - 8;
            arg0 = v4;
        };
        let v5 = arg0 >> 4;
        if (v5 != 0) {
            v1 = v1 - 4;
            arg0 = v5;
        };
        let v6 = arg0 >> 2;
        if (v6 != 0) {
            v1 = v1 - 2;
            arg0 = v6;
        };
        if (arg0 >> 1 != 0) {
            return v1 - 2
        };
        v1 - (arg0 as u8)
    }

    public fun ratio_double(arg0: u64, arg1: u64) : u128 {
        ((arg0 as u128) << 64) / (arg1 as u128)
    }

    public fun ratio_double_128(arg0: u128, arg1: u128) : u256 {
        ((arg0 as u256) << 128) / (arg1 as u256)
    }

    public fun ratio_double_32(arg0: u32, arg1: u32) : u64 {
        ((arg0 as u64) << 32) / (arg1 as u64)
    }

    public fun sqrt(arg0: u64) : u64 {
        if (arg0 <= 1) {
            return arg0
        };
        sqrt_newton(arg0, sqrt_estimate(arg0))
    }

    public fun sqrt_256(arg0: u256) : u256 {
        if (arg0 <= 0) {
            return arg0
        };
        sqrt_newton_256(arg0, sqrt_estimate_256(arg0))
    }

    public fun sqrt_estimate(arg0: u64) : u64 {
        let v0 = 1;
        let v1 = v0;
        let v2 = arg0 - 1;
        let v3 = v2;
        if (v2 > 4294967295) {
            v3 = v2 >> 32;
            v1 = v0 + 16;
        };
        if (v3 > 65535) {
            v3 = v3 >> 16;
            v1 = v1 + 8;
        };
        if (v3 > 255) {
            v3 = v3 >> 8;
            v1 = v1 + 4;
        };
        if (v3 > 15) {
            v3 = v3 >> 4;
            v1 = v1 + 2;
        };
        if (v3 > 3) {
            v1 = v1 + 1;
        };
        1 << v1
    }

    public fun sqrt_estimate_256(arg0: u256) : u256 {
        let v0 = 1;
        let v1 = v0;
        let v2 = arg0 - 1;
        let v3 = v2;
        if (v2 > 340282366920938463463374607431768211455) {
            v3 = v2 >> 128;
            v1 = v0 + 64;
        };
        if (v3 > 18446744073709551615) {
            v3 = v3 >> 64;
            v1 = v1 + 32;
        };
        if (v3 > 4294967295) {
            v3 = v3 >> 32;
            v1 = v1 + 16;
        };
        if (v3 > 65535) {
            v3 = v3 >> 16;
            v1 = v1 + 8;
        };
        if (v3 > 255) {
            v3 = v3 >> 8;
            v1 = v1 + 4;
        };
        if (v3 > 15) {
            v3 = v3 >> 4;
            v1 = v1 + 2;
        };
        if (v3 > 3) {
            v1 = v1 + 1;
        };
        1 << v1
    }

    public fun sqrt_newton(arg0: u64, arg1: u64) : u64 {
        let v0 = arg1 + arg0 / arg1 >> 1;
        while (v0 < arg1) {
            arg1 = v0;
            let v1 = v0 + arg0 / v0;
            v0 = v1 >> 1;
        };
        arg1
    }

    public fun sqrt_newton_256(arg0: u256, arg1: u256) : u256 {
        let v0 = arg1 + arg0 / arg1 >> 1;
        while (v0 < arg1) {
            arg1 = v0;
            let v1 = v0 + arg0 / v0;
            v0 = v1 >> 1;
        };
        arg1
    }

    public fun word_len(arg0: u64) : u8 {
        64 - leading_zeros(arg0)
    }

    // decompiled from Move bytecode v6
}

