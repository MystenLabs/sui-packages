module 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::math {
    public fun div_ceil_u128(arg0: u128, arg1: u128) : u128 {
        assert!(arg1 != 0, 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::errors::division_by_zero());
        0x1::u128::div_ceil(arg0, arg1)
    }

    public fun mul_div(arg0: u256, arg1: u256, arg2: u256) : u256 {
        assert!(arg2 != 0, 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::errors::division_by_zero());
        arg0 * arg1 / arg2
    }

    public fun mul_div_ceil(arg0: u256, arg1: u256, arg2: u256) : u256 {
        assert!(arg2 != 0, 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::errors::division_by_zero());
        0x1::u256::div_ceil(arg0 * arg1, arg2)
    }

    public fun mul_div_ceil_u128(arg0: u128, arg1: u128, arg2: u128) : u128 {
        let v0 = mul_div_ceil((arg0 as u256), (arg1 as u256), (arg2 as u256));
        assert!(v0 <= 340282366920938463463374607431768211455, 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::errors::overflow());
        (v0 as u128)
    }

    public fun mul_div_ceil_u64(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = mul_div_ceil((arg0 as u256), (arg1 as u256), (arg2 as u256));
        assert!(v0 <= 18446744073709551615, 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::errors::overflow());
        (v0 as u64)
    }

    public fun mul_div_u128(arg0: u128, arg1: u128, arg2: u128) : u128 {
        let v0 = mul_div((arg0 as u256), (arg1 as u256), (arg2 as u256));
        assert!(v0 <= 340282366920938463463374607431768211455, 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::errors::overflow());
        (v0 as u128)
    }

    public fun mul_div_u64(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = mul_div((arg0 as u256), (arg1 as u256), (arg2 as u256));
        assert!(v0 <= 18446744073709551615, 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::errors::overflow());
        (v0 as u64)
    }

    public fun signed_add(arg0: u256, arg1: bool, arg2: u256, arg3: bool) : (u256, bool) {
        if (arg1 == arg3) {
            let v2 = arg0 + arg2;
            let v3 = arg1 && v2 != 0;
            (v2, v3)
        } else if (arg0 >= arg2) {
            let v4 = arg0 - arg2;
            let v5 = arg1 && v4 != 0;
            (v4, v5)
        } else {
            (arg2 - arg0, arg3)
        }
    }

    public fun signed_div_pos(arg0: u256, arg1: bool, arg2: u256) : (u256, bool) {
        assert!(arg2 != 0, 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::errors::division_by_zero());
        let v0 = arg0 / arg2;
        let v1 = arg1 && v0 != 0;
        (v0, v1)
    }

    public fun signed_from_diff(arg0: u256, arg1: u256) : (u256, bool) {
        if (arg0 >= arg1) {
            (arg0 - arg1, false)
        } else {
            (arg1 - arg0, true)
        }
    }

    public fun signed_is_negative(arg0: u256, arg1: bool) : bool {
        arg1 && arg0 != 0
    }

    public fun signed_mul_pos(arg0: u256, arg1: bool, arg2: u256) : (u256, bool) {
        let v0 = arg0 * arg2;
        let v1 = arg1 && v0 != 0;
        (v0, v1)
    }

    public fun signed_neg(arg0: u256, arg1: bool) : (u256, bool) {
        let v0 = !arg1 && arg0 != 0;
        (arg0, v0)
    }

    // decompiled from Move bytecode v7
}

