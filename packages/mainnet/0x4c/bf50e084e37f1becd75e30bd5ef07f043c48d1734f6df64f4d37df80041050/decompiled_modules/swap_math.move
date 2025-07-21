module 0x4cbf50e084e37f1becd75e30bd5ef07f043c48d1734f6df64f4d37df80041050::swap_math {
    fun cross_ticks<T0, T1>(arg0: &mut 0x62ff6e2f57364805c56b18ac4d46fcbb96f65f2089da1a0d08f13458fcf35c8e::state::SwapState, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: bool) {
        loop {
            let (v0, _) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_bitmap::next_initialized_tick_within_one_word(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::borrow_tick_bitmap<T0, T1>(arg1), 0x4cbf50e084e37f1becd75e30bd5ef07f043c48d1734f6df64f4d37df80041050::i32_utils::lib_to_mate(0x62ff6e2f57364805c56b18ac4d46fcbb96f65f2089da1a0d08f13458fcf35c8e::state::tick(arg0)), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::tick_spacing<T0, T1>(arg1), arg2);
            let v2 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::get_sqrt_price_at_tick(v0);
            let v3 = if (arg2) {
                0x62ff6e2f57364805c56b18ac4d46fcbb96f65f2089da1a0d08f13458fcf35c8e::state::amount_x_desired(arg0)
            } else {
                0x62ff6e2f57364805c56b18ac4d46fcbb96f65f2089da1a0d08f13458fcf35c8e::state::amount_y_desired(arg0)
            };
            let (v4, v5, v6, v7) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::swap_math::compute_swap_step(0x62ff6e2f57364805c56b18ac4d46fcbb96f65f2089da1a0d08f13458fcf35c8e::state::sqrt_price(arg0), v2, 0x62ff6e2f57364805c56b18ac4d46fcbb96f65f2089da1a0d08f13458fcf35c8e::state::liquidity(arg0), v3, 0x62ff6e2f57364805c56b18ac4d46fcbb96f65f2089da1a0d08f13458fcf35c8e::state::fee_pips(arg0), true);
            let (v8, v9) = if (arg2) {
                (0x62ff6e2f57364805c56b18ac4d46fcbb96f65f2089da1a0d08f13458fcf35c8e::state::amount_x_desired(arg0) - v5 - v7, 0x62ff6e2f57364805c56b18ac4d46fcbb96f65f2089da1a0d08f13458fcf35c8e::state::amount_y_desired(arg0) + v6)
            } else {
                (0x62ff6e2f57364805c56b18ac4d46fcbb96f65f2089da1a0d08f13458fcf35c8e::state::amount_x_desired(arg0) + v6, 0x62ff6e2f57364805c56b18ac4d46fcbb96f65f2089da1a0d08f13458fcf35c8e::state::amount_y_desired(arg0) - v5 - v7)
            };
            if (v4 != v2) {
                break
            };
            if (0x62ff6e2f57364805c56b18ac4d46fcbb96f65f2089da1a0d08f13458fcf35c8e::math::is_zero_for_one(v8, v9, v4, 0x62ff6e2f57364805c56b18ac4d46fcbb96f65f2089da1a0d08f13458fcf35c8e::state::sqrt_ratio_lower(arg0), 0x62ff6e2f57364805c56b18ac4d46fcbb96f65f2089da1a0d08f13458fcf35c8e::state::sqrt_ratio_upper(arg0)) != arg2) {
                break
            };
            let v10 = 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::from_u128(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i128::as_u128(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick::get_liquidity_net(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::borrow_ticks<T0, T1>(arg1), v0)));
            let v11 = v10;
            if (arg2) {
                v11 = 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::neg(v10);
            };
            let v12 = if (0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::is_neg(v11)) {
                0x62ff6e2f57364805c56b18ac4d46fcbb96f65f2089da1a0d08f13458fcf35c8e::state::liquidity(arg0) - 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::abs_u128(v11)
            } else {
                0x62ff6e2f57364805c56b18ac4d46fcbb96f65f2089da1a0d08f13458fcf35c8e::state::liquidity(arg0) + 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i128::abs_u128(v11)
            };
            let v13 = if (arg2) {
                1
            } else {
                0
            };
            0x62ff6e2f57364805c56b18ac4d46fcbb96f65f2089da1a0d08f13458fcf35c8e::state::update_swap_state(arg0, v12, v4, 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::sub(0x4cbf50e084e37f1becd75e30bd5ef07f043c48d1734f6df64f4d37df80041050::i32_utils::mate_to_lib(v0), 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::from(v13)), v8, v9);
        };
    }

    public(friend) fun optimal_swap<T0, T1>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: u32, arg2: u32, arg3: u64, arg4: u64) : (u64, u64, bool, u128) {
        assert!(arg3 > 0 || arg4 > 0, 0);
        let v0 = 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::from_u32(arg1);
        let v1 = 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::from_u32(arg2);
        let v2 = if (0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::lt(v0, v1)) {
            if (0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::gte(v0, 0x4cbf50e084e37f1becd75e30bd5ef07f043c48d1734f6df64f4d37df80041050::i32_utils::mate_to_lib(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::min_tick()))) {
                0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::lte(v1, 0x4cbf50e084e37f1becd75e30bd5ef07f043c48d1734f6df64f4d37df80041050::i32_utils::mate_to_lib(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::max_tick()))
            } else {
                false
            }
        } else {
            false
        };
        assert!(v2, 1);
        let v3 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::sqrt_price<T0, T1>(arg0);
        let v4 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::get_sqrt_price_at_tick(0x4cbf50e084e37f1becd75e30bd5ef07f043c48d1734f6df64f4d37df80041050::i32_utils::lib_to_mate(v0));
        let v5 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::get_sqrt_price_at_tick(0x4cbf50e084e37f1becd75e30bd5ef07f043c48d1734f6df64f4d37df80041050::i32_utils::lib_to_mate(v1));
        let v6 = 0x62ff6e2f57364805c56b18ac4d46fcbb96f65f2089da1a0d08f13458fcf35c8e::state::init_swap_state(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::liquidity<T0, T1>(arg0), v3, 0x4cbf50e084e37f1becd75e30bd5ef07f043c48d1734f6df64f4d37df80041050::i32_utils::mate_to_lib(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::tick_index_current<T0, T1>(arg0)), arg3, arg4, v4, v5, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::swap_fee_rate<T0, T1>(arg0));
        let v7 = 0x62ff6e2f57364805c56b18ac4d46fcbb96f65f2089da1a0d08f13458fcf35c8e::math::is_zero_for_one(arg3, arg4, v3, v4, v5);
        let v8 = &mut v6;
        cross_ticks<T0, T1>(v8, arg0, v7);
        if (v7) {
            let (v13, v12) = if (0x62ff6e2f57364805c56b18ac4d46fcbb96f65f2089da1a0d08f13458fcf35c8e::state::sqrt_price(&v6) <= v5) {
                let v14 = 0x62ff6e2f57364805c56b18ac4d46fcbb96f65f2089da1a0d08f13458fcf35c8e::state::solve_zero_for_one(&v6);
                (arg3 + 0x62ff6e2f57364805c56b18ac4d46fcbb96f65f2089da1a0d08f13458fcf35c8e::constants::amount_before_fee(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::sqrt_price_math::get_amount_x_delta(v14, 0x62ff6e2f57364805c56b18ac4d46fcbb96f65f2089da1a0d08f13458fcf35c8e::state::sqrt_price(&v6), 0x62ff6e2f57364805c56b18ac4d46fcbb96f65f2089da1a0d08f13458fcf35c8e::state::liquidity(&v6), true), 0x62ff6e2f57364805c56b18ac4d46fcbb96f65f2089da1a0d08f13458fcf35c8e::state::fee_pips(&v6)) - 0x62ff6e2f57364805c56b18ac4d46fcbb96f65f2089da1a0d08f13458fcf35c8e::state::amount_x_desired(&v6), v14)
            } else {
                (arg3, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::sqrt_price_math::get_next_sqrt_price_from_amount_x_rouding_up(0x62ff6e2f57364805c56b18ac4d46fcbb96f65f2089da1a0d08f13458fcf35c8e::state::sqrt_price(&v6), 0x62ff6e2f57364805c56b18ac4d46fcbb96f65f2089da1a0d08f13458fcf35c8e::state::liquidity(&v6), 0x62ff6e2f57364805c56b18ac4d46fcbb96f65f2089da1a0d08f13458fcf35c8e::constants::amount_after_fee(0x62ff6e2f57364805c56b18ac4d46fcbb96f65f2089da1a0d08f13458fcf35c8e::state::amount_x_desired(&v6), 0x62ff6e2f57364805c56b18ac4d46fcbb96f65f2089da1a0d08f13458fcf35c8e::state::fee_pips(&v6)), true))
            };
            (v13, 0x62ff6e2f57364805c56b18ac4d46fcbb96f65f2089da1a0d08f13458fcf35c8e::state::amount_y_desired(&v6) + 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::sqrt_price_math::get_amount_y_delta(v12, 0x62ff6e2f57364805c56b18ac4d46fcbb96f65f2089da1a0d08f13458fcf35c8e::state::sqrt_price(&v6), 0x62ff6e2f57364805c56b18ac4d46fcbb96f65f2089da1a0d08f13458fcf35c8e::state::liquidity(&v6), false) - arg4, true, v12)
        } else {
            let (v15, v12) = if (0x62ff6e2f57364805c56b18ac4d46fcbb96f65f2089da1a0d08f13458fcf35c8e::state::sqrt_price(&v6) >= v4) {
                let v16 = 0x62ff6e2f57364805c56b18ac4d46fcbb96f65f2089da1a0d08f13458fcf35c8e::state::solve_one_for_zero(&v6);
                (arg4 + 0x62ff6e2f57364805c56b18ac4d46fcbb96f65f2089da1a0d08f13458fcf35c8e::constants::amount_before_fee(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::sqrt_price_math::get_amount_y_delta(v16, 0x62ff6e2f57364805c56b18ac4d46fcbb96f65f2089da1a0d08f13458fcf35c8e::state::sqrt_price(&v6), 0x62ff6e2f57364805c56b18ac4d46fcbb96f65f2089da1a0d08f13458fcf35c8e::state::liquidity(&v6), true), 0x62ff6e2f57364805c56b18ac4d46fcbb96f65f2089da1a0d08f13458fcf35c8e::state::fee_pips(&v6)) - 0x62ff6e2f57364805c56b18ac4d46fcbb96f65f2089da1a0d08f13458fcf35c8e::state::amount_y_desired(&v6), v16)
            } else {
                (arg4, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::sqrt_price_math::get_next_sqrt_price_from_amount_y_rouding_down(0x62ff6e2f57364805c56b18ac4d46fcbb96f65f2089da1a0d08f13458fcf35c8e::state::sqrt_price(&v6), 0x62ff6e2f57364805c56b18ac4d46fcbb96f65f2089da1a0d08f13458fcf35c8e::state::liquidity(&v6), 0x62ff6e2f57364805c56b18ac4d46fcbb96f65f2089da1a0d08f13458fcf35c8e::constants::amount_after_fee(0x62ff6e2f57364805c56b18ac4d46fcbb96f65f2089da1a0d08f13458fcf35c8e::state::amount_y_desired(&v6), 0x62ff6e2f57364805c56b18ac4d46fcbb96f65f2089da1a0d08f13458fcf35c8e::state::fee_pips(&v6)), true))
            };
            (v15, 0x62ff6e2f57364805c56b18ac4d46fcbb96f65f2089da1a0d08f13458fcf35c8e::state::amount_x_desired(&v6) + 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::sqrt_price_math::get_amount_x_delta(v12, 0x62ff6e2f57364805c56b18ac4d46fcbb96f65f2089da1a0d08f13458fcf35c8e::state::sqrt_price(&v6), 0x62ff6e2f57364805c56b18ac4d46fcbb96f65f2089da1a0d08f13458fcf35c8e::state::liquidity(&v6), false) - arg3, false, v12)
        }
    }

    // decompiled from Move bytecode v6
}

