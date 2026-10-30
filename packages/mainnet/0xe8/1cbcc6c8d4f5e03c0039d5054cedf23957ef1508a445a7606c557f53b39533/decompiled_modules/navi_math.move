module 0xe81cbcc6c8d4f5e03c0039d5054cedf23957ef1508a445a7606c557f53b39533::navi_math {
    public fun min_u64(arg0: u64, arg1: u64) : u64 {
        if (arg0 < arg1) {
            arg0
        } else {
            arg1
        }
    }

    public fun pow10(arg0: u8) : u256 {
        if (arg0 == 0) {
            1
        } else if (arg0 == 1) {
            10
        } else if (arg0 == 2) {
            100
        } else if (arg0 == 3) {
            1000
        } else if (arg0 == 4) {
            10000
        } else if (arg0 == 5) {
            100000
        } else if (arg0 == 6) {
            1000000
        } else if (arg0 == 7) {
            10000000
        } else if (arg0 == 8) {
            100000000
        } else if (arg0 == 9) {
            1000000000
        } else if (arg0 == 10) {
            10000000000
        } else if (arg0 == 11) {
            100000000000
        } else if (arg0 == 12) {
            1000000000000
        } else if (arg0 == 13) {
            10000000000000
        } else if (arg0 == 14) {
            100000000000000
        } else if (arg0 == 15) {
            1000000000000000
        } else if (arg0 == 16) {
            10000000000000000
        } else if (arg0 == 17) {
            100000000000000000
        } else {
            assert!(arg0 == 18, 120);
            1000000000000000000
        }
    }

    public fun ray() : u256 {
        1000000000000000000000000000
    }

    public fun ray_div(arg0: u256, arg1: u256) : u256 {
        assert!(arg1 > 0, 120);
        (arg0 * 1000000000000000000000000000 + arg1 / 2) / arg1
    }

    public fun ray_mul(arg0: u256, arg1: u256) : u256 {
        if (arg0 == 0 || arg1 == 0) {
            return 0
        };
        (arg0 * arg1 + 500000000000000000000000000) / 1000000000000000000000000000
    }

    public fun scale_decimals(arg0: u256, arg1: u8, arg2: u8) : u256 {
        if (arg1 == arg2) {
            arg0
        } else if (arg1 < arg2) {
            arg0 * pow10(arg2 - arg1)
        } else {
            arg0 / pow10(arg1 - arg2)
        }
    }

    public fun u256_to_u64_sat(arg0: u256) : u64 {
        if (arg0 > 18446744073709551615) {
            18446744073709551615
        } else {
            (arg0 as u64)
        }
    }

    // decompiled from Move bytecode v7
}

