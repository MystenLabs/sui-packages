module 0x37b46b17052e589a9f7bd7c1b957bf8a83c82c794e998a714a7b4018a227f0e9::clmm {
    struct Rebalanced has copy, drop {
        pool_id: 0x2::object::ID,
        old_position_id: 0x2::object::ID,
        new_position_id: 0x2::object::ID,
        old_amount_x: u64,
        old_amount_y: u64,
        new_amount_x: u64,
        new_amount_y: u64,
        old_lower_tick_bits: u32,
        old_upper_tick_bits: u32,
        new_lower_tick_bits: u32,
        new_upper_tick_bits: u32,
        old_liquidity: u128,
        new_liquidity: u128,
    }

    struct ZappedIn has copy, drop {
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        amount_x: u64,
        amount_y: u64,
    }

    struct SwapState has copy, drop {
        liquidity: u128,
        sqrt_price_x64: u128,
        tick: 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::I32,
        amount_x_desired: u64,
        amount_y_desired: u64,
        sqrt_ratio_lower_x64: u128,
        sqrt_ratio_upper_x64: u128,
        fee_pips: u64,
        tick_spacing: u32,
    }

    public fun amount_x_desired(arg0: &SwapState) : u64 {
        arg0.amount_x_desired
    }

    public fun amount_y_desired(arg0: &SwapState) : u64 {
        arg0.amount_y_desired
    }

    public(friend) fun emit_rebalanced(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u32, arg8: u32, arg9: u32, arg10: u32, arg11: u128, arg12: u128) {
        let v0 = Rebalanced{
            pool_id             : arg0,
            old_position_id     : arg1,
            new_position_id     : arg2,
            old_amount_x        : arg3,
            old_amount_y        : arg4,
            new_amount_x        : arg5,
            new_amount_y        : arg6,
            old_lower_tick_bits : arg7,
            old_upper_tick_bits : arg8,
            new_lower_tick_bits : arg9,
            new_upper_tick_bits : arg10,
            old_liquidity       : arg11,
            new_liquidity       : arg12,
        };
        0x2::event::emit<Rebalanced>(v0);
    }

    public(friend) fun emit_zapped_in(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u64) {
        let v0 = ZappedIn{
            pool_id     : arg0,
            position_id : arg1,
            amount_x    : arg2,
            amount_y    : arg3,
        };
        0x2::event::emit<ZappedIn>(v0);
    }

    public fun fee_pips(arg0: &SwapState) : u64 {
        arg0.fee_pips
    }

    public(friend) fun init_swap_state(arg0: u128, arg1: u128, arg2: 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::I32, arg3: u64, arg4: u64, arg5: u64, arg6: u32, arg7: u128, arg8: u128) : SwapState {
        SwapState{
            liquidity            : arg0,
            sqrt_price_x64       : arg1,
            tick                 : arg2,
            amount_x_desired     : arg3,
            amount_y_desired     : arg4,
            sqrt_ratio_lower_x64 : arg7,
            sqrt_ratio_upper_x64 : arg8,
            fee_pips             : arg5,
            tick_spacing         : arg6,
        }
    }

    public(friend) fun is_x2y(arg0: u64, arg1: u64, arg2: u128, arg3: u128, arg4: u128) : bool {
        if (arg2 <= arg3) {
            return false
        };
        if (arg2 >= arg4) {
            return true
        };
        is_x2y_in_range(arg0, arg1, arg2, arg3, arg4)
    }

    fun is_x2y_in_range(arg0: u64, arg1: u64, arg2: u128, arg3: u128, arg4: u128) : bool {
        ((arg0 as u256) * (arg2 as u256) >> 64) * ((arg2 - arg3) as u256) >> 64 > (arg1 as u256) * ((arg4 - arg2) as u256) >> 64
    }

    public fun liquidity(arg0: &SwapState) : u128 {
        arg0.liquidity
    }

    public(friend) fun solve_optimal_one_for_zero(arg0: &SwapState) : u128 {
        let v0 = arg0.amount_y_desired;
        let v1 = arg0.liquidity;
        let v2 = arg0.sqrt_price_x64;
        let v3 = arg0.sqrt_ratio_lower_x64;
        let v4 = arg0.sqrt_ratio_upper_x64;
        let v5 = arg0.fee_pips;
        let v6 = 1000000 - v5;
        let v7 = (v1 as u256) << 64;
        let v8 = (arg0.amount_x_desired as u128) + ((v7 / (v2 as u256)) as u128);
        let v9 = (v0 as u256) + ((v1 as u256) * (0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::full_math_u128::mul_div_floor((1000000 as u128), v2, (v6 as u128)) as u256) >> 64);
        let v10 = v9 - ((v1 as u256) * (v3 as u256) >> 64);
        let v11 = if (v10 <= (18446744073709551615 as u256)) {
            if (v9 <= (18446744073709551615 as u256)) {
                v10 >= (v0 as u256)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v11, 1);
        let v12 = 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::sub(0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::sub(0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::from(v8 * v3), 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::from(0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::full_math_u128::mul_div_floor((v5 as u128), v1, (v6 as u128)))), 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::from((((v9 << 64) / (v4 as u256)) as u128)));
        let v13 = 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::shl(0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::sub(0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::from(v8), 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::from((((1000000 as u256) * v7 / (v6 as u256) * (v4 as u256)) as u128))), 1);
        let v14 = 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::add(0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::mul(v12, v12), 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::mul(0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::shl(v13, 1), 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::from((v10 as u128) << 1)));
        assert!(0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::gt(v14, 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::zero()), 1);
        let v15 = 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::div(0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::shl(0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::add(0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::from(0x1::u128::sqrt(0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::as_u128(v14))), v12), 64), v13);
        assert!(0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::gt(v15, 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::zero()), 1);
        let v16 = 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::as_u128(v15);
        if (v16 > v2) {
            v16
        } else {
            v2
        }
    }

    public(friend) fun solve_optimal_zero_for_one(arg0: &SwapState) : u128 {
        let v0 = arg0.amount_x_desired;
        let v1 = arg0.liquidity;
        let v2 = arg0.sqrt_price_x64;
        let v3 = arg0.sqrt_ratio_lower_x64;
        let v4 = arg0.sqrt_ratio_upper_x64;
        let v5 = arg0.fee_pips;
        let v6 = 1000000 - v5;
        let v7 = (v1 as u256) << 64;
        let v8 = (v0 as u256) + (1000000 as u256) * v7 / (v6 as u256) * (v2 as u256);
        let v9 = v8 - v7 / (v4 as u256);
        let v10 = if (v9 <= (18446744073709551615 as u256)) {
            if (v8 <= (18446744073709551615 as u256)) {
                v9 >= (v0 as u256)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v10, 1);
        let v11 = (arg0.amount_y_desired as u128) + (((v1 as u256) * (v2 as u256) >> 64) as u128);
        let v12 = 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::sub(0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::from(((v8 as u128) * v3 >> 64) + 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::full_math_u128::mul_div_floor((v5 as u128), v1, (v6 as u128))), 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::from(((((v11 as u256) << 64) / (v4 as u256)) as u128)));
        let v13 = (v9 as u128) << 1;
        let v14 = 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::add(0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::mul(v12, v12), 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::mul(0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::from(v13 << 1), 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::sub(0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::from(v11), 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::from((((v1 as u256) * (0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::full_math_u128::mul_div_floor((1000000 as u128), v3, (v6 as u128)) as u256) >> 64) as u128)))));
        assert!(0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::gt(v14, 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::zero()), 1);
        let v15 = 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::add(0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::from(0x1::u128::sqrt(0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::as_u128(v14))), v12);
        assert!(0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::gte(v15, 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::zero()), 1);
        let v16 = ((((0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::as_u128(v15) as u256) << 64) / (v13 as u256)) as u128);
        if (v16 < v2) {
            v16
        } else {
            v2
        }
    }

    public fun sqrt_price_x64(arg0: &SwapState) : u128 {
        arg0.sqrt_price_x64
    }

    public fun sqrt_ratio_lower_x64(arg0: &SwapState) : u128 {
        arg0.sqrt_ratio_lower_x64
    }

    public fun sqrt_ratio_upper_x64(arg0: &SwapState) : u128 {
        arg0.sqrt_ratio_upper_x64
    }

    public fun tick(arg0: &SwapState) : 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::I32 {
        arg0.tick
    }

    public fun tick_spacing(arg0: &SwapState) : u32 {
        arg0.tick_spacing
    }

    public(friend) fun update_swap_state(arg0: &mut SwapState, arg1: u128, arg2: u128, arg3: 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::I32, arg4: u64, arg5: u64) {
        arg0.liquidity = arg1;
        arg0.sqrt_price_x64 = arg2;
        arg0.tick = arg3;
        arg0.amount_x_desired = arg4;
        arg0.amount_y_desired = arg5;
    }

    // decompiled from Move bytecode v6
}

