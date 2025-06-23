module 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::math_u128 {
    public fun add_check(arg0: u128, arg1: u128) : bool {
        340282366920938463463374607431768211455 - arg0 >= arg1
    }

    public fun checked_div_round(arg0: u128, arg1: u128, arg2: bool) : u128 {
        assert!(arg1 > 0, 1);
        if (arg2 && arg0 % arg1 > 0) {
            return arg0 / arg1 + 1
        };
        arg0 / arg1
    }

    public fun from_lo_hi(arg0: u64, arg1: u64) : u128 {
        ((arg1 as u128) << 64) + (arg0 as u128)
    }

    public fun full_mul(arg0: u128, arg1: u128) : (u128, u128) {
        let v0 = (arg0 as u256) * (arg1 as u256);
        (((v0 & 340282366920938463463374607431768211455) as u128), (((v0 & 115792089237316195423570985008687907852929702298719625575994209400481361428480) >> 128) as u128))
    }

    public fun hi(arg0: u128) : u64 {
        (((arg0 & 340282366920938463444927863358058659840) >> 64) as u64)
    }

    public fun hi_u128(arg0: u128) : u128 {
        (arg0 & 340282366920938463444927863358058659840) >> 64
    }

    public fun lo(arg0: u128) : u64 {
        ((arg0 & 18446744073709551615) as u64)
    }

    public fun lo_u128(arg0: u128) : u128 {
        arg0 & 18446744073709551615
    }

    public fun max(arg0: u128, arg1: u128) : u128 {
        if (arg0 > arg1) {
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

    public fun overflowing_add(arg0: u128, arg1: u128) : (u128, bool) {
        let v0 = (arg0 as u256) + (arg1 as u256);
        if (v0 > (340282366920938463463374607431768211455 as u256)) {
            (((v0 & 340282366920938463463374607431768211455) as u128), true)
        } else {
            ((v0 as u128), false)
        }
    }

    public fun overflowing_mul(arg0: u128, arg1: u128) : (u128, bool) {
        let (v0, v1) = full_mul(arg0, arg1);
        let v2 = v1 > 0;
        (v0, v2)
    }

    public fun overflowing_sub(arg0: u128, arg1: u128) : (u128, bool) {
        if (arg0 >= arg1) {
            (arg0 - arg1, false)
        } else {
            (340282366920938463463374607431768211455 - arg1 + arg0 + 1, true)
        }
    }

    public fun wrapping_add(arg0: u128, arg1: u128) : u128 {
        let (v0, _) = overflowing_add(arg0, arg1);
        v0
    }

    public fun wrapping_mul(arg0: u128, arg1: u128) : u128 {
        let (v0, _) = overflowing_mul(arg0, arg1);
        v0
    }

    public fun wrapping_sub(arg0: u128, arg1: u128) : u128 {
        let (v0, _) = overflowing_sub(arg0, arg1);
        v0
    }

    // decompiled from Move bytecode v6
}

