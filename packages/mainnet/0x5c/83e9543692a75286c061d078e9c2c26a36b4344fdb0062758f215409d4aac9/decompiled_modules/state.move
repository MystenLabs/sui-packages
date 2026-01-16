module 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::state {
    struct SwapState has copy, drop {
        liquidity: u256,
        sqrt_price: u256,
        tick: 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::I32,
        amount_x_desired: u256,
        amount_y_desired: u256,
        sqrt_ratio_lower: u256,
        sqrt_ratio_upper: u256,
        fee_pips: u256,
    }

    struct RebalanceReceipt {
        position_id: 0x2::object::ID,
        amount_x: u64,
        amount_y: u64,
        sqrt_price: u128,
        min_liquidity: u128,
    }

    public fun amount_x_desired(arg0: &SwapState) : u64 {
        (arg0.amount_x_desired as u64)
    }

    public fun amount_y_desired(arg0: &SwapState) : u64 {
        (arg0.amount_y_desired as u64)
    }

    fun cal_sqrt_price(arg0: 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::I128, arg1: 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::I128, arg2: 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::I128) : u128 {
        let v0 = 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::shl(arg0, 1);
        let v1 = 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::shl(arg2, 1);
        let v2 = (0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::abs_u128(arg1) as u256);
        let v3 = if (0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::is_neg(v0) == 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::is_neg(v1)) {
            v2 * v2 + (0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::abs_u128(v0) as u256) * (0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::abs_u128(v1) as u256)
        } else {
            v2 * v2 - (0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::abs_u128(v0) as u256) * (0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::abs_u128(v1) as u256)
        };
        let v4 = 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::div(0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::shl(0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::add(u256_to_i128(0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::safe_math::sqrt(v3)), arg1), 64), v0);
        assert!(!0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::is_neg(v4), 0);
        0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::as_u128(v4)
    }

    public fun destroy_rebalance_receipt(arg0: RebalanceReceipt, arg1: &0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::registry::ProxyCap) : (0x2::object::ID, u64, u64, u128, u128) {
        let RebalanceReceipt {
            position_id   : v0,
            amount_x      : v1,
            amount_y      : v2,
            sqrt_price    : v3,
            min_liquidity : v4,
        } = arg0;
        (v0, v1, v2, v3, v4)
    }

    public fun fee_pips(arg0: &SwapState) : u64 {
        (arg0.fee_pips as u64)
    }

    public fun init_swap_state(arg0: u128, arg1: u128, arg2: 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::I32, arg3: u64, arg4: u64, arg5: u128, arg6: u128, arg7: u64) : SwapState {
        SwapState{
            liquidity        : (arg0 as u256),
            sqrt_price       : (arg1 as u256),
            tick             : arg2,
            amount_x_desired : (arg3 as u256),
            amount_y_desired : (arg4 as u256),
            sqrt_ratio_lower : (arg5 as u256),
            sqrt_ratio_upper : (arg6 as u256),
            fee_pips         : (arg7 as u256),
        }
    }

    public fun liquidity(arg0: &SwapState) : u128 {
        (arg0.liquidity as u128)
    }

    public fun new_rebalance_receipt(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u128, arg4: u128, arg5: &0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::registry::ProxyCap) : RebalanceReceipt {
        RebalanceReceipt{
            position_id   : arg0,
            amount_x      : arg1,
            amount_y      : arg2,
            sqrt_price    : arg3,
            min_liquidity : arg4,
        }
    }

    public fun solve_one_for_zero(arg0: &SwapState) : u128 {
        let v0 = 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::constants::scaling_pips_u256() - arg0.fee_pips;
        let v1 = arg0.liquidity << 64;
        let v2 = arg0.amount_x_desired + v1 / arg0.sqrt_price;
        let v3 = 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::safe_math::mul_div_Q64(arg0.liquidity, arg0.sqrt_price * 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::constants::scaling_pips_u256() / v0);
        let v4 = arg0.amount_y_desired + v3 - 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::safe_math::mul_div_Q64(arg0.liquidity, arg0.sqrt_ratio_lower);
        assert!(v4 > arg0.amount_y_desired, 0);
        0x1::u128::max(cal_sqrt_price(0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::sub(u256_to_i128(v2), u256_to_i128(v1 * 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::constants::scaling_pips_u256() / v0 * arg0.sqrt_ratio_upper)), 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::sub(0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::sub(u256_to_i128(0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::safe_math::mul_div_Q64(v2, arg0.sqrt_ratio_lower)), u256_to_i128(arg0.fee_pips * arg0.liquidity / v0)), u256_to_i128((arg0.amount_y_desired + v3 << 64) / arg0.sqrt_ratio_upper)), u256_to_i128(v4)), sqrt_price(arg0))
    }

    public fun solve_zero_for_one(arg0: &SwapState) : u128 {
        let v0 = 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::constants::scaling_pips_u256() - arg0.fee_pips;
        let v1 = arg0.liquidity << 64;
        let v2 = v1 * 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::constants::scaling_pips_u256() / v0 * arg0.sqrt_price;
        let v3 = arg0.amount_x_desired + v2 - v1 / arg0.sqrt_ratio_upper;
        assert!(v3 > arg0.amount_x_desired, 0);
        let v4 = arg0.amount_y_desired + 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::safe_math::mul_div_Q64(arg0.liquidity, arg0.sqrt_price);
        0x1::u128::min(cal_sqrt_price(u256_to_i128(v3), 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::sub(0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::add(u256_to_i128(0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::safe_math::mul_div_Q64(arg0.amount_x_desired + v2, arg0.sqrt_ratio_lower)), u256_to_i128(arg0.fee_pips * arg0.liquidity / v0)), u256_to_i128((v4 << 64) / arg0.sqrt_ratio_upper)), 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::sub(u256_to_i128(v4), u256_to_i128(0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::safe_math::mul_div_Q64(arg0.liquidity, 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::constants::scaling_pips_u256() * arg0.sqrt_ratio_lower / v0)))), sqrt_price(arg0))
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

    fun u256_to_i128(arg0: u256) : 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::I128 {
        0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::from((arg0 as u128))
    }

    public fun update_swap_state(arg0: &mut SwapState, arg1: u128, arg2: u128, arg3: 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::I32, arg4: u64, arg5: u64) {
        arg0.liquidity = (arg1 as u256);
        arg0.sqrt_price = (arg2 as u256);
        arg0.tick = arg3;
        arg0.amount_x_desired = (arg4 as u256);
        arg0.amount_y_desired = (arg5 as u256);
    }

    // decompiled from Move bytecode v6
}

