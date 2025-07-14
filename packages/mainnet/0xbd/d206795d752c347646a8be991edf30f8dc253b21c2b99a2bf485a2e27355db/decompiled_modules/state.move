module 0xbdd206795d752c347646a8be991edf30f8dc253b21c2b99a2bf485a2e27355db::state {
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

    fun cal_sqrt_price(arg0: u256, arg1: 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::I128, arg2: u256) : u256 {
        let v0 = (0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::abs_u128(arg1) as u256);
        let v1 = if (0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::is_neg(arg1)) {
            0xbdd206795d752c347646a8be991edf30f8dc253b21c2b99a2bf485a2e27355db::safe_math::sqrt(v0 * v0 + 4 * arg0 * arg2) - v0
        } else {
            0xbdd206795d752c347646a8be991edf30f8dc253b21c2b99a2bf485a2e27355db::safe_math::sqrt(v0 * v0 + 4 * arg0 * arg2) + v0
        };
        (v1 << 64) / (arg0 << 1)
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
        let v0 = 0xbdd206795d752c347646a8be991edf30f8dc253b21c2b99a2bf485a2e27355db::constants::max_fee_pips_u256() - arg0.fee_pips;
        let v1 = arg0.liquidity << 64;
        let v2 = arg0.amount_x_desired + v1 / arg0.sqrt_price;
        let v3 = 0xbdd206795d752c347646a8be991edf30f8dc253b21c2b99a2bf485a2e27355db::safe_math::mul_div_Q64(arg0.liquidity, arg0.sqrt_price * 0xbdd206795d752c347646a8be991edf30f8dc253b21c2b99a2bf485a2e27355db::constants::max_fee_pips_u256() / v0);
        let v4 = arg0.amount_y_desired + v3 - 0xbdd206795d752c347646a8be991edf30f8dc253b21c2b99a2bf485a2e27355db::safe_math::mul_div_Q64(arg0.liquidity, arg0.sqrt_ratio_lower);
        assert!(v4 > arg0.amount_y_desired, 0);
        0x1::u256::max(cal_sqrt_price(v2 - v1 * 0xbdd206795d752c347646a8be991edf30f8dc253b21c2b99a2bf485a2e27355db::constants::max_fee_pips_u256() / v0 * arg0.sqrt_ratio_upper, 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::sub(0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::sub(0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::from((0xbdd206795d752c347646a8be991edf30f8dc253b21c2b99a2bf485a2e27355db::safe_math::mul_div_Q64(v2, arg0.sqrt_ratio_lower) as u128)), 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::from(((arg0.fee_pips * arg0.liquidity / v0) as u128))), 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::from((((arg0.amount_y_desired + v3 << 64) / arg0.sqrt_ratio_upper) as u128))), v4), arg0.sqrt_price)
    }

    public fun solve_zero_for_one(arg0: &SwapState) : u256 {
        let v0 = 0xbdd206795d752c347646a8be991edf30f8dc253b21c2b99a2bf485a2e27355db::constants::max_fee_pips_u256() - arg0.fee_pips;
        let v1 = arg0.liquidity << 64;
        let v2 = v1 * 0xbdd206795d752c347646a8be991edf30f8dc253b21c2b99a2bf485a2e27355db::constants::max_fee_pips_u256() / v0 * arg0.sqrt_price;
        let v3 = arg0.amount_x_desired + v2 - v1 / arg0.sqrt_ratio_upper;
        assert!(v3 > arg0.amount_x_desired, 0);
        let v4 = arg0.amount_y_desired + 0xbdd206795d752c347646a8be991edf30f8dc253b21c2b99a2bf485a2e27355db::safe_math::mul_div_Q64(arg0.liquidity, arg0.sqrt_price);
        0x1::u256::min(cal_sqrt_price(v3, 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::sub(0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::add(0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::from((0xbdd206795d752c347646a8be991edf30f8dc253b21c2b99a2bf485a2e27355db::safe_math::mul_div_Q64(arg0.amount_x_desired + v2, arg0.sqrt_ratio_lower) as u128)), 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::from(((arg0.fee_pips * arg0.liquidity / v0) as u128))), 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::from((((v4 << 64) / arg0.sqrt_ratio_upper) as u128))), v4 - 0xbdd206795d752c347646a8be991edf30f8dc253b21c2b99a2bf485a2e27355db::safe_math::mul_div_Q64(arg0.liquidity, 0xbdd206795d752c347646a8be991edf30f8dc253b21c2b99a2bf485a2e27355db::constants::max_fee_pips_u256() * arg0.sqrt_ratio_lower / v0)), arg0.sqrt_price)
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

    public fun update_swap_state(arg0: &mut SwapState, arg1: 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::I128, arg2: u256, arg3: 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::I32, arg4: u256, arg5: u256) {
        if (0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::is_neg(arg1)) {
            arg0.liquidity = arg0.liquidity - (0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::abs_u128(arg1) as u256);
        } else {
            arg0.liquidity = arg0.liquidity + (0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::abs_u128(arg1) as u256);
        };
        arg0.sqrt_price = arg2;
        arg0.tick = arg3;
        arg0.amount_x_desired = arg4;
        arg0.amount_y_desired = arg5;
    }

    // decompiled from Move bytecode v6
}

