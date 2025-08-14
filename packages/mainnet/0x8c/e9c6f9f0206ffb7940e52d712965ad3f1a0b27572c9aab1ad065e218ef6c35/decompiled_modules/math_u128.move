module 0x8ce9c6f9f0206ffb7940e52d712965ad3f1a0b27572c9aab1ad065e218ef6c35::math_u128 {
    public fun add(arg0: u128, arg1: u128) : u128 {
        let (v0, v1) = 0x731710adc6979ec0acfa6e969b3ce4740e961854c5c851d132abb0b2831c4d28::math_u128::overflowing_add(arg0, arg1);
        assert!(v1, 0);
        v0
    }

    public fun div_floor(arg0: u128, arg1: u128) : u128 {
        arg0 / arg1
    }

    public fun full_mul(arg0: u128, arg1: u128) : u256 {
        (arg0 as u256) * (arg1 as u256)
    }

    public fun mul(arg0: u128, arg1: u128) : u128 {
        let (v0, v1) = 0x731710adc6979ec0acfa6e969b3ce4740e961854c5c851d132abb0b2831c4d28::math_u128::overflowing_mul(arg0, arg1);
        assert!(v1, 0);
        v0
    }

    public fun mul_div_ceil(arg0: u128, arg1: u128, arg2: u128) : u128 {
        (((full_mul(arg0, arg1) + (arg2 as u256) - 1) / (arg2 as u256)) as u128)
    }

    public fun mul_div_floor(arg0: u128, arg1: u128, arg2: u128) : u128 {
        ((full_mul(arg0, arg1) / (arg2 as u256)) as u128)
    }

    public fun sub(arg0: u128, arg1: u128) : u128 {
        let (v0, v1) = 0x731710adc6979ec0acfa6e969b3ce4740e961854c5c851d132abb0b2831c4d28::math_u128::overflowing_sub(arg0, arg1);
        assert!(v1, 0);
        v0
    }

    // decompiled from Move bytecode v6
}

