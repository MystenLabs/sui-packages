module 0x84a045ff30c196b731676ff9992e7b6aa9d89e0d6f08a60691e8afd082242f5b::bluefin {
    fun position(arg0: 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::I32) : (0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::I32, u8) {
        (0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::shr(arg0, 8), ((0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::as_u32(arg0) & 255) as u8))
    }

    fun compress(arg0: 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::I32, arg1: u32) : 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::I32 {
        let v0 = 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::div(arg0, 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::from(arg1));
        let v1 = v0;
        if (0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::is_neg(arg0) && 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::mod(arg0, 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::from(arg1)) != 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::zero()) {
            v1 = 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::sub(v0, 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::from(1));
        };
        v1
    }

    public(friend) fun cross_ticks<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: &mut 0x84a045ff30c196b731676ff9992e7b6aa9d89e0d6f08a60691e8afd082242f5b::clmm::SwapState, arg2: u128, arg3: bool) {
        let v0 = 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::neg_from(32768);
        let v1 = 0;
        loop {
            let (v2, v3, v4) = next_initialized_tick(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::bitmap(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_tick_manager<T0, T1>(arg0)), 0x84a045ff30c196b731676ff9992e7b6aa9d89e0d6f08a60691e8afd082242f5b::clmm::tick(arg1), 0x84a045ff30c196b731676ff9992e7b6aa9d89e0d6f08a60691e8afd082242f5b::clmm::tick_spacing(arg1), arg3, v0, v1);
            v1 = v4;
            v0 = v3;
            let v5 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(0x84a045ff30c196b731676ff9992e7b6aa9d89e0d6f08a60691e8afd082242f5b::i32::lib_to_mate(v2));
            let (v6, v7) = if (arg3) {
                let (v8, v9, v10, _) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::compute_swap_step(0x84a045ff30c196b731676ff9992e7b6aa9d89e0d6f08a60691e8afd082242f5b::clmm::sqrt_price_x64(arg1), v5, 0x84a045ff30c196b731676ff9992e7b6aa9d89e0d6f08a60691e8afd082242f5b::clmm::liquidity(arg1), 0x84a045ff30c196b731676ff9992e7b6aa9d89e0d6f08a60691e8afd082242f5b::clmm::amount_x_desired(arg1), 0x84a045ff30c196b731676ff9992e7b6aa9d89e0d6f08a60691e8afd082242f5b::clmm::fee_pips(arg1), true, true);
                arg2 = v10;
                (0x84a045ff30c196b731676ff9992e7b6aa9d89e0d6f08a60691e8afd082242f5b::clmm::amount_x_desired(arg1) - v8, 0x84a045ff30c196b731676ff9992e7b6aa9d89e0d6f08a60691e8afd082242f5b::clmm::amount_y_desired(arg1) + v9)
            } else {
                let (v12, v13, v14, _) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::compute_swap_step(0x84a045ff30c196b731676ff9992e7b6aa9d89e0d6f08a60691e8afd082242f5b::clmm::sqrt_price_x64(arg1), v5, 0x84a045ff30c196b731676ff9992e7b6aa9d89e0d6f08a60691e8afd082242f5b::clmm::liquidity(arg1), 0x84a045ff30c196b731676ff9992e7b6aa9d89e0d6f08a60691e8afd082242f5b::clmm::amount_y_desired(arg1), 0x84a045ff30c196b731676ff9992e7b6aa9d89e0d6f08a60691e8afd082242f5b::clmm::fee_pips(arg1), false, true);
                arg2 = v14;
                (0x84a045ff30c196b731676ff9992e7b6aa9d89e0d6f08a60691e8afd082242f5b::clmm::amount_x_desired(arg1) + v13, 0x84a045ff30c196b731676ff9992e7b6aa9d89e0d6f08a60691e8afd082242f5b::clmm::amount_y_desired(arg1) - v12)
            };
            if (arg2 != v5) {
                break
            };
            if (0x84a045ff30c196b731676ff9992e7b6aa9d89e0d6f08a60691e8afd082242f5b::clmm::is_x2y(v6, v7, arg2, 0x84a045ff30c196b731676ff9992e7b6aa9d89e0d6f08a60691e8afd082242f5b::clmm::sqrt_ratio_lower_x64(arg1), 0x84a045ff30c196b731676ff9992e7b6aa9d89e0d6f08a60691e8afd082242f5b::clmm::sqrt_ratio_upper_x64(arg1)) == arg3) {
                let v16 = 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::from_u128(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i128::as_u128(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::liquidity_net(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::get_tick_from_manager(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_tick_manager<T0, T1>(arg0), 0x84a045ff30c196b731676ff9992e7b6aa9d89e0d6f08a60691e8afd082242f5b::i32::lib_to_mate(v2)))));
                let v17 = v16;
                if (arg3) {
                    v17 = 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::sub(0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::zero(), v16);
                };
                let v18 = if (arg3) {
                    1
                } else {
                    0
                };
                0x84a045ff30c196b731676ff9992e7b6aa9d89e0d6f08a60691e8afd082242f5b::clmm::update_swap_state(arg1, 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::as_u128(v17), arg2, 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::sub(v2, 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::from(v18)), v6, v7);
            } else {
                break
            };
        };
    }

    fun next_initialized_tick(arg0: &0x2::table::Table<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, u256>, arg1: 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::I32, arg2: u32, arg3: bool, arg4: 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::I32, arg5: u256) : (0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::I32, 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::I32, u256) {
        let (v0, v1, v2) = if (arg3) {
            let (v3, v4) = position(compress(arg1, arg2));
            let v2 = v3;
            let v5 = if (v3 == arg4) {
                arg5
            } else {
                *0x2::table::borrow<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, u256>(arg0, 0x84a045ff30c196b731676ff9992e7b6aa9d89e0d6f08a60691e8afd082242f5b::i32::lib_to_mate(v3))
            };
            let v1 = v5;
            let v6 = v5 & (2 << v4) - 1;
            while (v6 == 0) {
                let v7 = 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::sub(v2, 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::from(1));
                v2 = v7;
                let v8 = *0x2::table::borrow<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, u256>(arg0, 0x84a045ff30c196b731676ff9992e7b6aa9d89e0d6f08a60691e8afd082242f5b::i32::lib_to_mate(v7));
                v1 = v8;
                v6 = v8;
            };
            (0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::bit_math::most_significant_bit(v6), v1, v2)
        } else {
            let (v9, v10) = position(0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::add(compress(arg1, arg2), 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::from(1)));
            let v2 = v9;
            let v11 = if (v9 == arg4) {
                arg5
            } else {
                *0x2::table::borrow<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, u256>(arg0, 0x84a045ff30c196b731676ff9992e7b6aa9d89e0d6f08a60691e8afd082242f5b::i32::lib_to_mate(v9))
            };
            let v1 = v11;
            let v12 = v11 & ((1 << v10) - 1 ^ 115792089237316195423570985008687907853269984665640564039457584007913129639935);
            while (v12 == 0) {
                let v13 = 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::add(v2, 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::from(1));
                v2 = v13;
                let v14 = *0x2::table::borrow<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, u256>(arg0, 0x84a045ff30c196b731676ff9992e7b6aa9d89e0d6f08a60691e8afd082242f5b::i32::lib_to_mate(v13));
                v1 = v14;
                v12 = v14;
            };
            (0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::bit_math::least_significant_bit(v12), v1, v2)
        };
        (0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::mul(0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::add(0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::shl(v2, 8), 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::from((v0 as u32))), 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::from(arg2)), v2, v1)
    }

    public fun optimal_swap<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: u32, arg2: u32, arg3: u64, arg4: u64) : (u64, u64, bool, u128) {
        assert!(arg3 > 0 || arg4 > 0, 3);
        let v0 = 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::from_u32(arg1);
        let v1 = 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::from_u32(arg2);
        let v2 = if (0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::lte(v0, v1)) {
            if (0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::gte(v0, 0x84a045ff30c196b731676ff9992e7b6aa9d89e0d6f08a60691e8afd082242f5b::i32::mate_to_lib(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_tick()))) {
                0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::lte(v1, 0x84a045ff30c196b731676ff9992e7b6aa9d89e0d6f08a60691e8afd082242f5b::i32::mate_to_lib(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_tick()))
            } else {
                false
            }
        } else {
            false
        };
        assert!(v2, 1);
        let v3 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg0);
        let v4 = 0x84a045ff30c196b731676ff9992e7b6aa9d89e0d6f08a60691e8afd082242f5b::clmm::init_swap_state(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::liquidity<T0, T1>(arg0), v3, 0x84a045ff30c196b731676ff9992e7b6aa9d89e0d6f08a60691e8afd082242f5b::i32::mate_to_lib(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg0)), arg3, arg4, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_fee_rate<T0, T1>(arg0), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_tick_spacing<T0, T1>(arg0), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(0x84a045ff30c196b731676ff9992e7b6aa9d89e0d6f08a60691e8afd082242f5b::i32::lib_to_mate(v0)), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(0x84a045ff30c196b731676ff9992e7b6aa9d89e0d6f08a60691e8afd082242f5b::i32::lib_to_mate(v1)));
        let v5 = 0x84a045ff30c196b731676ff9992e7b6aa9d89e0d6f08a60691e8afd082242f5b::clmm::is_x2y(arg3, arg4, v3, 0x84a045ff30c196b731676ff9992e7b6aa9d89e0d6f08a60691e8afd082242f5b::clmm::sqrt_ratio_lower_x64(&v4), 0x84a045ff30c196b731676ff9992e7b6aa9d89e0d6f08a60691e8afd082242f5b::clmm::sqrt_ratio_upper_x64(&v4));
        let v6 = &mut v4;
        cross_ticks<T0, T1>(arg0, v6, v3, v5);
        let v7 = 0x84a045ff30c196b731676ff9992e7b6aa9d89e0d6f08a60691e8afd082242f5b::clmm::liquidity(&v4);
        let v8 = 0x84a045ff30c196b731676ff9992e7b6aa9d89e0d6f08a60691e8afd082242f5b::clmm::sqrt_price_x64(&v4);
        let (v9, v10, v11) = if (v5) {
            let (v12, v11) = if (v8 <= 0x84a045ff30c196b731676ff9992e7b6aa9d89e0d6f08a60691e8afd082242f5b::clmm::sqrt_ratio_upper_x64(&v4)) {
                let v13 = 0x84a045ff30c196b731676ff9992e7b6aa9d89e0d6f08a60691e8afd082242f5b::clmm::solve_optimal_zero_for_one(&v4);
                (arg3 - 0x84a045ff30c196b731676ff9992e7b6aa9d89e0d6f08a60691e8afd082242f5b::clmm::amount_x_desired(&v4) + 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::full_math_u64::mul_div_floor(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_delta_a(v13, v8, v7, true), 1000000, 1000000 - 0x84a045ff30c196b731676ff9992e7b6aa9d89e0d6f08a60691e8afd082242f5b::clmm::fee_pips(&v4)), v13)
            } else {
                (arg3, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_next_sqrt_price_a_up(v8, v7, 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::full_math_u64::mul_div_floor(0x84a045ff30c196b731676ff9992e7b6aa9d89e0d6f08a60691e8afd082242f5b::clmm::amount_x_desired(&v4), 1000000 - 0x84a045ff30c196b731676ff9992e7b6aa9d89e0d6f08a60691e8afd082242f5b::clmm::fee_pips(&v4), 1000000), true))
            };
            (v12, 0x84a045ff30c196b731676ff9992e7b6aa9d89e0d6f08a60691e8afd082242f5b::clmm::amount_y_desired(&v4) - arg4 + 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_delta_b(v8, v11, v7, false), v11)
        } else {
            let (v14, v11) = if (v8 >= 0x84a045ff30c196b731676ff9992e7b6aa9d89e0d6f08a60691e8afd082242f5b::clmm::sqrt_ratio_lower_x64(&v4)) {
                let v15 = 0x84a045ff30c196b731676ff9992e7b6aa9d89e0d6f08a60691e8afd082242f5b::clmm::solve_optimal_one_for_zero(&v4);
                (arg4 - 0x84a045ff30c196b731676ff9992e7b6aa9d89e0d6f08a60691e8afd082242f5b::clmm::amount_y_desired(&v4) + 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::full_math_u64::mul_div_floor(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_delta_b(v15, v8, v7, true), 1000000, 1000000 - 0x84a045ff30c196b731676ff9992e7b6aa9d89e0d6f08a60691e8afd082242f5b::clmm::fee_pips(&v4)), v15)
            } else {
                (arg4, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_next_sqrt_price_b_down(v8, v7, 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::full_math_u64::mul_div_floor(0x84a045ff30c196b731676ff9992e7b6aa9d89e0d6f08a60691e8afd082242f5b::clmm::amount_y_desired(&v4), 1000000 - 0x84a045ff30c196b731676ff9992e7b6aa9d89e0d6f08a60691e8afd082242f5b::clmm::fee_pips(&v4), 1000000), true))
            };
            (v14, 0x84a045ff30c196b731676ff9992e7b6aa9d89e0d6f08a60691e8afd082242f5b::clmm::amount_x_desired(&v4) - arg3 + 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_delta_a(v8, v11, v7, false), v11)
        };
        (v9, v10, v5, v11)
    }

    public fun rebalance<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg3: u32, arg4: u32, arg5: u64, arg6: bool, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position) {
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(&arg2);
        let (v1, v2) = if (v0 > 0) {
            let (_, _, v5, v6) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::remove_liquidity<T0, T1>(arg0, arg1, &mut arg2, v0, arg7);
            (v5, v6)
        } else {
            (0x2::balance::zero<T0>(), 0x2::balance::zero<T1>())
        };
        let v7 = v2;
        let v8 = v1;
        let (_, _, v11, v12) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_fee<T0, T1>(arg7, arg0, arg1, &mut arg2);
        let v13 = v12;
        let v14 = v11;
        let v15 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<T0, T1>(arg0, arg1, arg3, arg4, arg8);
        if (arg6) {
            0x2::balance::join<T0>(&mut v8, 0x2::balance::withdraw_all<T0>(&mut v14));
            0x2::balance::join<T1>(&mut v7, 0x2::balance::withdraw_all<T1>(&mut v13));
        };
        let v16 = &mut v15;
        let (v17, v18, v19, v20) = zap_in_int<T0, T1>(arg1, arg0, v16, v8, v7, arg5, arg7);
        let v21 = v20;
        let v22 = v19;
        0x84a045ff30c196b731676ff9992e7b6aa9d89e0d6f08a60691e8afd082242f5b::clmm::emit_rebalanced(0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg1), 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&arg2), 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&v15), 0x2::balance::value<T0>(&v8), 0x2::balance::value<T1>(&v7), v17, v18, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::lower_tick(&arg2)), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::upper_tick(&arg2)), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::lower_tick(&v15)), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::upper_tick(&v15)), v0, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(&v15));
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::close_position_v2<T0, T1>(arg7, arg0, arg1, arg2);
        0x2::balance::join<T0>(&mut v22, v14);
        0x2::balance::join<T1>(&mut v21, v13);
        (0x2::coin::from_balance<T0>(v22, arg8), 0x2::coin::from_balance<T1>(v21, arg8), v15)
    }

    fun swap_to_optimal_ratio<T0, T1>(arg0: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: u32, arg3: u32, arg4: 0x2::balance::Balance<T0>, arg5: 0x2::balance::Balance<T1>, arg6: u64, arg7: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let (v0, v1, v2, v3) = optimal_swap<T0, T1>(arg0, arg2, arg3, 0x2::balance::value<T0>(&arg4), 0x2::balance::value<T1>(&arg5));
        if (v0 == 0 && v1 == 0) {
            return (arg4, arg5)
        };
        let (v4, v5) = if (v2) {
            (0x2::balance::split<T0>(&mut arg4, v0), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut arg5, v0))
        };
        let v6 = if (v2) {
            v3 - 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::full_math_u128::mul_div_floor(v3, ((1000000 - arg6) as u128), (1000000 as u128))
        } else {
            v3 + 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::full_math_u128::mul_div_floor(v3, ((1000000 - arg6) as u128), (1000000 as u128))
        };
        let (v7, v8) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, T1>(arg7, arg1, arg0, v4, v5, v2, true, v0, 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::full_math_u64::mul_div_floor(v1, 1000000 - arg6, 1000000), v6);
        0x2::balance::join<T0>(&mut arg4, v7);
        0x2::balance::join<T1>(&mut arg5, v8);
        (arg4, arg5)
    }

    public fun zap_in<T0, T1>(arg0: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: u64, arg6: &0x2::clock::Clock) : (u64, u64, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let (v0, v1, v2, v3) = zap_in_int<T0, T1>(arg0, arg1, arg2, 0x2::coin::into_balance<T0>(arg3), 0x2::coin::into_balance<T1>(arg4), arg5, arg6);
        0x84a045ff30c196b731676ff9992e7b6aa9d89e0d6f08a60691e8afd082242f5b::clmm::emit_zapped_in(0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg0), 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(arg2), v0, v1);
        (v0, v1, v2, v3)
    }

    fun zap_in_int<T0, T1>(arg0: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg3: 0x2::balance::Balance<T0>, arg4: 0x2::balance::Balance<T1>, arg5: u64, arg6: &0x2::clock::Clock) : (u64, u64, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let (v0, v1) = swap_to_optimal_ratio<T0, T1>(arg0, arg1, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::lower_tick(arg2)), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::upper_tick(arg2)), arg3, arg4, arg5, arg6);
        let v2 = v1;
        let v3 = v0;
        let v4 = 0x2::balance::value<T0>(&v3);
        let v5 = 0x2::balance::value<T1>(&v2);
        assert!(v4 > 0 || v5 > 0, 2);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity<T0, T1>(arg6, arg1, arg0, arg2, v3, v2, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::liquidity_math::get_liquidity_for_amounts(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg0), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::lower_tick(arg2)), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::upper_tick(arg2)), v4, v5))
    }

    // decompiled from Move bytecode v6
}

