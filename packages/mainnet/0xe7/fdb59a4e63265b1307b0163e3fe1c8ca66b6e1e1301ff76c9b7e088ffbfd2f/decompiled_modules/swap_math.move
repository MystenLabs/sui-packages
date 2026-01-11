module 0xb5c8df67f800e4d5eff7179ea9dd85af30ff22c1422d45e8e56c05ea57133fb::swap_math {
    fun cross_ticks<T0, T1>(arg0: &mut 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::state::SwapState, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: bool) {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick::first_score_for_swap(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::tick_manager<T0, T1>(arg1), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg1), arg2);
        while (0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::is_some(&v0)) {
            let (v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick::borrow_tick_for_swap(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::tick_manager<T0, T1>(arg1), 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::borrow(&v0), arg2);
            v0 = v2;
            let v3 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick::sqrt_price(v1);
            let v4 = if (arg2) {
                0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::state::amount_x_desired(arg0)
            } else {
                0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::state::amount_y_desired(arg0)
            };
            let (v5, v6, v7, v8) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::compute_swap_step(0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::state::sqrt_price(arg0), v3, 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::state::liquidity(arg0), v4, 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::state::fee_pips(arg0), arg2, true);
            let (v9, v10) = if (arg2) {
                (0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::state::amount_x_desired(arg0) - v5 - v8, 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::state::amount_y_desired(arg0) + v6)
            } else {
                (0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::state::amount_x_desired(arg0) + v6, 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::state::amount_y_desired(arg0) - v5 - v8)
            };
            if (v7 != v3) {
                break
            };
            if (0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::math::is_zero_for_one(v9, v10, v7, 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::state::sqrt_ratio_lower(arg0), 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::state::sqrt_ratio_upper(arg0)) != arg2) {
                break
            };
            let v11 = 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::from_u128(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i128::as_u128(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick::liquidity_net(v1)));
            let v12 = v11;
            if (arg2) {
                v12 = 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::neg(v11);
            };
            let v13 = if (0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::is_neg(v12)) {
                0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::state::liquidity(arg0) - 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::abs_u128(v12)
            } else {
                0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::state::liquidity(arg0) + 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::abs_u128(v12)
            };
            let v14 = if (arg2) {
                1
            } else {
                0
            };
            0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::state::update_swap_state(arg0, v13, v7, 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::sub(0xb5c8df67f800e4d5eff7179ea9dd85af30ff22c1422d45e8e56c05ea57133fb::i32_utils::mate_to_lib(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick::index(v1)), 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::from(v14)), v9, v10);
        };
    }

    public(friend) fun optimal_swap<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: u32, arg2: u32, arg3: u64, arg4: u64) : (u64, u64, bool, u128) {
        assert!(arg3 > 0 || arg4 > 0, 0);
        let v0 = 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::from_u32(arg1);
        let v1 = 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::from_u32(arg2);
        let v2 = if (0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::lt(v0, v1)) {
            if (0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::gte(v0, 0xb5c8df67f800e4d5eff7179ea9dd85af30ff22c1422d45e8e56c05ea57133fb::i32_utils::mate_to_lib(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_tick()))) {
                0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::lte(v1, 0xb5c8df67f800e4d5eff7179ea9dd85af30ff22c1422d45e8e56c05ea57133fb::i32_utils::mate_to_lib(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_tick()))
            } else {
                false
            }
        } else {
            false
        };
        assert!(v2, 1);
        let v3 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg0);
        let v4 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(0xb5c8df67f800e4d5eff7179ea9dd85af30ff22c1422d45e8e56c05ea57133fb::i32_utils::lib_to_mate(v0));
        let v5 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(0xb5c8df67f800e4d5eff7179ea9dd85af30ff22c1422d45e8e56c05ea57133fb::i32_utils::lib_to_mate(v1));
        let v6 = 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::state::init_swap_state(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::liquidity<T0, T1>(arg0), v3, 0xb5c8df67f800e4d5eff7179ea9dd85af30ff22c1422d45e8e56c05ea57133fb::i32_utils::mate_to_lib(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg0)), arg3, arg4, v4, v5, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::fee_rate<T0, T1>(arg0));
        let v7 = 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::math::is_zero_for_one(arg3, arg4, v3, v4, v5);
        let v8 = &mut v6;
        cross_ticks<T0, T1>(v8, arg0, v7);
        if (v7) {
            let (v13, v12) = if (0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::state::sqrt_price(&v6) <= v5) {
                let v14 = 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::state::solve_zero_for_one(&v6);
                (arg3 + 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::constants::amount_before_fee(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_delta_a(v14, 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::state::sqrt_price(&v6), 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::state::liquidity(&v6), true), 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::state::fee_pips(&v6)) - 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::state::amount_x_desired(&v6), v14)
            } else {
                (arg3, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_next_sqrt_price_a_up(0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::state::sqrt_price(&v6), 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::state::liquidity(&v6), 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::constants::amount_after_fee(0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::state::amount_x_desired(&v6), 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::state::fee_pips(&v6)), true))
            };
            (v13, 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::state::amount_y_desired(&v6) + 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_delta_b(v12, 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::state::sqrt_price(&v6), 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::state::liquidity(&v6), false) - arg4, true, v12)
        } else {
            let (v15, v12) = if (0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::state::sqrt_price(&v6) >= v4) {
                let v16 = 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::state::solve_one_for_zero(&v6);
                (arg4 + 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::constants::amount_before_fee(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_delta_b(v16, 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::state::sqrt_price(&v6), 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::state::liquidity(&v6), true), 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::state::fee_pips(&v6)) - 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::state::amount_y_desired(&v6), v16)
            } else {
                (arg4, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_next_sqrt_price_b_down(0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::state::sqrt_price(&v6), 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::state::liquidity(&v6), 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::constants::amount_after_fee(0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::state::amount_y_desired(&v6), 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::state::fee_pips(&v6)), true))
            };
            (v15, 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::state::amount_x_desired(&v6) + 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_delta_a(v12, 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::state::sqrt_price(&v6), 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::state::liquidity(&v6), false) - arg3, false, v12)
        }
    }

    // decompiled from Move bytecode v6
}

