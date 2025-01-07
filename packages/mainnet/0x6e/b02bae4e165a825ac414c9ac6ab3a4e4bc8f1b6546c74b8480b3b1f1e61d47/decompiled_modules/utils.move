module 0x6eb02bae4e165a825ac414c9ac6ab3a4e4bc8f1b6546c74b8480b3b1f1e61d47::utils {
    public fun swap<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: bool, arg5: bool, arg6: u64, arg7: u128, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, arg4, arg5, arg6, arg7, arg8);
        let v3 = v2;
        let v4 = v1;
        let v5 = v0;
        let v6 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3);
        if (arg4) {
        };
        if (arg4) {
            assert!(v6 <= 0x2::coin::value<T0>(&arg2), 3);
        } else {
            assert!(v6 <= 0x2::coin::value<T1>(&arg3), 4);
        };
        let (v7, v8) = if (arg4) {
            (0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg2, v6, arg9)), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg3, v6, arg9)))
        };
        0x2::coin::join<T1>(&mut arg3, 0x2::coin::from_balance<T1>(v4, arg9));
        0x2::coin::join<T0>(&mut arg2, 0x2::coin::from_balance<T0>(v5, arg9));
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, v7, v8, v3);
        (arg2, arg3)
    }

    public(friend) fun close_position<T0, T1, T2>(arg0: &mut 0x6eb02bae4e165a825ac414c9ac6ab3a4e4bc8f1b6546c74b8480b3b1f1e61d47::vault::Vault<T0, T1, T2>, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::remove_liquidity<T0, T1>(arg2, arg1, 0x6eb02bae4e165a825ac414c9ac6ab3a4e4bc8f1b6546c74b8480b3b1f1e61d47::vault::position_borrow_mut<T0, T1, T2>(arg0), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(0x6eb02bae4e165a825ac414c9ac6ab3a4e4bc8f1b6546c74b8480b3b1f1e61d47::vault::position_borrow<T0, T1, T2>(arg0)), arg3);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::close_position<T0, T1>(arg2, arg1, 0x6eb02bae4e165a825ac414c9ac6ab3a4e4bc8f1b6546c74b8480b3b1f1e61d47::vault::remove_position<T0, T1, T2>(arg0));
        (v0, v1)
    }

    public fun check_is_fix_coin_a(arg0: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg2: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg3: u128, arg4: u64, arg5: u64) : (bool, u64, u64) {
        let (_, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_liquidity_by_amount(arg0, arg1, arg2, arg3, arg4, true);
        assert!(v1 == arg4, 100);
        if (v2 <= arg5) {
            return (true, v1, v2)
        };
        let (_, v4, v5) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_liquidity_by_amount(arg0, arg1, arg2, arg3, arg5, false);
        assert!(v5 == arg5, 101);
        (false, v4, v5)
    }

    public(friend) fun create_position<T0, T1, T2>(arg0: &mut 0x6eb02bae4e165a825ac414c9ac6ab3a4e4bc8f1b6546c74b8480b3b1f1e61d47::vault::Vault<T0, T1, T2>, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x2::balance::Balance<T0>, arg4: &mut 0x2::balance::Balance<T1>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (u32, u32, u128, u128) {
        swap_if_zero<T0, T1>(arg2, arg1, arg3, arg4, arg5, arg6);
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1);
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_tick_at_sqrt_price(scale(v0, 0x6eb02bae4e165a825ac414c9ac6ab3a4e4bc8f1b6546c74b8480b3b1f1e61d47::vault::upper_price_scalling<T0, T1, T2>(arg0)));
        let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_tick_at_sqrt_price(scale(v0, 0x6eb02bae4e165a825ac414c9ac6ab3a4e4bc8f1b6546c74b8480b3b1f1e61d47::vault::lower_price_scalling<T0, T1, T2>(arg0)));
        let v3 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::abs_u32(v2) - 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::abs_u32(v2) % 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::tick_spacing<T0, T1>(arg1);
        let v4 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::abs_u32(v1) - 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::abs_u32(v1) % 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::tick_spacing<T0, T1>(arg1);
        let v5 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T0, T1>(arg2, arg1, v3, v4, arg6);
        let (v6, v7, v8) = check_is_fix_coin_a(v2, v1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg1), v0, 0x2::balance::value<T0>(arg3), 0x2::balance::value<T1>(arg4));
        let v9 = if (v6) {
            v7
        } else {
            v8
        };
        let v10 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T0, T1>(arg2, arg1, &mut v5, v9, v6, arg5);
        let (v11, v12) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T0, T1>(&v10);
        assert!(0x2::balance::value<T0>(arg3) >= v11, 0);
        assert!(0x2::balance::value<T1>(arg4) >= v12, 1);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T0, T1>(arg2, arg1, 0x2::balance::split<T0>(arg3, v11), 0x2::balance::split<T1>(arg4, v12), v10);
        0x6eb02bae4e165a825ac414c9ac6ab3a4e4bc8f1b6546c74b8480b3b1f1e61d47::vault::update_last_rebalance_sqrt_price<T0, T1, T2>(arg0, v0);
        0x6eb02bae4e165a825ac414c9ac6ab3a4e4bc8f1b6546c74b8480b3b1f1e61d47::vault::insert_position<T0, T1, T2>(arg0, v5);
        (v3, v4, scale(v0, 0x6eb02bae4e165a825ac414c9ac6ab3a4e4bc8f1b6546c74b8480b3b1f1e61d47::vault::lower_trigger_price_scalling<T0, T1, T2>(arg0)), scale(v0, 0x6eb02bae4e165a825ac414c9ac6ab3a4e4bc8f1b6546c74b8480b3b1f1e61d47::vault::upper_trigger_price_scalling<T0, T1, T2>(arg0)))
    }

    fun scale(arg0: u128, arg1: u64) : u128 {
        (((arg0 as u256) * (arg1 as u256) / (0x6eb02bae4e165a825ac414c9ac6ab3a4e4bc8f1b6546c74b8480b3b1f1e61d47::vault::scalling_factor() as u256)) as u128)
    }

    public fun slippage_adjusted_sqrt_price(arg0: bool, arg1: u64, arg2: u64, arg3: u128) : u128 {
        if (arg1 == 0 && arg2 == 0) {
            if (arg0) {
                4295048016
            } else {
                79226673515401279992447579055
            }
        } else if (arg0) {
            scale(arg3, arg2)
        } else {
            scale(arg3, arg1)
        }
    }

    fun swap_if_zero<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x2::balance::Balance<T0>, arg3: &mut 0x2::balance::Balance<T1>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(arg2) == 0 && 0x2::balance::value<T1>(arg3) / 2 > 0) {
            let v0 = 0x2::balance::value<T1>(arg3) / 2;
            let v1 = 0x2::coin::zero<T0>(arg5);
            let v2 = 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(arg3, v0), arg5);
            let (v3, v4) = swap<T0, T1>(arg0, arg1, v1, v2, false, true, v0, 79226673515401279992447579055, arg4, arg5);
            0x2::coin::destroy_zero<T1>(v4);
            0x2::balance::join<T0>(arg2, 0x2::coin::into_balance<T0>(v3));
        };
        if (0x2::balance::value<T1>(arg3) == 0 && 0x2::balance::value<T0>(arg2) / 2 > 0) {
            let v5 = 0x2::balance::value<T0>(arg2) / 2;
            let v6 = 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(arg2, v5), arg5);
            let v7 = 0x2::coin::zero<T1>(arg5);
            let (v8, v9) = swap<T0, T1>(arg0, arg1, v6, v7, true, true, v5, 4295048016, arg4, arg5);
            0x2::coin::destroy_zero<T0>(v8);
            0x2::balance::join<T1>(arg3, 0x2::coin::into_balance<T1>(v9));
        };
    }

    // decompiled from Move bytecode v6
}

