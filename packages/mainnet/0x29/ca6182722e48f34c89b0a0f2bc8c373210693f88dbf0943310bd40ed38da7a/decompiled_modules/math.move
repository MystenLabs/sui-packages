module 0x29ca6182722e48f34c89b0a0f2bc8c373210693f88dbf0943310bd40ed38da7a::math {
    public fun ceil_div(arg0: u64, arg1: u64) : u64 {
        if (arg0 == 0) {
            0
        } else {
            (arg0 - 1) / arg1 + 1
        }
    }

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

    public fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 != 0, 500);
        let v0 = (arg0 as u128) * (arg1 as u128) / (arg2 as u128);
        assert!(!(v0 > (18446744073709551615 as u128)), 501);
        (v0 as u64)
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

    public fun power_decimals(arg0: u64) : u64 {
        if (arg0 == 0) {
            return 1
        };
        let v0 = 10;
        arg0 = arg0 - 1;
        while (arg0 > 0) {
            v0 = v0 * 10;
            arg0 = arg0 - 1;
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

    // decompiled from Move bytecode v6
}

