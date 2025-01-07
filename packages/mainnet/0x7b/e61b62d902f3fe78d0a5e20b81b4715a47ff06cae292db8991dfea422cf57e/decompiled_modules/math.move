module 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::math {
    public fun max(arg0: u128, arg1: u128) : u128 {
        if (arg0 < arg1) {
            arg1
        } else {
            arg0
        }
    }

    public fun max_u64(arg0: u64, arg1: u64) : u64 {
        if (arg0 < arg1) {
            arg1
        } else {
            arg0
        }
    }

    public fun min(arg0: u128, arg1: u128) : u128 {
        if (arg0 > arg1) {
            arg1
        } else {
            arg0
        }
    }

    public fun min_u64(arg0: u64, arg1: u64) : u64 {
        if (arg0 < arg1) {
            arg0
        } else {
            arg1
        }
    }

    public fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 != 0, 2000);
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    public fun mul_div_u128(arg0: u128, arg1: u128, arg2: u128) : u64 {
        assert!(arg2 != 0, 2000);
        ((arg0 * arg1 / arg2) as u64)
    }

    public fun mul_div_up_u128(arg0: u128, arg1: u128, arg2: u128) : u64 {
        assert!(arg2 != 0, 2000);
        let v0 = (arg0 * arg1 - 1) / arg2 + 1;
        assert!(v0 <= 18446744073709551615, 2001);
        (v0 as u64)
    }

    public fun mul_to_u128(arg0: u64, arg1: u64) : u128 {
        (arg0 as u128) * (arg1 as u128)
    }

    public fun overflow_add(arg0: u128, arg1: u128) : u128 {
        let v0 = 340282366920938463463374607431768211455 - arg1;
        if (v0 < arg0) {
            return arg0 - v0 - 1
        };
        let v1 = 340282366920938463463374607431768211455 - arg0;
        if (v1 < arg1) {
            return arg1 - v1 - 1
        };
        arg0 + arg1
    }

    public fun pow(arg0: u128, arg1: u8) : u128 {
        let v0 = 1;
        loop {
            if (arg1 & 1 == 1) {
                v0 = v0 * arg0;
            };
            arg1 = arg1 >> 1;
            arg0 = arg0 * arg0;
            if (arg1 == 0) {
                break
            };
        };
        v0
    }

    public fun pow_10(arg0: u8) : u64 {
        let v0 = 1;
        let v1 = 0;
        while (v1 < arg0) {
            v0 = v0 * 10;
            v1 = v1 + 1;
        };
        v0
    }

    public fun sqrt(arg0: u128) : u128 {
        if (arg0 < 4) {
            if (arg0 == 0) {
                0
            } else {
                1
            }
        } else {
            let v1 = arg0 / 2 + 1;
            while (v1 < arg0) {
                let v2 = arg0 / v1 + v1;
                v1 = v2 / 2;
            };
            arg0
        }
    }

    public fun sqrt_u64(arg0: u128) : u64 {
        if (arg0 < 4) {
            if (arg0 == 0) {
                0
            } else {
                1
            }
        } else {
            let v1 = arg0 / 2 + 1;
            while (v1 < arg0) {
                let v2 = arg0 / v1 + v1;
                v1 = v2 / 2;
            };
            (arg0 as u64)
        }
    }

    // decompiled from Move bytecode v6
}

