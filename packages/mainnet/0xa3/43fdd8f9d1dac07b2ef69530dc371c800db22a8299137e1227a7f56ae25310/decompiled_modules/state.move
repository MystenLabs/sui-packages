module 0x61ad0632db24fe95f8a3e9dfa51eb7e74678a6acbbe54b03cc78ad2834109e19::state {
    struct SwapState has copy, drop {
        liquidity: u256,
        sqrt_price: u256,
        tick: 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::I32,
        amount_x_desired: u256,
        amount_y_desired: u256,
        sqrt_ratio_lower: u256,
        sqrt_ratio_upper: u256,
        fee_pips: u256,
        tick_spacing: 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::I32,
    }

    public fun amount_x_desired(arg0: &SwapState) : u64 {
        (arg0.amount_x_desired as u64)
    }

    public fun amount_y_desired(arg0: &SwapState) : u64 {
        (arg0.amount_y_desired as u64)
    }

    public fun fee_pips(arg0: &SwapState) : u64 {
        (arg0.fee_pips as u64)
    }

    public fun init_swap_state(arg0: u128, arg1: u128, arg2: 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::I32, arg3: u64, arg4: u64, arg5: u128, arg6: u128, arg7: u64, arg8: u32) : SwapState {
        SwapState{
            liquidity        : (arg0 as u256),
            sqrt_price       : (arg1 as u256),
            tick             : arg2,
            amount_x_desired : (arg3 as u256),
            amount_y_desired : (arg4 as u256),
            sqrt_ratio_lower : (arg5 as u256),
            sqrt_ratio_upper : (arg6 as u256),
            fee_pips         : (arg7 as u256),
            tick_spacing     : 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::from_u32(arg8),
        }
    }

    public fun liquidity(arg0: &SwapState) : u128 {
        (arg0.liquidity as u128)
    }

    public fun solve_one_for_zero(arg0: &SwapState) : u256 {
        let v0 = 0x61ad0632db24fe95f8a3e9dfa51eb7e74678a6acbbe54b03cc78ad2834109e19::constants::max_fee_pips_u256() - arg0.fee_pips;
        let v1 = arg0.liquidity << 64;
        let v2 = arg0.amount_x_desired + v1 / arg0.sqrt_price;
        let v3 = v1 * 0x61ad0632db24fe95f8a3e9dfa51eb7e74678a6acbbe54b03cc78ad2834109e19::constants::max_fee_pips_u256() / v0 * arg0.sqrt_ratio_upper;
        assert!(v2 >= v3, 10);
        let v4 = v2 - v3;
        let v5 = 0x61ad0632db24fe95f8a3e9dfa51eb7e74678a6acbbe54b03cc78ad2834109e19::safe_math::mul_div_Q64(arg0.liquidity, arg0.sqrt_price * 0x61ad0632db24fe95f8a3e9dfa51eb7e74678a6acbbe54b03cc78ad2834109e19::constants::max_fee_pips_u256() / v0);
        let v6 = arg0.amount_y_desired + v5 - 0x61ad0632db24fe95f8a3e9dfa51eb7e74678a6acbbe54b03cc78ad2834109e19::safe_math::mul_div_Q64(arg0.liquidity, arg0.sqrt_ratio_lower);
        assert!(v6 > arg0.amount_y_desired, 0);
        let v7 = 0x61ad0632db24fe95f8a3e9dfa51eb7e74678a6acbbe54b03cc78ad2834109e19::safe_math::mul_div_Q64(v2, arg0.sqrt_ratio_lower);
        let v8 = arg0.fee_pips * arg0.liquidity / v0;
        assert!(v7 >= v8 + (arg0.amount_y_desired + v5 << 64) / arg0.sqrt_ratio_upper, 11);
        let v9 = v7 - v8 - (arg0.amount_y_desired + v5 << 64) / arg0.sqrt_ratio_upper;
        0x1::u256::max((v9 + 0x61ad0632db24fe95f8a3e9dfa51eb7e74678a6acbbe54b03cc78ad2834109e19::safe_math::sqrt(v9 * v9 + 4 * v4 * v6) << 64) / 2 * v4, arg0.sqrt_price)
    }

    public fun solve_zero_for_one(arg0: &SwapState) : u256 {
        let v0 = 0x61ad0632db24fe95f8a3e9dfa51eb7e74678a6acbbe54b03cc78ad2834109e19::constants::max_fee_pips_u256() - arg0.fee_pips;
        let v1 = arg0.liquidity << 64;
        let v2 = v1 * 0x61ad0632db24fe95f8a3e9dfa51eb7e74678a6acbbe54b03cc78ad2834109e19::constants::max_fee_pips_u256() / v0 * arg0.sqrt_price;
        let v3 = arg0.amount_x_desired + v2 - v1 / arg0.sqrt_ratio_upper;
        assert!(v3 > arg0.amount_x_desired, 0);
        let v4 = arg0.amount_y_desired + 0x61ad0632db24fe95f8a3e9dfa51eb7e74678a6acbbe54b03cc78ad2834109e19::safe_math::mul_div_Q64(arg0.liquidity, arg0.sqrt_price);
        let v5 = 0x61ad0632db24fe95f8a3e9dfa51eb7e74678a6acbbe54b03cc78ad2834109e19::safe_math::mul_div_Q64(arg0.amount_x_desired + v2, arg0.sqrt_ratio_lower) + arg0.fee_pips * arg0.liquidity / v0 - (v4 << 64) / arg0.sqrt_ratio_upper;
        0x1::u256::min((v5 + 0x61ad0632db24fe95f8a3e9dfa51eb7e74678a6acbbe54b03cc78ad2834109e19::safe_math::sqrt(v5 * v5 + 4 * v3 * (v4 - 0x61ad0632db24fe95f8a3e9dfa51eb7e74678a6acbbe54b03cc78ad2834109e19::safe_math::mul_div_Q64(arg0.liquidity, 0x61ad0632db24fe95f8a3e9dfa51eb7e74678a6acbbe54b03cc78ad2834109e19::constants::max_fee_pips_u256() * arg0.sqrt_ratio_lower / v0))) << 64) / 2 * v3, arg0.sqrt_price)
    }

    public fun sqrt_price(arg0: &SwapState) : u128 {
        (arg0.sqrt_price as u128)
    }

    public fun sqrt_ratio_lower(arg0: &SwapState) : u128 {
        (arg0.sqrt_ratio_lower as u128)
    }

    public fun sqrt_ratio_upper(arg0: &SwapState) : u128 {
        (arg0.sqrt_ratio_upper as u128)
    }

    public fun tick(arg0: &SwapState) : 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::I32 {
        arg0.tick
    }

    public fun tick_spacing(arg0: &SwapState) : 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::I32 {
        arg0.tick_spacing
    }

    public fun update_swap_state(arg0: &mut SwapState, arg1: u256, arg2: u256, arg3: 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::I32, arg4: u256, arg5: u256) {
        arg0.liquidity = arg0.liquidity + arg1;
        arg0.sqrt_price = arg2;
        arg0.tick = arg3;
        arg0.amount_x_desired = arg4;
        arg0.amount_y_desired = arg5;
    }

    // decompiled from Move bytecode v6
}

