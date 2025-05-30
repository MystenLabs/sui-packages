module 0xdf7f12205ae05503dc2af3db0e9caf29e96881e4c6a79c8722fdb2df8eeb1ccb::utils {
    public fun swap<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: bool, arg5: bool, arg6: u64, arg7: u128, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, arg4, arg5, arg6, arg7, arg8);
        let v3 = v2;
        let v4 = v1;
        let v5 = v0;
        let v6 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3);
        if (arg4) {
        };
        if (arg4) {
            assert!(v6 <= 0x2::coin::value<T0>(&arg2), 0);
        } else {
            assert!(v6 <= 0x2::coin::value<T1>(&arg3), 1);
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

    public(friend) fun close_position<T0, T1, T2>(arg0: &mut 0xdf7f12205ae05503dc2af3db0e9caf29e96881e4c6a79c8722fdb2df8eeb1ccb::vault::Vault<T0, T1, T2>, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::remove_liquidity<T0, T1>(arg2, arg1, 0xdf7f12205ae05503dc2af3db0e9caf29e96881e4c6a79c8722fdb2df8eeb1ccb::vault::position_borrow_mut<T0, T1, T2>(arg0), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(0xdf7f12205ae05503dc2af3db0e9caf29e96881e4c6a79c8722fdb2df8eeb1ccb::vault::position_borrow<T0, T1, T2>(arg0)), arg3);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::close_position<T0, T1>(arg2, arg1, 0xdf7f12205ae05503dc2af3db0e9caf29e96881e4c6a79c8722fdb2df8eeb1ccb::vault::remove_position<T0, T1, T2>(arg0));
        (v0, v1)
    }

    public(friend) fun create_position<T0, T1, T2>(arg0: &mut 0xdf7f12205ae05503dc2af3db0e9caf29e96881e4c6a79c8722fdb2df8eeb1ccb::vault::Vault<T0, T1, T2>, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x2::balance::Balance<T0>, arg4: &mut 0x2::balance::Balance<T1>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (u32, u32) {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1);
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_tick_at_sqrt_price(scale(v0, 0xdf7f12205ae05503dc2af3db0e9caf29e96881e4c6a79c8722fdb2df8eeb1ccb::vault::lower_price_scalling_fac<T0, T1, T2>(arg0), false));
        let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_tick_at_sqrt_price(scale(v0, 0xdf7f12205ae05503dc2af3db0e9caf29e96881e4c6a79c8722fdb2df8eeb1ccb::vault::upper_price_scalling_fac<T0, T1, T2>(arg0), true));
        let v3 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::abs_u32(v1) - 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::abs_u32(v1) % 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::tick_spacing<T0, T1>(arg1);
        let v4 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::abs_u32(v2) - 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::abs_u32(v2) % 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::tick_spacing<T0, T1>(arg1);
        let v5 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T0, T1>(arg2, arg1, v3, v4, arg6);
        let v6 = v0 > 0xdf7f12205ae05503dc2af3db0e9caf29e96881e4c6a79c8722fdb2df8eeb1ccb::vault::last_rebalance_sqrt_price<T0, T1, T2>(arg0);
        let v7 = if (v6) {
            0x2::balance::value<T0>(arg3)
        } else {
            0x2::balance::value<T1>(arg4)
        };
        let v8 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T0, T1>(arg2, arg1, &mut v5, v7, v6, arg5);
        let (v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T0, T1>(&v8);
        assert!(0x2::balance::value<T0>(arg3) >= v9, 0);
        assert!(0x2::balance::value<T1>(arg4) >= v10, 1);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T0, T1>(arg2, arg1, 0x2::balance::split<T0>(arg3, v9), 0x2::balance::split<T1>(arg4, v10), v8);
        0xdf7f12205ae05503dc2af3db0e9caf29e96881e4c6a79c8722fdb2df8eeb1ccb::vault::insert_position<T0, T1, T2>(arg0, v5);
        (v3, v4)
    }

    fun scale(arg0: u128, arg1: u64, arg2: bool) : u128 {
        if (arg2) {
            arg0 + (arg0 as u128) * (arg1 as u128) / 0xdf7f12205ae05503dc2af3db0e9caf29e96881e4c6a79c8722fdb2df8eeb1ccb::vault::scalling_factor()
        } else {
            arg0 - (arg0 as u128) * (arg1 as u128) / 0xdf7f12205ae05503dc2af3db0e9caf29e96881e4c6a79c8722fdb2df8eeb1ccb::vault::scalling_factor()
        }
    }

    // decompiled from Move bytecode v6
}

