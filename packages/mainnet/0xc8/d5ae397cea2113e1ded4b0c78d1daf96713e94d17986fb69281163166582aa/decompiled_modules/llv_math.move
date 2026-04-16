module 0x2c86748ceda3fe9a35b5138b56fbd2c93a62a128250b686a0d153be3f8fe8784::llv_math {
    public fun accounted_value_delta(arg0: u128, arg1: u128) : u64 {
        if (arg1 <= arg0) {
            0
        } else {
            let v1 = arg1 - arg0;
            if (v1 > 18446744073709551615) {
                18446744073709551615
            } else {
                (v1 as u64)
            }
        }
    }

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
        let v1 = mul_div_ceil(arg0, arg2, v0);
        if (v1 > arg0) {
            arg0
        } else {
            v1
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

    public fun calculate_shares_with_min(arg0: u128, arg1: u128, arg2: u64, arg3: u128) : u128 {
        let v0 = calculate_shares(arg0, arg1, arg2);
        assert!(v0 >= arg3, 1);
        v0
    }

    public fun default_min_shares() : u128 {
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

    public fun select_receipt_token_withdraw_amount(arg0: u128, arg1: u64, arg2: u128, arg3: u128, arg4: u64) : u64 {
        let v0 = if (arg0 == 0) {
            true
        } else if (arg1 == 0) {
            true
        } else if (arg2 == 0) {
            true
        } else if (arg3 == 0) {
            true
        } else {
            arg4 == 0
        };
        if (v0) {
            return 0
        };
        let v1 = ((((arg0 as u256) * (arg3 as u256) + (arg2 as u256) - 1) / (arg2 as u256)) as u128);
        let v2 = mul_div((arg4 as u128), arg3, arg2);
        let v3 = if (v1 < v2) {
            v1
        } else {
            v2
        };
        let v4 = if (v3 > (arg1 as u128)) {
            (arg1 as u128)
        } else {
            v3
        };
        (v4 as u64)
    }

    public fun select_withdraw_amount(arg0: u128, arg1: u128, arg2: u64) : u64 {
        let v0 = if (arg0 == 0) {
            true
        } else if (arg1 == 0) {
            true
        } else {
            arg2 == 0
        };
        if (v0) {
            return 0
        };
        let v1 = if (arg0 > arg1) {
            arg1
        } else {
            arg0
        };
        let v2 = if (v1 > (arg2 as u128)) {
            (arg2 as u128)
        } else {
            v1
        };
        (v2 as u64)
    }

    public fun virtual_offset() : u128 {
        1000000
    }

    // decompiled from Move bytecode v7
}

