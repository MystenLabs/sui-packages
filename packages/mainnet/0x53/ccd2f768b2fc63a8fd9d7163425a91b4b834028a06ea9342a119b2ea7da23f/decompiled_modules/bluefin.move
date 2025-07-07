module 0x53ccd2f768b2fc63a8fd9d7163425a91b4b834028a06ea9342a119b2ea7da23f::bluefin {
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

    public(friend) fun cross_ticks<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: &mut 0x53ccd2f768b2fc63a8fd9d7163425a91b4b834028a06ea9342a119b2ea7da23f::clmm::SwapState, arg2: u128, arg3: bool) {
        let v0 = 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::neg_from(32768);
        let v1 = 0;
        loop {
            let (v2, v3, v4) = next_initialized_tick(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::bitmap(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_tick_manager<T0, T1>(arg0)), 0x53ccd2f768b2fc63a8fd9d7163425a91b4b834028a06ea9342a119b2ea7da23f::clmm::tick(arg1), 0x53ccd2f768b2fc63a8fd9d7163425a91b4b834028a06ea9342a119b2ea7da23f::clmm::tick_spacing(arg1), arg3, v0, v1);
            v1 = v4;
            v0 = v3;
            let v5 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(0x53ccd2f768b2fc63a8fd9d7163425a91b4b834028a06ea9342a119b2ea7da23f::i32::lib_to_mate(v2));
            let (v6, v7) = if (arg3) {
                let (v8, v9, v10, _) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::compute_swap_step(0x53ccd2f768b2fc63a8fd9d7163425a91b4b834028a06ea9342a119b2ea7da23f::clmm::sqrt_price_x64(arg1), v5, 0x53ccd2f768b2fc63a8fd9d7163425a91b4b834028a06ea9342a119b2ea7da23f::clmm::liquidity(arg1), 0x53ccd2f768b2fc63a8fd9d7163425a91b4b834028a06ea9342a119b2ea7da23f::clmm::amount_x_desired(arg1), 0x53ccd2f768b2fc63a8fd9d7163425a91b4b834028a06ea9342a119b2ea7da23f::clmm::fee_pips(arg1), true, true);
                arg2 = v10;
                (0x53ccd2f768b2fc63a8fd9d7163425a91b4b834028a06ea9342a119b2ea7da23f::clmm::amount_x_desired(arg1) - v8, 0x53ccd2f768b2fc63a8fd9d7163425a91b4b834028a06ea9342a119b2ea7da23f::clmm::amount_y_desired(arg1) + v9)
            } else {
                let (v12, v13, v14, _) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::compute_swap_step(0x53ccd2f768b2fc63a8fd9d7163425a91b4b834028a06ea9342a119b2ea7da23f::clmm::sqrt_price_x64(arg1), v5, 0x53ccd2f768b2fc63a8fd9d7163425a91b4b834028a06ea9342a119b2ea7da23f::clmm::liquidity(arg1), 0x53ccd2f768b2fc63a8fd9d7163425a91b4b834028a06ea9342a119b2ea7da23f::clmm::amount_y_desired(arg1), 0x53ccd2f768b2fc63a8fd9d7163425a91b4b834028a06ea9342a119b2ea7da23f::clmm::fee_pips(arg1), false, true);
                arg2 = v14;
                (0x53ccd2f768b2fc63a8fd9d7163425a91b4b834028a06ea9342a119b2ea7da23f::clmm::amount_x_desired(arg1) + v13, 0x53ccd2f768b2fc63a8fd9d7163425a91b4b834028a06ea9342a119b2ea7da23f::clmm::amount_y_desired(arg1) - v12)
            };
            if (arg2 != v5) {
                break
            };
            if (0x53ccd2f768b2fc63a8fd9d7163425a91b4b834028a06ea9342a119b2ea7da23f::clmm::is_x2y(v6, v7, arg2, 0x53ccd2f768b2fc63a8fd9d7163425a91b4b834028a06ea9342a119b2ea7da23f::clmm::sqrt_ratio_lower_x64(arg1), 0x53ccd2f768b2fc63a8fd9d7163425a91b4b834028a06ea9342a119b2ea7da23f::clmm::sqrt_ratio_upper_x64(arg1)) == arg3) {
                let v16 = 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::from(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i128::as_u128(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::liquidity_net(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::get_tick_from_manager(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_tick_manager<T0, T1>(arg0), 0x53ccd2f768b2fc63a8fd9d7163425a91b4b834028a06ea9342a119b2ea7da23f::i32::lib_to_mate(v2)))));
                let v17 = v16;
                if (arg3) {
                    v17 = 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::sub(0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::zero(), v16);
                };
                let v18 = if (arg3) {
                    1
                } else {
                    0
                };
                0x53ccd2f768b2fc63a8fd9d7163425a91b4b834028a06ea9342a119b2ea7da23f::clmm::update_swap_state(arg1, 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::as_u128(v17), arg2, 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::sub(v2, 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::from(v18)), v6, v7);
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
                *0x2::table::borrow<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, u256>(arg0, 0x53ccd2f768b2fc63a8fd9d7163425a91b4b834028a06ea9342a119b2ea7da23f::i32::lib_to_mate(v3))
            };
            let v1 = v5;
            let v6 = v5 & (2 << v4) - 1;
            while (v6 == 0) {
                let v7 = 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::sub(v2, 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::from(1));
                v2 = v7;
                let v8 = *0x2::table::borrow<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, u256>(arg0, 0x53ccd2f768b2fc63a8fd9d7163425a91b4b834028a06ea9342a119b2ea7da23f::i32::lib_to_mate(v7));
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
                *0x2::table::borrow<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, u256>(arg0, 0x53ccd2f768b2fc63a8fd9d7163425a91b4b834028a06ea9342a119b2ea7da23f::i32::lib_to_mate(v9))
            };
            let v1 = v11;
            let v12 = v11 & ((1 << v10) - 1 ^ 115792089237316195423570985008687907853269984665640564039457584007913129639935);
            while (v12 == 0) {
                let v13 = 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::add(v2, 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::from(1));
                v2 = v13;
                let v14 = *0x2::table::borrow<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, u256>(arg0, 0x53ccd2f768b2fc63a8fd9d7163425a91b4b834028a06ea9342a119b2ea7da23f::i32::lib_to_mate(v13));
                v1 = v14;
                v12 = v14;
            };
            (0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::bit_math::least_significant_bit(v12), v1, v2)
        };
        (0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::mul(0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::add(0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::shl(v2, 8), 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::from((v0 as u32))), 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::from(arg2)), v2, v1)
    }

    public fun optimal_swap<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::I32, arg2: 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::I32, arg3: u64, arg4: u64) : (u64, u64, bool, u128) {
        if (arg3 == 0 && arg4 == 0) {
            return (0, 0, false, 0)
        };
        let v0 = if (0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::lte(arg1, arg2)) {
            if (0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::gte(arg1, 0x53ccd2f768b2fc63a8fd9d7163425a91b4b834028a06ea9342a119b2ea7da23f::i32::mate_to_lib(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_tick()))) {
                0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::lte(arg2, 0x53ccd2f768b2fc63a8fd9d7163425a91b4b834028a06ea9342a119b2ea7da23f::i32::mate_to_lib(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_tick()))
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 1);
        let v1 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg0);
        let v2 = 0x53ccd2f768b2fc63a8fd9d7163425a91b4b834028a06ea9342a119b2ea7da23f::clmm::init_swap_state(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::liquidity<T0, T1>(arg0), v1, 0x53ccd2f768b2fc63a8fd9d7163425a91b4b834028a06ea9342a119b2ea7da23f::i32::mate_to_lib(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg0)), arg3, arg4, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_fee_rate<T0, T1>(arg0), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_tick_spacing<T0, T1>(arg0), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(0x53ccd2f768b2fc63a8fd9d7163425a91b4b834028a06ea9342a119b2ea7da23f::i32::lib_to_mate(arg1)), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(0x53ccd2f768b2fc63a8fd9d7163425a91b4b834028a06ea9342a119b2ea7da23f::i32::lib_to_mate(arg2)));
        let v3 = 0x53ccd2f768b2fc63a8fd9d7163425a91b4b834028a06ea9342a119b2ea7da23f::clmm::is_x2y(arg3, arg4, v1, 0x53ccd2f768b2fc63a8fd9d7163425a91b4b834028a06ea9342a119b2ea7da23f::clmm::sqrt_ratio_lower_x64(&v2), 0x53ccd2f768b2fc63a8fd9d7163425a91b4b834028a06ea9342a119b2ea7da23f::clmm::sqrt_ratio_upper_x64(&v2));
        let v4 = &mut v2;
        cross_ticks<T0, T1>(arg0, v4, v1, v3);
        let v5 = 0x53ccd2f768b2fc63a8fd9d7163425a91b4b834028a06ea9342a119b2ea7da23f::clmm::liquidity(&v2);
        let v6 = 0x53ccd2f768b2fc63a8fd9d7163425a91b4b834028a06ea9342a119b2ea7da23f::clmm::sqrt_price_x64(&v2);
        let (v7, v8, v9) = if (v3) {
            let (v10, v9) = if (v6 <= 0x53ccd2f768b2fc63a8fd9d7163425a91b4b834028a06ea9342a119b2ea7da23f::clmm::sqrt_ratio_upper_x64(&v2)) {
                let v11 = 0x53ccd2f768b2fc63a8fd9d7163425a91b4b834028a06ea9342a119b2ea7da23f::clmm::solve_optimal_zero_for_one(&v2);
                (arg3 - 0x53ccd2f768b2fc63a8fd9d7163425a91b4b834028a06ea9342a119b2ea7da23f::clmm::amount_x_desired(&v2) + 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::full_math_u64::mul_div_floor(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_delta_a(v11, v6, v5, true), 1000000, 1000000 - 0x53ccd2f768b2fc63a8fd9d7163425a91b4b834028a06ea9342a119b2ea7da23f::clmm::fee_pips(&v2)), v11)
            } else {
                (arg3, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_next_sqrt_price_a_up(v6, v5, 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::full_math_u64::mul_div_floor(0x53ccd2f768b2fc63a8fd9d7163425a91b4b834028a06ea9342a119b2ea7da23f::clmm::amount_x_desired(&v2), 1000000 - 0x53ccd2f768b2fc63a8fd9d7163425a91b4b834028a06ea9342a119b2ea7da23f::clmm::fee_pips(&v2), 1000000), true))
            };
            (v10, 0x53ccd2f768b2fc63a8fd9d7163425a91b4b834028a06ea9342a119b2ea7da23f::clmm::amount_y_desired(&v2) - arg4 + 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_delta_b(v6, v9, v5, false), v9)
        } else {
            let (v12, v9) = if (v6 >= 0x53ccd2f768b2fc63a8fd9d7163425a91b4b834028a06ea9342a119b2ea7da23f::clmm::sqrt_ratio_lower_x64(&v2)) {
                let v13 = 0x53ccd2f768b2fc63a8fd9d7163425a91b4b834028a06ea9342a119b2ea7da23f::clmm::solve_optimal_one_for_zero(&v2);
                (arg4 - 0x53ccd2f768b2fc63a8fd9d7163425a91b4b834028a06ea9342a119b2ea7da23f::clmm::amount_y_desired(&v2) + 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::full_math_u64::mul_div_floor(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_delta_b(v13, v6, v5, true), 1000000, 1000000 - 0x53ccd2f768b2fc63a8fd9d7163425a91b4b834028a06ea9342a119b2ea7da23f::clmm::fee_pips(&v2)), v13)
            } else {
                (arg4, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_next_sqrt_price_b_down(v6, v5, 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::full_math_u64::mul_div_floor(0x53ccd2f768b2fc63a8fd9d7163425a91b4b834028a06ea9342a119b2ea7da23f::clmm::amount_y_desired(&v2), 1000000 - 0x53ccd2f768b2fc63a8fd9d7163425a91b4b834028a06ea9342a119b2ea7da23f::clmm::fee_pips(&v2), 1000000), true))
            };
            (v12, 0x53ccd2f768b2fc63a8fd9d7163425a91b4b834028a06ea9342a119b2ea7da23f::clmm::amount_x_desired(&v2) - arg3 + 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_delta_a(v6, v9, v5, false), v9)
        };
        (v7, v8, v3, v9)
    }

    public fun rebalance<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position) {
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(&arg2);
        let (v1, v2) = if (v0 > 0) {
            let (_, _, v5, v6) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::remove_liquidity<T0, T1>(arg0, arg1, &mut arg2, v0, arg3);
            (v5, v6)
        } else {
            (0x2::balance::zero<T0>(), 0x2::balance::zero<T1>())
        };
        let v7 = v2;
        let v8 = v1;
        let (_, _, v11, v12) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_fee<T0, T1>(arg3, arg0, arg1, &mut arg2);
        let v13 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<T0, T1>(arg0, arg1, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::lower_tick(&arg2)), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::upper_tick(&arg2)), arg4);
        let v14 = 0x2::balance::value<T0>(&v8);
        let (v15, v16, v17, v18) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity_with_fixed_amount<T0, T1>(arg3, arg0, arg1, &mut v13, v8, v7, v14, true);
        let v19 = v18;
        let v20 = v17;
        0x53ccd2f768b2fc63a8fd9d7163425a91b4b834028a06ea9342a119b2ea7da23f::clmm::emit_rebalanced_event(0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg1), 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&arg2), 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&v13), v14, 0x2::balance::value<T1>(&v7), v15, v16, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::lower_tick(&arg2)), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::upper_tick(&arg2)), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::lower_tick(&v13)), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::upper_tick(&v13)), v0, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(&v13));
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::close_position_v2<T0, T1>(arg3, arg0, arg1, arg2);
        0x2::balance::join<T0>(&mut v20, v11);
        0x2::balance::join<T1>(&mut v19, v12);
        (0x2::coin::from_balance<T0>(v20, arg4), 0x2::coin::from_balance<T1>(v19, arg4), v13)
    }

    // decompiled from Move bytecode v6
}

