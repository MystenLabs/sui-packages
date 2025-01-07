module 0xdf0f8bfff28f1da485caff7e258a66b918993bd6031e234da9bb399924ff1916::math {
    public fun average(arg0: u64, arg1: u64) : u64 {
        (arg0 & arg1) + (arg0 ^ arg1) / 2
    }

    public fun ceil_div(arg0: u64, arg1: u64) : u64 {
        if (arg0 == 0) {
            0
        } else {
            (arg0 - 1) / arg1 + 1
        }
    }

    public fun d_fdiv(arg0: u64, arg1: u64) : u256 {
        assert!(arg1 != 0, 0);
        (arg0 as u256) * 1000000000000000000 / (arg1 as u256)
    }

    public fun d_fdiv_u256(arg0: u256, arg1: u256) : u256 {
        assert!(arg1 != 0, 0);
        arg0 * 1000000000000000000 / arg1
    }

    public fun d_fmul(arg0: u64, arg1: u64) : u256 {
        (arg0 as u256) * (arg1 as u256) / 1000000000000000000
    }

    public fun d_fmul_u256(arg0: u256, arg1: u256) : u256 {
        arg0 * arg1 / 1000000000000000000
    }

    public fun double_scalar() : u256 {
        1000000000000000000
    }

    public fun exp(arg0: u64, arg1: u64) : u64 {
        let v0 = 1;
        while (arg1 > 0) {
            if (arg1 & 1 > 0) {
                v0 = v0 * arg0;
            };
            arg1 = arg1 >> 1;
            arg0 = arg0 * arg0;
        };
        v0
    }

    public fun fdiv_u256(arg0: u256, arg1: u256) : u256 {
        assert!(arg1 != 0, 0);
        arg0 * 1000000000 / arg1
    }

    public fun fmul_u256(arg0: u256, arg1: u256) : u256 {
        arg0 * arg1 / 1000000000
    }

    public fun get_rounding_down() : u8 {
        0
    }

    public fun get_rounding_up() : u8 {
        0
    }

    public fun get_rounding_zero() : u8 {
        0
    }

    public fun max(arg0: u64, arg1: u64) : u64 {
        if (arg0 >= arg1) {
            arg0
        } else {
            arg1
        }
    }

    public fun min(arg0: u64, arg1: u64) : u64 {
        if (arg0 < arg1) {
            arg0
        } else {
            arg1
        }
    }

    public fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 != 0, 0);
        (((arg0 as u256) * (arg1 as u256) / (arg2 as u256)) as u64)
    }

    public fun mul_div_u128(arg0: u128, arg1: u128, arg2: u128) : u128 {
        assert!(arg2 != 0, 0);
        (((arg0 as u256) * (arg1 as u256) / (arg2 as u256)) as u128)
    }

    public fun quadratic(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        exp(arg0, 2) / 65536 * arg1 / 65536 + arg2 * arg0 / 65536 + arg3
    }

    public fun scalar() : u256 {
        1000000000
    }

    public fun sqrt(arg0: u64) : u64 {
        if (arg0 == 0) {
            return 0
        };
        let v0 = 1;
        let v1 = v0;
        let v2 = arg0;
        if (arg0 >> 32 > 0) {
            v2 = arg0 >> 32;
            v1 = v0 << 16;
        };
        if (v2 >> 16 > 0) {
            v2 = v2 >> 16;
            v1 = v1 << 8;
        };
        if (v2 >> 8 > 0) {
            v2 = v2 >> 8;
            v1 = v1 << 4;
        };
        if (v2 >> 4 > 0) {
            v2 = v2 >> 4;
            v1 = v1 << 2;
        };
        if (v2 >> 2 > 0) {
            v1 = v1 << 1;
        };
        let v3 = v1 + arg0 / v1 >> 1;
        let v4 = v3 + arg0 / v3 >> 1;
        let v5 = v4 + arg0 / v4 >> 1;
        let v6 = v5 + arg0 / v5 >> 1;
        let v7 = v6 + arg0 / v6 >> 1;
        let v8 = v7 + arg0 / v7 >> 1;
        let v9 = v8 + arg0 / v8 >> 1;
        min(v9, arg0 / v9)
    }

    public fun sqrt_rounding(arg0: u64, arg1: u8) : u64 {
        let v0 = sqrt(arg0);
        let v1 = v0;
        if (arg1 == 0 && v0 * v0 < arg0) {
            v1 = v0 + 1;
        };
        v1
    }

    public fun sqrt_u256(arg0: u256) : u256 {
        let v0 = 0;
        if (arg0 > 3) {
            v0 = arg0;
            let v1 = arg0 / 2 + 1;
            while (v1 < arg0) {
                v0 = v1;
                let v2 = arg0 / v1 + v1;
                v1 = v2 / 2;
            };
        } else if (arg0 != 0) {
            v0 = 1;
        };
        v0
    }

    // decompiled from Move bytecode v6
}

