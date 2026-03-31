module 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_math {
    public fun calculate_assets_for_shares(arg0: u128, arg1: u128, arg2: u128) : u128 {
        mul_div(arg2, arg1 + 1000000, arg0 + 1000000)
    }

    public fun calculate_max_shares_for_assets_u128(arg0: u128, arg1: u128, arg2: u128) : u128 {
        if (arg2 == 0) {
            return 0
        };
        mul_div(arg2, arg0 + 1000000, arg1 + 1000000)
    }

    public fun calculate_proportional_withdraw_burn(arg0: u128, arg1: u128, arg2: u128) : u128 {
        let v0 = if (arg1 == 0) {
            1
        } else {
            arg1
        };
        if (arg2 >= arg1) {
            let v2 = mul_div_ceil(arg0, arg2, v0);
            if (v2 > arg0) {
                arg0
            } else {
                v2
            }
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

    public fun calculate_shares_for_assets_ceil_u128(arg0: u128, arg1: u128, arg2: u128) : u128 {
        if (arg2 == 0) {
            return 0
        };
        let v0 = arg1 + 1000000;
        ((((arg2 as u256) * ((arg0 + 1000000) as u256) + (v0 as u256) - 1) / (v0 as u256)) as u128)
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
        let v0 = (arg0 as u256) * (arg1 as u256) / (arg2 as u256);
        assert!(v0 <= 340282366920938463463374607431768211455, 3);
        (v0 as u128)
    }

    public fun mul_div_ceil(arg0: u128, arg1: u128, arg2: u128) : u128 {
        assert!(arg2 != 0, 2);
        let v0 = (arg2 as u256);
        let v1 = ((arg0 as u256) * (arg1 as u256) + v0 - 1) / v0;
        assert!(v1 <= 340282366920938463463374607431768211455, 3);
        (v1 as u128)
    }

    public fun scale() : u128 {
        1000000000000000000
    }

    public fun virtual_offset() : u128 {
        1000000
    }

    // decompiled from Move bytecode v6
}

