module 0x597fdff42a2d64abb27d0c57d850cb8fc8b53b0307a99128317cc2e4cd841b60::util {
    public fun abs_diff(arg0: u64, arg1: u64) : u64 {
        if (arg0 > arg1) {
            arg0 - arg1
        } else {
            arg1 - arg0
        }
    }

    public fun divide_and_round_up_u128(arg0: u128, arg1: u128) : u128 {
        (arg0 + arg1 - 1) / arg1
    }

    public fun divide_and_round_up_u256(arg0: u256, arg1: u256) : u256 {
        (arg0 + arg1 - 1) / arg1
    }

    public fun log2_u256(arg0: u256) : u8 {
        let v0 = 0;
        let v1 = v0;
        if (arg0 >> 128 > 0) {
            arg0 = arg0 >> 128;
            v1 = v0 + 128;
        };
        if (arg0 >> 64 > 0) {
            arg0 = arg0 >> 64;
            v1 = v1 + 64;
        };
        if (arg0 >> 32 > 0) {
            arg0 = arg0 >> 32;
            v1 = v1 + 32;
        };
        if (arg0 >> 16 > 0) {
            arg0 = arg0 >> 16;
            v1 = v1 + 16;
        };
        if (arg0 >> 8 > 0) {
            arg0 = arg0 >> 8;
            v1 = v1 + 8;
        };
        if (arg0 >> 4 > 0) {
            arg0 = arg0 >> 4;
            v1 = v1 + 4;
        };
        if (arg0 >> 2 > 0) {
            arg0 = arg0 >> 2;
            v1 = v1 + 2;
        };
        if (arg0 >> 1 > 0) {
            v1 = v1 + 1;
        };
        v1
    }

    public fun max_u128(arg0: u128, arg1: u128) : u128 {
        if (arg0 > arg1) {
            arg0
        } else {
            arg1
        }
    }

    public fun max_u256(arg0: u256, arg1: u256) : u256 {
        if (arg0 > arg1) {
            arg0
        } else {
            arg1
        }
    }

    public fun min_u128(arg0: u128, arg1: u128) : u128 {
        if (arg0 < arg1) {
            arg0
        } else {
            arg1
        }
    }

    public fun min_u256(arg0: u256, arg1: u256) : u256 {
        if (arg0 < arg1) {
            arg0
        } else {
            arg1
        }
    }

    public fun muldiv(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    public fun muldiv_round_up(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (divide_and_round_up_u128((arg0 as u128) * (arg1 as u128), (arg2 as u128)) as u64)
    }

    public fun muldiv_round_up_u128(arg0: u128, arg1: u128, arg2: u128) : u128 {
        (divide_and_round_up_u256((arg0 as u256) * (arg1 as u256), (arg2 as u256)) as u128)
    }

    public fun muldiv_u128(arg0: u128, arg1: u128, arg2: u128) : u128 {
        (((arg0 as u256) * (arg1 as u256) / (arg2 as u256)) as u128)
    }

    public fun saturating_muldiv_round_up_u128(arg0: u128, arg1: u128, arg2: u128) : u128 {
        let v0 = divide_and_round_up_u256((arg0 as u256) * (arg1 as u256), (arg2 as u256));
        if (v0 > 340282366920938463463374607431768211455) {
            (((1 << 128) - 1) as u128)
        } else {
            (v0 as u128)
        }
    }

    public fun sqrt_u256(arg0: u256) : u256 {
        if (arg0 == 0) {
            return 0
        };
        let v0 = 1 << ((log2_u256(arg0) >> 1) as u8);
        let v1 = v0 + arg0 / v0 >> 1;
        let v2 = v1 + arg0 / v1 >> 1;
        let v3 = v2 + arg0 / v2 >> 1;
        let v4 = v3 + arg0 / v3 >> 1;
        let v5 = v4 + arg0 / v4 >> 1;
        let v6 = v5 + arg0 / v5 >> 1;
        let v7 = v6 + arg0 / v6 >> 1;
        min_u256(v7, arg0 / v7)
    }

    public fun timestamp_sec(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0) / 1000
    }

    // decompiled from Move bytecode v6
}

