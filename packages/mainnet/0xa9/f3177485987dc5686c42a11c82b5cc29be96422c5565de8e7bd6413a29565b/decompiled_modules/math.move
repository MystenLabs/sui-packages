module 0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::math {
    public fun add(arg0: u64, arg1: u64) : u64 {
        let v0 = arg0 + arg1;
        assert!(v0 >= arg0, 0);
        v0
    }

    public fun diff(arg0: u64, arg1: u64) : u64 {
        if (arg0 > arg1) {
            arg0 - arg1
        } else {
            arg1 - arg0
        }
    }

    public fun divide_and_round_up(arg0: u64, arg1: u64) : u64 {
        if (arg0 % arg1 == 0) {
            arg0 / arg1
        } else {
            arg0 / arg1 + 1
        }
    }

    public fun fraction(arg0: u64, arg1: u64) : u64 {
        ((((arg0 as u128) << 64) / (arg1 as u128) / 18446744073709) as u64)
    }

    public fun max(arg0: u64, arg1: u64) : u64 {
        if (arg0 > arg1) {
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

    public fun pow(arg0: u64, arg1: u8) : u64 {
        let v0 = 1;
        while (arg1 >= 1) {
            if (arg1 % 2 == 0) {
                arg0 = arg0 * arg0;
                arg1 = arg1 / 2;
                continue
            };
            v0 = v0 * arg0;
            arg1 = arg1 - 1;
        };
        v0
    }

    public fun safe_compare_mul_u64(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : bool {
        (arg0 as u128) * (arg1 as u128) >= (arg2 as u128) * (arg3 as u128)
    }

    public fun safe_mul_div_u64(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    public fun safe_mul_u64(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128)) as u64)
    }

    public fun sqrt(arg0: u64) : u64 {
        let v0 = 18446744073709551616;
        let v1 = 0;
        let v2 = (arg0 as u128);
        while (v0 != 0) {
            if (v2 >= v1 + v0) {
                v2 = v2 - v1 + v0;
                let v3 = v1 >> 1;
                v1 = v3 + v0;
            } else {
                v1 = v1 >> 1;
            };
            v0 = v0 >> 2;
        };
        (v1 as u64)
    }

    public fun sqrt_u128(arg0: u128) : u128 {
        let v0 = 340282366920938463463374607431768211456;
        let v1 = 0;
        let v2 = (arg0 as u256);
        while (v0 != 0) {
            if (v2 >= v1 + v0) {
                v2 = v2 - v1 + v0;
                let v3 = v1 >> 1;
                v1 = v3 + v0;
            } else {
                v1 = v1 >> 1;
            };
            v0 = v0 >> 2;
        };
        (v1 as u128)
    }

    public fun sub(arg0: u64, arg1: u64) : u64 {
        assert!(arg0 >= arg1, 0);
        arg0 - arg1
    }

    // decompiled from Move bytecode v6
}

