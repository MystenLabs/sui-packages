module 0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::math_u64 {
    public fun add_check(arg0: u64, arg1: u64) : bool {
        18446744073709551615 - arg0 >= arg1
    }

    public fun carry_add(arg0: u64, arg1: u64, arg2: u64) : (u64, u64) {
        assert!(arg2 <= 1, 0);
        let v0 = (arg0 as u128) + (arg1 as u128) + (arg2 as u128);
        if (v0 > 18446744073709551615) {
            (((v0 & 18446744073709551615) as u64), 1)
        } else {
            ((v0 as u64), 0)
        }
    }

    public fun overflowing_add(arg0: u64, arg1: u64) : (u64, bool) {
        let v0 = (arg0 as u128) + (arg1 as u128);
        if (v0 > (18446744073709551615 as u128)) {
            (((v0 & 18446744073709551615) as u64), true)
        } else {
            ((v0 as u64), false)
        }
    }

    public fun overflowing_mul(arg0: u64, arg1: u64) : (u64, bool) {
        let v0 = (arg0 as u128) * (arg1 as u128);
        (((v0 & 18446744073709551615) as u64), v0 & 340282366920938463444927863358058659840 > 0)
    }

    public fun overflowing_sub(arg0: u64, arg1: u64) : (u64, bool) {
        if (arg0 >= arg1) {
            (arg0 - arg1, false)
        } else {
            (18446744073709551615 - arg1 + arg0 + 1, true)
        }
    }

    public fun wrapping_add(arg0: u64, arg1: u64) : u64 {
        let (v0, _) = overflowing_add(arg0, arg1);
        v0
    }

    public fun wrapping_mul(arg0: u64, arg1: u64) : u64 {
        let (v0, _) = overflowing_mul(arg0, arg1);
        v0
    }

    public fun wrapping_sub(arg0: u64, arg1: u64) : u64 {
        let (v0, _) = overflowing_sub(arg0, arg1);
        v0
    }

    // decompiled from Move bytecode v6
}

