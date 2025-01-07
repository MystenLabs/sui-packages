module 0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::math {
    public fun average(arg0: u128, arg1: u128) : u128 {
        if (arg0 < arg1) {
            arg0 + (arg1 - arg0) / 2
        } else {
            arg1 + (arg0 - arg1) / 2
        }
    }

    public fun max(arg0: u128, arg1: u128) : u128 {
        if (arg0 >= arg1) {
            arg0
        } else {
            arg1
        }
    }

    public fun min(arg0: u128, arg1: u128) : u128 {
        if (arg0 < arg1) {
            arg0
        } else {
            arg1
        }
    }

    public fun mul_div_u128(arg0: u128, arg1: u128, arg2: u128) : u64 {
        assert!(arg2 != 0, 500);
        let v0 = arg0 * arg1 / arg2;
        assert!(!(v0 > (18446744073709551615 as u128)), 501);
        (v0 as u64)
    }

    public fun mul_div_u64(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 != 0, 500);
        let v0 = (arg0 as u128) * (arg1 as u128) / (arg2 as u128);
        assert!(!(v0 > (18446744073709551615 as u128)), 501);
        (v0 as u64)
    }

    public fun mul_to_u128(arg0: u64, arg1: u64) : u128 {
        (arg0 as u128) * (arg1 as u128)
    }

    public fun pow(arg0: u128, arg1: u128) : u128 {
        if (arg1 == 0) {
            1
        } else {
            let v1 = 1;
            while (arg1 > 1) {
                if (arg1 % 2 == 1) {
                    v1 = v1 * arg0;
                };
                arg1 = arg1 / 2;
                arg0 = arg0 * arg0;
            };
            v1 * arg0
        }
    }

    public fun sqrt(arg0: u128) : u64 {
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

