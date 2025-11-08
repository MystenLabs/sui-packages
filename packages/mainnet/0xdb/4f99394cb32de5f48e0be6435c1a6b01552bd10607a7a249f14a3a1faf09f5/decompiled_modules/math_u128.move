module 0xdb4f99394cb32de5f48e0be6435c1a6b01552bd10607a7a249f14a3a1faf09f5::math_u128 {
    public fun add(arg0: u128, arg1: u128) : u128 {
        let (v0, v1) = overflowing_add(arg0, arg1);
        assert!(!v1, 100);
        v0
    }

    public fun div_floor(arg0: u128, arg1: u128) : u128 {
        arg0 / arg1
    }

    public fun full_mul(arg0: u128, arg1: u128) : u256 {
        (arg0 as u256) * (arg1 as u256)
    }

    public fun mul(arg0: u128, arg1: u128) : u128 {
        let (v0, v1) = overflowing_mul(arg0, arg1);
        assert!(!v1, 100);
        v0
    }

    public fun mul_div_ceil(arg0: u128, arg1: u128, arg2: u128) : u128 {
        assert!(arg2 != 0, 0xdb4f99394cb32de5f48e0be6435c1a6b01552bd10607a7a249f14a3a1faf09f5::error::e_div_by_zero());
        (((full_mul(arg0, arg1) + (arg2 as u256) - 1) / (arg2 as u256)) as u128)
    }

    public fun mul_div_floor(arg0: u128, arg1: u128, arg2: u128) : u128 {
        assert!(arg2 != 0, 0xdb4f99394cb32de5f48e0be6435c1a6b01552bd10607a7a249f14a3a1faf09f5::error::e_div_by_zero());
        ((full_mul(arg0, arg1) / (arg2 as u256)) as u128)
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
        let (v0, v1) = split_mul(arg0, arg1);
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

    public fun split_mul(arg0: u128, arg1: u128) : (u128, u128) {
        let v0 = (arg0 as u256) * (arg1 as u256);
        (((v0 & 340282366920938463463374607431768211455) as u128), (((v0 & 115792089237316195423570985008687907852929702298719625575994209400481361428480) >> 128) as u128))
    }

    public fun sub(arg0: u128, arg1: u128) : u128 {
        let (v0, v1) = overflowing_sub(arg0, arg1);
        assert!(!v1, 100);
        v0
    }

    // decompiled from Move bytecode v6
}

