module 0x6f48a1ba005f46fd0835fa3e077b7c8c46a0982cca9057658c6d75a9ae970ca0::swap_math {
    fun cross_ticks<T0, T1>(arg0: &mut 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::state::SwapState, arg1: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg2: bool) {
        let v0 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick::first_score_for_swap(0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::tick_manager<T0, T1>(arg1), 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::current_tick_index<T0, T1>(arg1), arg2);
        while (0x682eaba7450909645bf949db3fc5881432a00b49b4c06d6974ecc4ee684e7992::option_u64::is_some(&v0)) {
            let (v1, v2) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick::borrow_tick_for_swap(0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::tick_manager<T0, T1>(arg1), 0x682eaba7450909645bf949db3fc5881432a00b49b4c06d6974ecc4ee684e7992::option_u64::borrow(&v0), arg2);
            v0 = v2;
            let v3 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick::sqrt_price(v1);
            let v4 = if (arg2) {
                0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::state::amount_x_desired(arg0)
            } else {
                0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::state::amount_y_desired(arg0)
            };
            let (v5, v6, v7, v8) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::clmm_math::compute_swap_step(0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::state::sqrt_price(arg0), v3, 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::state::liquidity(arg0), v4, 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::state::fee_pips(arg0), arg2, true);
            let (v9, v10) = if (arg2) {
                (0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::state::amount_x_desired(arg0) - v5 - v8, 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::state::amount_y_desired(arg0) + v6)
            } else {
                (0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::state::amount_x_desired(arg0) + v6, 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::state::amount_y_desired(arg0) - v5 - v8)
            };
            if (v7 != v3) {
                break
            };
            if (0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::math::is_zero_for_one(v9, v10, v7, 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::state::sqrt_ratio_lower(arg0), 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::state::sqrt_ratio_upper(arg0)) != arg2) {
                break
            };
            let v11 = 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::from_u128(0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i128::as_u128(0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick::liquidity_net(v1)));
            let v12 = v11;
            if (arg2) {
                v12 = 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::neg(v11);
            };
            let v13 = if (0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::is_neg(v12)) {
                0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::state::liquidity(arg0) - 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::abs_u128(v12)
            } else {
                0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::state::liquidity(arg0) + 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::abs_u128(v12)
            };
            let v14 = if (arg2) {
                1
            } else {
                0
            };
            0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::state::update_swap_state(arg0, v13, v7, 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::sub(0x6f48a1ba005f46fd0835fa3e077b7c8c46a0982cca9057658c6d75a9ae970ca0::i32_utils::mate_to_lib(0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick::index(v1)), 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::from(v14)), v9, v10);
        };
    }

    public(friend) fun optimal_swap<T0, T1>(arg0: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg1: u32, arg2: u32, arg3: u64, arg4: u64) : (u64, u64, bool, u128) {
        assert!(arg3 > 0 || arg4 > 0, 0);
        let v0 = 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::from_u32(arg1);
        let v1 = 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::from_u32(arg2);
        let v2 = if (0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::lt(v0, v1)) {
            if (0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::gte(v0, 0x6f48a1ba005f46fd0835fa3e077b7c8c46a0982cca9057658c6d75a9ae970ca0::i32_utils::mate_to_lib(0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick_math::min_tick()))) {
                0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::lte(v1, 0x6f48a1ba005f46fd0835fa3e077b7c8c46a0982cca9057658c6d75a9ae970ca0::i32_utils::mate_to_lib(0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick_math::max_tick()))
            } else {
                false
            }
        } else {
            false
        };
        assert!(v2, 1);
        let v3 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::current_sqrt_price<T0, T1>(arg0);
        let v4 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick_math::get_sqrt_price_at_tick(0x6f48a1ba005f46fd0835fa3e077b7c8c46a0982cca9057658c6d75a9ae970ca0::i32_utils::lib_to_mate(v0));
        let v5 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick_math::get_sqrt_price_at_tick(0x6f48a1ba005f46fd0835fa3e077b7c8c46a0982cca9057658c6d75a9ae970ca0::i32_utils::lib_to_mate(v1));
        let v6 = 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::state::init_swap_state(0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::liquidity<T0, T1>(arg0), v3, 0x6f48a1ba005f46fd0835fa3e077b7c8c46a0982cca9057658c6d75a9ae970ca0::i32_utils::mate_to_lib(0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::current_tick_index<T0, T1>(arg0)), arg3, arg4, v4, v5, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::fee_rate<T0, T1>(arg0));
        let v7 = 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::math::is_zero_for_one(arg3, arg4, v3, v4, v5);
        let v8 = &mut v6;
        cross_ticks<T0, T1>(v8, arg0, v7);
        if (v7) {
            let (v13, v12) = if (0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::state::sqrt_price(&v6) <= v5) {
                let v14 = 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::state::solve_zero_for_one(&v6);
                (arg3 + 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::constants::amount_before_fee(0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::clmm_math::get_delta_a(v14, 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::state::sqrt_price(&v6), 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::state::liquidity(&v6), true), 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::state::fee_pips(&v6)) - 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::state::amount_x_desired(&v6), v14)
            } else {
                (arg3, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::clmm_math::get_next_sqrt_price_a_up(0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::state::sqrt_price(&v6), 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::state::liquidity(&v6), 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::constants::amount_after_fee(0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::state::amount_x_desired(&v6), 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::state::fee_pips(&v6)), true))
            };
            (v13, 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::state::amount_y_desired(&v6) + 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::clmm_math::get_delta_b(v12, 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::state::sqrt_price(&v6), 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::state::liquidity(&v6), false) - arg4, true, v12)
        } else {
            let (v15, v12) = if (0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::state::sqrt_price(&v6) >= v4) {
                let v16 = 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::state::solve_one_for_zero(&v6);
                (arg4 + 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::constants::amount_before_fee(0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::clmm_math::get_delta_b(v16, 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::state::sqrt_price(&v6), 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::state::liquidity(&v6), true), 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::state::fee_pips(&v6)) - 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::state::amount_y_desired(&v6), v16)
            } else {
                (arg4, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::clmm_math::get_next_sqrt_price_b_down(0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::state::sqrt_price(&v6), 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::state::liquidity(&v6), 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::constants::amount_after_fee(0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::state::amount_y_desired(&v6), 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::state::fee_pips(&v6)), true))
            };
            (v15, 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::state::amount_x_desired(&v6) + 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::clmm_math::get_delta_a(v12, 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::state::sqrt_price(&v6), 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::state::liquidity(&v6), false) - arg3, false, v12)
        }
    }

    // decompiled from Move bytecode v6
}

