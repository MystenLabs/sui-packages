module 0x4aa7f377d4f61b9b8720d70634e15f7d34953ea7eb7986f50464c9d2231e950a::swap_math {
    fun cross_ticks<T0, T1, T2>(arg0: &mut 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::state::SwapState, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: bool) {
        loop {
            let (v0, _) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::next_initialized_tick_within_one_word<T0, T1, T2>(arg1, 0x4aa7f377d4f61b9b8720d70634e15f7d34953ea7eb7986f50464c9d2231e950a::i32_utils::lib_to_mate(0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::state::tick(arg0)), arg2);
            let v2 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_tick::sqrt_price_from_tick_index(v0);
            let v3 = if (arg2) {
                0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::state::amount_x_desired(arg0)
            } else {
                0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::state::amount_y_desired(arg0)
            };
            let (v4, v5, v6, v7) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_swap::compute_swap(0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::state::sqrt_price(arg0), v2, 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::state::liquidity(arg0), (v3 as u128), true, (0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::state::fee_pips(arg0) as u32));
            let (v8, v9) = if (arg2) {
                (0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::state::amount_x_desired(arg0) - (v5 as u64) - (v7 as u64), 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::state::amount_y_desired(arg0) + (v6 as u64))
            } else {
                (0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::state::amount_x_desired(arg0) + (v6 as u64), 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::state::amount_y_desired(arg0) - (v5 as u64) - (v7 as u64))
            };
            if (v4 != v2) {
                break
            };
            if (0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::math::is_zero_for_one(v8, v9, v4, 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::state::sqrt_ratio_lower(arg0), 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::state::sqrt_ratio_upper(arg0)) != arg2) {
                break
            };
            let v10 = 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::from_u128(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i128::as_u128(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_tick_liquidity_net(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_tick<T0, T1, T2>(arg1, v0))));
            let v11 = v10;
            if (arg2) {
                v11 = 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::neg(v10);
            };
            let v12 = if (0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::is_neg(v11)) {
                0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::state::liquidity(arg0) - 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::abs_u128(v11)
            } else {
                0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::state::liquidity(arg0) + 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::abs_u128(v11)
            };
            let v13 = if (arg2) {
                1
            } else {
                0
            };
            0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::state::update_swap_state(arg0, v12, v4, 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::sub(0x4aa7f377d4f61b9b8720d70634e15f7d34953ea7eb7986f50464c9d2231e950a::i32_utils::mate_to_lib(v0), 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::from(v13)), v8, v9);
        };
    }

    public(friend) fun optimal_swap<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: u32, arg2: u32, arg3: u64, arg4: u64) : (u64, u64, bool, u128) {
        assert!(arg3 > 0 || arg4 > 0, 0);
        let v0 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_tick_spacing<T0, T1, T2>(arg0);
        let v1 = 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::from_u32(arg1);
        let v2 = 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::from_u32(arg2);
        let v3 = if (0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::lt(v1, v2)) {
            if (0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::gte(v1, 0x4aa7f377d4f61b9b8720d70634e15f7d34953ea7eb7986f50464c9d2231e950a::i32_utils::mate_to_lib(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_tick::get_min_tick(v0)))) {
                0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::lte(v2, 0x4aa7f377d4f61b9b8720d70634e15f7d34953ea7eb7986f50464c9d2231e950a::i32_utils::mate_to_lib(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_tick::get_max_tick(v0)))
            } else {
                false
            }
        } else {
            false
        };
        assert!(v3, 1);
        let v4 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<T0, T1, T2>(arg0);
        let v5 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_tick::sqrt_price_from_tick_index(0x4aa7f377d4f61b9b8720d70634e15f7d34953ea7eb7986f50464c9d2231e950a::i32_utils::lib_to_mate(v1));
        let v6 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_tick::sqrt_price_from_tick_index(0x4aa7f377d4f61b9b8720d70634e15f7d34953ea7eb7986f50464c9d2231e950a::i32_utils::lib_to_mate(v2));
        let v7 = 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::state::init_swap_state(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_liquidity<T0, T1, T2>(arg0), v4, 0x4aa7f377d4f61b9b8720d70634e15f7d34953ea7eb7986f50464c9d2231e950a::i32_utils::mate_to_lib(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_current_index<T0, T1, T2>(arg0)), arg3, arg4, v5, v6, (0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_fee<T0, T1, T2>(arg0) as u64));
        let v8 = 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::math::is_zero_for_one(arg3, arg4, v4, v5, v6);
        let v9 = &mut v7;
        cross_ticks<T0, T1, T2>(v9, arg0, v8);
        if (v8) {
            let (v14, v13) = if (0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::state::sqrt_price(&v7) <= v6) {
                let v15 = 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::state::solve_zero_for_one(&v7);
                (arg3 + 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::constants::amount_before_fee((0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_sqrt_price::get_amount_a_delta_(v15, 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::state::sqrt_price(&v7), 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::state::liquidity(&v7), true) as u64), 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::state::fee_pips(&v7)) - 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::state::amount_x_desired(&v7), v15)
            } else {
                (arg3, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_sqrt_price::get_next_sqrt_price(0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::state::sqrt_price(&v7), 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::state::liquidity(&v7), (0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::constants::amount_after_fee(0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::state::amount_x_desired(&v7), 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::state::fee_pips(&v7)) as u128), true, true))
            };
            (v14, 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::state::amount_y_desired(&v7) + (0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_sqrt_price::get_amount_b_delta_(v13, 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::state::sqrt_price(&v7), 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::state::liquidity(&v7), false) as u64) - arg4, true, v13)
        } else {
            let (v16, v13) = if (0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::state::sqrt_price(&v7) >= v5) {
                let v17 = 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::state::solve_one_for_zero(&v7);
                (arg4 + 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::constants::amount_before_fee((0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_sqrt_price::get_amount_b_delta_(v17, 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::state::sqrt_price(&v7), 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::state::liquidity(&v7), true) as u64), 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::state::fee_pips(&v7)) - 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::state::amount_y_desired(&v7), v17)
            } else {
                (arg4, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_sqrt_price::get_next_sqrt_price(0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::state::sqrt_price(&v7), 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::state::liquidity(&v7), (0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::constants::amount_after_fee(0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::state::amount_y_desired(&v7), 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::state::fee_pips(&v7)) as u128), true, false))
            };
            (v16, 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::state::amount_x_desired(&v7) + (0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_sqrt_price::get_amount_a_delta_(v13, 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::state::sqrt_price(&v7), 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::state::liquidity(&v7), false) as u64) - arg3, false, v13)
        }
    }

    // decompiled from Move bytecode v6
}

