module 0x298f23cf5544ec7140b62a3e73d179bf6a6df1c1ddf54e2b318d4728dd044cb5::utils {
    public fun checked_mul(arg0: u256, arg1: u256) : u256 {
        assert!(is_safe_mul(arg0, arg1), 2);
        arg0 * arg1
    }

    public fun is_safe_mul(arg0: u256, arg1: u256) : bool {
        115792089237316195423570985008687907853269984665640564039457584007913129639935 / arg0 >= arg1
    }

    public fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    public fun mul_div_round_up(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = (arg0 as u128) * (arg1 as u128);
        let v1 = (arg2 as u128);
        if (v0 % v1 == 0) {
            ((v0 / v1) as u64)
        } else {
            ((v0 / v1 + 1) as u64)
        }
    }

    public fun timestamp_sec(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0) / 1000
    }

    public fun u256_mul_div(arg0: u256, arg1: u256, arg2: u256) : u256 {
        let (v0, v1) = if (arg0 >= arg1) {
            (arg0, arg1)
        } else {
            (arg1, arg0)
        };
        assert!(arg2 > 0, 1);
        if (!is_safe_mul(v0, v1)) {
            checked_mul(v0 / arg2, v1) + checked_mul(v0 % arg2, v1) / arg2
        } else {
            v0 * v1 / arg2
        }
    }

    public fun u256_mul_div_rounding(arg0: u256, arg1: u256, arg2: u256, arg3: bool) : u256 {
        if (arg3) {
            let v1 = if (arg0 * arg1 % arg2 > 0) {
                1
            } else {
                0
            };
            u256_mul_div(arg0, arg1, arg2) + v1
        } else {
            u256_mul_div(arg0, arg1, arg2)
        }
    }

    // decompiled from Move bytecode v6
}

