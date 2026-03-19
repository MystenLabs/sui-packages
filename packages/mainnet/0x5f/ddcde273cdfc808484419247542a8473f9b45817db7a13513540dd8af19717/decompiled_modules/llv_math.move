module 0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_math {
    public fun calculate_assets_for_shares(arg0: u128, arg1: u128, arg2: u128) : u128 {
        mul_div(arg2, arg1 + 1000000, arg0 + 1000000)
    }

    public fun calculate_proportional_withdraw_burn(arg0: u128, arg1: u128, arg2: u128) : u128 {
        let v0 = if (arg1 == 0) {
            1
        } else {
            arg1
        };
        if (arg2 >= arg1) {
            mul_div_ceil(arg0, arg2, v0)
        } else {
            mul_div(arg0, arg2, v0)
        }
    }

    public fun calculate_shares(arg0: u128, arg1: u128, arg2: u64) : u128 {
        mul_div((arg2 as u128), arg0 + 1000000, arg1 + 1000000)
    }

    public fun calculate_shares_for_assets(arg0: u128, arg1: u128, arg2: u64) : u128 {
        if (arg2 == 0) {
            return 0
        };
        let v0 = arg1 + 1000000;
        (((((arg2 as u128) as u256) * ((arg0 + 1000000) as u256) + (v0 as u256) - 1) / (v0 as u256)) as u128)
    }

    public fun calculate_shares_with_min(arg0: u128, arg1: u128, arg2: u64) : u128 {
        let v0 = calculate_shares(arg0, arg1, arg2);
        assert!(v0 >= 1000000, 1);
        v0
    }

    public fun min_shares() : u128 {
        1000000
    }

    public fun mul_div(arg0: u128, arg1: u128, arg2: u128) : u128 {
        assert!(arg2 != 0, 2);
        (((arg0 as u256) * (arg1 as u256) / (arg2 as u256)) as u128)
    }

    public fun mul_div_ceil(arg0: u128, arg1: u128, arg2: u128) : u128 {
        assert!(arg2 != 0, 2);
        let v0 = (arg2 as u256);
        ((((arg0 as u256) * (arg1 as u256) + v0 - 1) / v0) as u128)
    }

    public fun scale() : u128 {
        1000000000000000000
    }

    public fun virtual_offset() : u128 {
        1000000
    }

    // decompiled from Move bytecode v6
}

