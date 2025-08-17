module 0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::math_u128 {
    public fun add(arg0: u128, arg1: u128) : u128 {
        let (v0, v1) = 0x38747d8471b55cfdd72ba8331877392bdb5416e241d3103f1836409faa1301ba::math_u128::overflowing_add(arg0, arg1);
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
        let (v0, v1) = 0x38747d8471b55cfdd72ba8331877392bdb5416e241d3103f1836409faa1301ba::math_u128::overflowing_mul(arg0, arg1);
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
        let (v0, v1) = 0x38747d8471b55cfdd72ba8331877392bdb5416e241d3103f1836409faa1301ba::math_u128::overflowing_sub(arg0, arg1);
        assert!(v1, 0);
        v0
    }

    // decompiled from Move bytecode v6
}

