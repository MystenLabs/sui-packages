module 0x3162b7c67bf3196b4182d09d3cd54d02b8f0e06939ce9aa8407a445ac9a44a27::swap_math {
    fun cross_ticks<T0, T1>(arg0: &mut 0x639459138d90b1ceee644caf5b8029efa6460f6dffa281fd931c9ad6ad050279::state::SwapState, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: u128, arg3: bool) {
        let v0 = 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::neg_from(32768);
        let v1 = 0;
        loop {
            let (v2, v3, v4) = 0x3162b7c67bf3196b4182d09d3cd54d02b8f0e06939ce9aa8407a445ac9a44a27::tick_math::next_initialized_tick(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::bitmap(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_tick_manager<T0, T1>(arg1)), 0x639459138d90b1ceee644caf5b8029efa6460f6dffa281fd931c9ad6ad050279::state::tick(arg0), 0x639459138d90b1ceee644caf5b8029efa6460f6dffa281fd931c9ad6ad050279::state::tick_spacing(arg0), arg3, v0, v1);
            v1 = v4;
            v0 = v3;
            let v5 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick_math::get_sqrt_price_at_tick(0x3162b7c67bf3196b4182d09d3cd54d02b8f0e06939ce9aa8407a445ac9a44a27::i32_utils::lib_to_mate(v2));
            let (v6, v7) = if (arg3) {
                let (v8, v9, v10, _) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::clmm_math::compute_swap_step(0x639459138d90b1ceee644caf5b8029efa6460f6dffa281fd931c9ad6ad050279::state::sqrt_price(arg0), v5, 0x639459138d90b1ceee644caf5b8029efa6460f6dffa281fd931c9ad6ad050279::state::liquidity(arg0), 0x639459138d90b1ceee644caf5b8029efa6460f6dffa281fd931c9ad6ad050279::state::amount_x_desired(arg0), 0x639459138d90b1ceee644caf5b8029efa6460f6dffa281fd931c9ad6ad050279::state::fee_pips(arg0), true, true);
                arg2 = v10;
                (0x639459138d90b1ceee644caf5b8029efa6460f6dffa281fd931c9ad6ad050279::state::amount_x_desired(arg0) - v8, 0x639459138d90b1ceee644caf5b8029efa6460f6dffa281fd931c9ad6ad050279::state::amount_y_desired(arg0) + v9)
            } else {
                let (v12, v13, v14, _) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::clmm_math::compute_swap_step(0x639459138d90b1ceee644caf5b8029efa6460f6dffa281fd931c9ad6ad050279::state::sqrt_price(arg0), v5, 0x639459138d90b1ceee644caf5b8029efa6460f6dffa281fd931c9ad6ad050279::state::liquidity(arg0), 0x639459138d90b1ceee644caf5b8029efa6460f6dffa281fd931c9ad6ad050279::state::amount_y_desired(arg0), 0x639459138d90b1ceee644caf5b8029efa6460f6dffa281fd931c9ad6ad050279::state::fee_pips(arg0), false, true);
                arg2 = v14;
                (0x639459138d90b1ceee644caf5b8029efa6460f6dffa281fd931c9ad6ad050279::state::amount_x_desired(arg0) + v13, 0x639459138d90b1ceee644caf5b8029efa6460f6dffa281fd931c9ad6ad050279::state::amount_y_desired(arg0) - v12)
            };
            if (arg2 != v5) {
                break
            };
            if (0x639459138d90b1ceee644caf5b8029efa6460f6dffa281fd931c9ad6ad050279::math::is_zero_for_one((v6 as u256), (v7 as u256), (arg2 as u256), (0x639459138d90b1ceee644caf5b8029efa6460f6dffa281fd931c9ad6ad050279::state::sqrt_ratio_lower(arg0) as u256), (0x639459138d90b1ceee644caf5b8029efa6460f6dffa281fd931c9ad6ad050279::state::sqrt_ratio_upper(arg0) as u256)) != arg3) {
                break
            };
            let v16 = 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::from_u128(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i128::as_u128(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::liquidity_net(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::get_tick_from_manager(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_tick_manager<T0, T1>(arg1), 0x3162b7c67bf3196b4182d09d3cd54d02b8f0e06939ce9aa8407a445ac9a44a27::i32_utils::lib_to_mate(v2)))));
            let v17 = v16;
            if (arg3) {
                v17 = 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::sub(0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::zero(), v16);
            };
            let v18 = if (arg3) {
                1
            } else {
                0
            };
            0x639459138d90b1ceee644caf5b8029efa6460f6dffa281fd931c9ad6ad050279::state::update_swap_state(arg0, v17, (arg2 as u256), 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::sub(v2, 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::from(v18)), (v6 as u256), (v7 as u256));
        };
    }

    public(friend) fun optimal_swap<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: u32, arg2: u32, arg3: u64, arg4: u64) : (u64, u64, bool, u128) {
        if (arg3 == 0 && arg4 == 0) {
            return (0, 0, false, 0)
        };
        let v0 = 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::from_u32(arg1);
        let v1 = 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::from_u32(arg2);
        let v2 = if (0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::lt(v0, v1)) {
            if (0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::gte(v0, 0x3162b7c67bf3196b4182d09d3cd54d02b8f0e06939ce9aa8407a445ac9a44a27::i32_utils::mate_to_lib(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick_math::min_tick()))) {
                0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::lte(v1, 0x3162b7c67bf3196b4182d09d3cd54d02b8f0e06939ce9aa8407a445ac9a44a27::i32_utils::mate_to_lib(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick_math::max_tick()))
            } else {
                false
            }
        } else {
            false
        };
        assert!(v2, 0);
        let v3 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg0);
        let v4 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick_math::get_sqrt_price_at_tick(0x3162b7c67bf3196b4182d09d3cd54d02b8f0e06939ce9aa8407a445ac9a44a27::i32_utils::lib_to_mate(v0));
        let v5 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick_math::get_sqrt_price_at_tick(0x3162b7c67bf3196b4182d09d3cd54d02b8f0e06939ce9aa8407a445ac9a44a27::i32_utils::lib_to_mate(v1));
        let v6 = 0x639459138d90b1ceee644caf5b8029efa6460f6dffa281fd931c9ad6ad050279::state::init_swap_state(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::liquidity<T0, T1>(arg0), v3, 0x3162b7c67bf3196b4182d09d3cd54d02b8f0e06939ce9aa8407a445ac9a44a27::i32_utils::mate_to_lib(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg0)), arg3, arg4, v4, v5, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_fee_rate<T0, T1>(arg0), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_tick_spacing<T0, T1>(arg0));
        let v7 = 0x639459138d90b1ceee644caf5b8029efa6460f6dffa281fd931c9ad6ad050279::math::is_zero_for_one((arg3 as u256), (arg4 as u256), (v3 as u256), (v4 as u256), (v5 as u256));
        let v8 = &mut v6;
        cross_ticks<T0, T1>(v8, arg0, v3, v7);
        let (v9, v10, v11, v12) = if (v7) {
            let (v11, v12) = if (0x639459138d90b1ceee644caf5b8029efa6460f6dffa281fd931c9ad6ad050279::state::sqrt_price(&v6) <= v5) {
                let v13 = (0x639459138d90b1ceee644caf5b8029efa6460f6dffa281fd931c9ad6ad050279::state::solve_zero_for_one(&v6) as u128);
                (arg3 + 0x639459138d90b1ceee644caf5b8029efa6460f6dffa281fd931c9ad6ad050279::constants::amount_before_fee(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::clmm_math::get_delta_a(v13, 0x639459138d90b1ceee644caf5b8029efa6460f6dffa281fd931c9ad6ad050279::state::sqrt_price(&v6), 0x639459138d90b1ceee644caf5b8029efa6460f6dffa281fd931c9ad6ad050279::state::liquidity(&v6), true), 0x639459138d90b1ceee644caf5b8029efa6460f6dffa281fd931c9ad6ad050279::state::fee_pips(&v6)) - 0x639459138d90b1ceee644caf5b8029efa6460f6dffa281fd931c9ad6ad050279::state::amount_x_desired(&v6), v13)
            } else {
                (arg3, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::clmm_math::get_next_sqrt_price_a_up(0x639459138d90b1ceee644caf5b8029efa6460f6dffa281fd931c9ad6ad050279::state::sqrt_price(&v6), 0x639459138d90b1ceee644caf5b8029efa6460f6dffa281fd931c9ad6ad050279::state::liquidity(&v6), 0x639459138d90b1ceee644caf5b8029efa6460f6dffa281fd931c9ad6ad050279::constants::amount_after_fee(0x639459138d90b1ceee644caf5b8029efa6460f6dffa281fd931c9ad6ad050279::state::amount_x_desired(&v6), 0x639459138d90b1ceee644caf5b8029efa6460f6dffa281fd931c9ad6ad050279::state::fee_pips(&v6)), true))
            };
            (0x639459138d90b1ceee644caf5b8029efa6460f6dffa281fd931c9ad6ad050279::state::amount_y_desired(&v6) + 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::clmm_math::get_delta_b(v12, 0x639459138d90b1ceee644caf5b8029efa6460f6dffa281fd931c9ad6ad050279::state::sqrt_price(&v6), 0x639459138d90b1ceee644caf5b8029efa6460f6dffa281fd931c9ad6ad050279::state::liquidity(&v6), false) - arg4, true, v11, v12)
        } else {
            let (v11, v12) = if (0x639459138d90b1ceee644caf5b8029efa6460f6dffa281fd931c9ad6ad050279::state::sqrt_price(&v6) >= v4) {
                let v14 = (0x639459138d90b1ceee644caf5b8029efa6460f6dffa281fd931c9ad6ad050279::state::solve_one_for_zero(&v6) as u128);
                (arg4 + 0x639459138d90b1ceee644caf5b8029efa6460f6dffa281fd931c9ad6ad050279::constants::amount_before_fee(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::clmm_math::get_delta_b(0x639459138d90b1ceee644caf5b8029efa6460f6dffa281fd931c9ad6ad050279::state::sqrt_price(&v6), v14, 0x639459138d90b1ceee644caf5b8029efa6460f6dffa281fd931c9ad6ad050279::state::liquidity(&v6), true), 0x639459138d90b1ceee644caf5b8029efa6460f6dffa281fd931c9ad6ad050279::state::fee_pips(&v6)) - 0x639459138d90b1ceee644caf5b8029efa6460f6dffa281fd931c9ad6ad050279::state::amount_y_desired(&v6), v14)
            } else {
                (arg4, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::clmm_math::get_next_sqrt_price_b_down(0x639459138d90b1ceee644caf5b8029efa6460f6dffa281fd931c9ad6ad050279::state::sqrt_price(&v6), 0x639459138d90b1ceee644caf5b8029efa6460f6dffa281fd931c9ad6ad050279::state::liquidity(&v6), 0x639459138d90b1ceee644caf5b8029efa6460f6dffa281fd931c9ad6ad050279::constants::amount_after_fee(0x639459138d90b1ceee644caf5b8029efa6460f6dffa281fd931c9ad6ad050279::state::amount_y_desired(&v6), 0x639459138d90b1ceee644caf5b8029efa6460f6dffa281fd931c9ad6ad050279::state::fee_pips(&v6)), true))
            };
            (0x639459138d90b1ceee644caf5b8029efa6460f6dffa281fd931c9ad6ad050279::state::amount_x_desired(&v6) + 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::clmm_math::get_delta_a(0x639459138d90b1ceee644caf5b8029efa6460f6dffa281fd931c9ad6ad050279::state::sqrt_price(&v6), v12, 0x639459138d90b1ceee644caf5b8029efa6460f6dffa281fd931c9ad6ad050279::state::liquidity(&v6), false) - arg3, false, v11, v12)
        };
        (v11, v9, v10, v12)
    }

    // decompiled from Move bytecode v6
}

