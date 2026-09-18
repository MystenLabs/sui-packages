module 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::liquidity_calcs {
    public fun calc_borrow_limit_after_operate(arg0: u128, arg1: u128, arg2: u128, arg3: u64, arg4: u128) : u128 {
        let v0 = (arg0 as u256);
        let v1 = v0 + expansion_amount(v0, arg3);
        let v2 = v1;
        if (v1 < (arg1 as u256)) {
            return arg1
        };
        if (v1 > (arg2 as u256)) {
            v2 = (arg2 as u256);
        };
        if ((arg4 as u256) > v2) {
            return (v2 as u128)
        };
        arg4
    }

    public fun calc_borrow_limit_before_operate(arg0: u256, arg1: u128, arg2: u64, arg3: u64, arg4: u128, arg5: u128, arg6: u64, arg7: u64) : u128 {
        let v0 = expansion_amount(arg0, arg2);
        let v1 = arg0 + v0;
        if ((v1 as u128) < arg4) {
            return arg4
        };
        let v2 = 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::math::mul_div(v0, ((arg7 - arg6) as u256), (arg3 as u256)) + (arg1 as u256);
        let v3 = v2;
        if (v2 > v1) {
            v3 = v1;
        };
        if (v3 > (arg5 as u256)) {
            return arg5
        };
        (v3 as u128)
    }

    public fun calc_withdrawal_limit_after_operate(arg0: u128, arg1: u128, arg2: u64, arg3: u128) : u128 {
        if (arg0 < arg1) {
            return 0
        };
        let v0 = (arg0 as u256);
        let v1 = v0 - expansion_amount(v0, arg2);
        if (v1 > (arg3 as u256)) {
            (v1 as u128)
        } else {
            arg3
        }
    }

    public fun calc_withdrawal_limit_before_operate(arg0: u128, arg1: u128, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : u128 {
        if (arg1 == 0) {
            return 0
        };
        let v0 = expansion_amount((arg0 as u256), arg2);
        let v1 = 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::math::mul_div(v0, ((arg5 - arg4) as u256), (arg3 as u256));
        let v2 = if ((arg1 as u256) > v1) {
            (arg1 as u256) - v1
        } else {
            0
        };
        let v3 = v2;
        let v4 = (arg0 as u256) - v0;
        if (v4 > v2) {
            v3 = v4;
        };
        (v3 as u128)
    }

    public(friend) fun expansion_amount(arg0: u256, arg1: u64) : u256 {
        arg0 * (arg1 as u256) / (0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::constants::four_decimals() as u256)
    }

    public(friend) fun get_total_borrow(arg0: u64, arg1: u64, arg2: u128) : u128 {
        (arg1 as u128) + (arg0 as u128) * arg2 / 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::constants::exchange_prices_precision()
    }

    public(friend) fun get_total_supply(arg0: u64, arg1: u64, arg2: u128) : u128 {
        (arg1 as u128) + (arg0 as u128) * arg2 / 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::constants::exchange_prices_precision()
    }

    public(friend) fun get_total_supply_ceil(arg0: u64, arg1: u64, arg2: u128) : u128 {
        (arg1 as u128) + 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::math::div_ceil_u128((arg0 as u128) * arg2, 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::constants::exchange_prices_precision())
    }

    public(friend) fun get_with_interest_vs_free_ratio(arg0: u128, arg1: u128) : u128 {
        if (arg0 > arg1) {
            arg1 * (0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::constants::four_decimals() as u128) / arg0
        } else if (arg0 < arg1) {
            arg0 * (0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::constants::four_decimals() as u128) / arg1
        } else if (arg0 > 0) {
            (0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::constants::four_decimals() as u128)
        } else {
            0
        }
    }

    // decompiled from Move bytecode v7
}

