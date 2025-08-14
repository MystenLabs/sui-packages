module 0x21434e007ce5707e83d2299241a2669ea0490a7d7b183fd386c3033255dd96da::math_u128 {
    public fun add(arg0: u128, arg1: u128) : u128 {
        let (v0, v1) = 0x6a8355b33846fbe585bbd17ee2470c7de17bb9bdf398363b616389568bc658c0::math_u128::overflowing_add(arg0, arg1);
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
        let (v0, v1) = 0x6a8355b33846fbe585bbd17ee2470c7de17bb9bdf398363b616389568bc658c0::math_u128::overflowing_mul(arg0, arg1);
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
        let (v0, v1) = 0x6a8355b33846fbe585bbd17ee2470c7de17bb9bdf398363b616389568bc658c0::math_u128::overflowing_sub(arg0, arg1);
        assert!(v1, 0);
        v0
    }

    // decompiled from Move bytecode v6
}

