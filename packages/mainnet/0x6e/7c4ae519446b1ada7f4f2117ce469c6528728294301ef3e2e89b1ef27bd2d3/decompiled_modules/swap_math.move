module 0x6e7c4ae519446b1ada7f4f2117ce469c6528728294301ef3e2e89b1ef27bd2d3::swap_math {
    fun cross_ticks<T0, T1>(arg0: &mut 0x3ca337d21eec0b0c55a53e941e8e47d86495cc6b1eb8633862698c8528daa2b8::state::SwapState, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: u128, arg3: bool) {
        loop {
            let (v0, _) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick_bitmap::next_initialized_tick_within_one_word(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::bitmap(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_tick_manager<T0, T1>(arg1)), 0x6e7c4ae519446b1ada7f4f2117ce469c6528728294301ef3e2e89b1ef27bd2d3::i32_utils::lib_to_mate(0x3ca337d21eec0b0c55a53e941e8e47d86495cc6b1eb8633862698c8528daa2b8::state::tick(arg0)), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_tick_spacing<T0, T1>(arg1), arg3);
            let v2 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick_math::get_sqrt_price_at_tick(v0);
            let (v3, v4) = if (arg3) {
                let (v5, v6, v7, _) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::clmm_math::compute_swap_step(0x3ca337d21eec0b0c55a53e941e8e47d86495cc6b1eb8633862698c8528daa2b8::state::sqrt_price(arg0), v2, 0x3ca337d21eec0b0c55a53e941e8e47d86495cc6b1eb8633862698c8528daa2b8::state::liquidity(arg0), 0x3ca337d21eec0b0c55a53e941e8e47d86495cc6b1eb8633862698c8528daa2b8::state::amount_x_desired(arg0), 0x3ca337d21eec0b0c55a53e941e8e47d86495cc6b1eb8633862698c8528daa2b8::state::fee_pips(arg0), true, true);
                arg2 = v7;
                (0x3ca337d21eec0b0c55a53e941e8e47d86495cc6b1eb8633862698c8528daa2b8::state::amount_x_desired(arg0) - v5, 0x3ca337d21eec0b0c55a53e941e8e47d86495cc6b1eb8633862698c8528daa2b8::state::amount_y_desired(arg0) + v6)
            } else {
                let (v9, v10, v11, _) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::clmm_math::compute_swap_step(0x3ca337d21eec0b0c55a53e941e8e47d86495cc6b1eb8633862698c8528daa2b8::state::sqrt_price(arg0), v2, 0x3ca337d21eec0b0c55a53e941e8e47d86495cc6b1eb8633862698c8528daa2b8::state::liquidity(arg0), 0x3ca337d21eec0b0c55a53e941e8e47d86495cc6b1eb8633862698c8528daa2b8::state::amount_y_desired(arg0), 0x3ca337d21eec0b0c55a53e941e8e47d86495cc6b1eb8633862698c8528daa2b8::state::fee_pips(arg0), false, true);
                arg2 = v11;
                (0x3ca337d21eec0b0c55a53e941e8e47d86495cc6b1eb8633862698c8528daa2b8::state::amount_x_desired(arg0) + v10, 0x3ca337d21eec0b0c55a53e941e8e47d86495cc6b1eb8633862698c8528daa2b8::state::amount_y_desired(arg0) - v9)
            };
            if (arg2 != v2) {
                break
            };
            if (0x3ca337d21eec0b0c55a53e941e8e47d86495cc6b1eb8633862698c8528daa2b8::math::is_zero_for_one((v3 as u256), (v4 as u256), (arg2 as u256), (0x3ca337d21eec0b0c55a53e941e8e47d86495cc6b1eb8633862698c8528daa2b8::state::sqrt_ratio_lower(arg0) as u256), (0x3ca337d21eec0b0c55a53e941e8e47d86495cc6b1eb8633862698c8528daa2b8::state::sqrt_ratio_upper(arg0) as u256)) != arg3) {
                break
            };
            let v13 = 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::from_u128(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i128::as_u128(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::liquidity_net(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::get_tick_from_manager(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_tick_manager<T0, T1>(arg1), v0))));
            let v14 = v13;
            if (arg3) {
                v14 = 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::neg(v13);
            };
            let v15 = if (0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::is_neg(v14)) {
                0x3ca337d21eec0b0c55a53e941e8e47d86495cc6b1eb8633862698c8528daa2b8::state::liquidity(arg0) - 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::abs_u128(v14)
            } else {
                0x3ca337d21eec0b0c55a53e941e8e47d86495cc6b1eb8633862698c8528daa2b8::state::liquidity(arg0) + 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::abs_u128(v14)
            };
            let v16 = if (arg3) {
                1
            } else {
                0
            };
            0x3ca337d21eec0b0c55a53e941e8e47d86495cc6b1eb8633862698c8528daa2b8::state::update_swap_state(arg0, v15, arg2, 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::sub(0x6e7c4ae519446b1ada7f4f2117ce469c6528728294301ef3e2e89b1ef27bd2d3::i32_utils::mate_to_lib(v0), 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::from(v16)), v3, v4);
        };
    }

    public(friend) fun optimal_swap<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: u32, arg2: u32, arg3: u64, arg4: u64) : (u64, u64, bool, u128) {
        assert!(arg3 > 0 || arg4 > 0, 0);
        let v0 = 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::from_u32(arg1);
        let v1 = 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::from_u32(arg2);
        let v2 = if (0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::lt(v0, v1)) {
            if (0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::gte(v0, 0x6e7c4ae519446b1ada7f4f2117ce469c6528728294301ef3e2e89b1ef27bd2d3::i32_utils::mate_to_lib(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick_math::min_tick()))) {
                0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::lte(v1, 0x6e7c4ae519446b1ada7f4f2117ce469c6528728294301ef3e2e89b1ef27bd2d3::i32_utils::mate_to_lib(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick_math::max_tick()))
            } else {
                false
            }
        } else {
            false
        };
        assert!(v2, 1);
        let v3 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg0);
        let v4 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick_math::get_sqrt_price_at_tick(0x6e7c4ae519446b1ada7f4f2117ce469c6528728294301ef3e2e89b1ef27bd2d3::i32_utils::lib_to_mate(v0));
        let v5 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick_math::get_sqrt_price_at_tick(0x6e7c4ae519446b1ada7f4f2117ce469c6528728294301ef3e2e89b1ef27bd2d3::i32_utils::lib_to_mate(v1));
        let v6 = 0x3ca337d21eec0b0c55a53e941e8e47d86495cc6b1eb8633862698c8528daa2b8::state::init_swap_state(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::liquidity<T0, T1>(arg0), v3, 0x6e7c4ae519446b1ada7f4f2117ce469c6528728294301ef3e2e89b1ef27bd2d3::i32_utils::mate_to_lib(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg0)), arg3, arg4, v4, v5, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_fee_rate<T0, T1>(arg0));
        let v7 = 0x3ca337d21eec0b0c55a53e941e8e47d86495cc6b1eb8633862698c8528daa2b8::math::is_zero_for_one((arg3 as u256), (arg4 as u256), (v3 as u256), (v4 as u256), (v5 as u256));
        let v8 = &mut v6;
        cross_ticks<T0, T1>(v8, arg0, v3, v7);
        if (v7) {
            let (v13, v12) = if (0x3ca337d21eec0b0c55a53e941e8e47d86495cc6b1eb8633862698c8528daa2b8::state::sqrt_price(&v6) <= v5) {
                let v14 = 0x3ca337d21eec0b0c55a53e941e8e47d86495cc6b1eb8633862698c8528daa2b8::state::solve_zero_for_one(&v6);
                (arg3 + 0x3ca337d21eec0b0c55a53e941e8e47d86495cc6b1eb8633862698c8528daa2b8::constants::amount_before_fee(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::clmm_math::get_delta_a(v14, 0x3ca337d21eec0b0c55a53e941e8e47d86495cc6b1eb8633862698c8528daa2b8::state::sqrt_price(&v6), 0x3ca337d21eec0b0c55a53e941e8e47d86495cc6b1eb8633862698c8528daa2b8::state::liquidity(&v6), true), 0x3ca337d21eec0b0c55a53e941e8e47d86495cc6b1eb8633862698c8528daa2b8::state::fee_pips(&v6)) - 0x3ca337d21eec0b0c55a53e941e8e47d86495cc6b1eb8633862698c8528daa2b8::state::amount_x_desired(&v6), v14)
            } else {
                (arg3, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::clmm_math::get_next_sqrt_price_a_up(0x3ca337d21eec0b0c55a53e941e8e47d86495cc6b1eb8633862698c8528daa2b8::state::sqrt_price(&v6), 0x3ca337d21eec0b0c55a53e941e8e47d86495cc6b1eb8633862698c8528daa2b8::state::liquidity(&v6), 0x3ca337d21eec0b0c55a53e941e8e47d86495cc6b1eb8633862698c8528daa2b8::constants::amount_after_fee(0x3ca337d21eec0b0c55a53e941e8e47d86495cc6b1eb8633862698c8528daa2b8::state::amount_x_desired(&v6), 0x3ca337d21eec0b0c55a53e941e8e47d86495cc6b1eb8633862698c8528daa2b8::state::fee_pips(&v6)), true))
            };
            (v13, 0x3ca337d21eec0b0c55a53e941e8e47d86495cc6b1eb8633862698c8528daa2b8::state::amount_y_desired(&v6) + 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::clmm_math::get_delta_b(v12, 0x3ca337d21eec0b0c55a53e941e8e47d86495cc6b1eb8633862698c8528daa2b8::state::sqrt_price(&v6), 0x3ca337d21eec0b0c55a53e941e8e47d86495cc6b1eb8633862698c8528daa2b8::state::liquidity(&v6), false) - arg4, true, v12)
        } else {
            let (v15, v12) = if (0x3ca337d21eec0b0c55a53e941e8e47d86495cc6b1eb8633862698c8528daa2b8::state::sqrt_price(&v6) >= v4) {
                let v16 = 0x3ca337d21eec0b0c55a53e941e8e47d86495cc6b1eb8633862698c8528daa2b8::state::solve_one_for_zero(&v6);
                (arg4 + 0x3ca337d21eec0b0c55a53e941e8e47d86495cc6b1eb8633862698c8528daa2b8::constants::amount_before_fee(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::clmm_math::get_delta_b(v16, 0x3ca337d21eec0b0c55a53e941e8e47d86495cc6b1eb8633862698c8528daa2b8::state::sqrt_price(&v6), 0x3ca337d21eec0b0c55a53e941e8e47d86495cc6b1eb8633862698c8528daa2b8::state::liquidity(&v6), true), 0x3ca337d21eec0b0c55a53e941e8e47d86495cc6b1eb8633862698c8528daa2b8::state::fee_pips(&v6)) - 0x3ca337d21eec0b0c55a53e941e8e47d86495cc6b1eb8633862698c8528daa2b8::state::amount_y_desired(&v6), v16)
            } else {
                (arg4, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::clmm_math::get_next_sqrt_price_b_down(0x3ca337d21eec0b0c55a53e941e8e47d86495cc6b1eb8633862698c8528daa2b8::state::sqrt_price(&v6), 0x3ca337d21eec0b0c55a53e941e8e47d86495cc6b1eb8633862698c8528daa2b8::state::liquidity(&v6), 0x3ca337d21eec0b0c55a53e941e8e47d86495cc6b1eb8633862698c8528daa2b8::constants::amount_after_fee(0x3ca337d21eec0b0c55a53e941e8e47d86495cc6b1eb8633862698c8528daa2b8::state::amount_y_desired(&v6), 0x3ca337d21eec0b0c55a53e941e8e47d86495cc6b1eb8633862698c8528daa2b8::state::fee_pips(&v6)), true))
            };
            (v15, 0x3ca337d21eec0b0c55a53e941e8e47d86495cc6b1eb8633862698c8528daa2b8::state::amount_x_desired(&v6) + 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::clmm_math::get_delta_a(v12, 0x3ca337d21eec0b0c55a53e941e8e47d86495cc6b1eb8633862698c8528daa2b8::state::sqrt_price(&v6), 0x3ca337d21eec0b0c55a53e941e8e47d86495cc6b1eb8633862698c8528daa2b8::state::liquidity(&v6), false) - arg3, false, v12)
        }
    }

    // decompiled from Move bytecode v6
}

