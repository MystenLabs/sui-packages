module 0x7f3d24bf4f8fd8b87aa9ebaf594fd9488524ab68391f255fe20ac1cde643a6ae::utils {
    struct SwapIfZeroEvent has copy, drop {
        vault_id: 0x2::object::ID,
        before_sqrt_price: u128,
        after_sqrt_price: u128,
        is_a: bool,
        amount_in: u64,
        amount_out: u64,
        timestamp_ms: u64,
    }

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

    public(friend) fun close_position<T0, T1, T2>(arg0: &mut 0x7f3d24bf4f8fd8b87aa9ebaf594fd9488524ab68391f255fe20ac1cde643a6ae::vault::Vault<T0, T1, T2>, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::remove_liquidity<T0, T1>(arg2, arg1, 0x7f3d24bf4f8fd8b87aa9ebaf594fd9488524ab68391f255fe20ac1cde643a6ae::vault::position_borrow_mut<T0, T1, T2>(arg0), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(0x7f3d24bf4f8fd8b87aa9ebaf594fd9488524ab68391f255fe20ac1cde643a6ae::vault::position_borrow<T0, T1, T2>(arg0)), arg3);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::close_position<T0, T1>(arg2, arg1, 0x7f3d24bf4f8fd8b87aa9ebaf594fd9488524ab68391f255fe20ac1cde643a6ae::vault::remove_position<T0, T1, T2>(arg0));
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
        assert!(v4 <= arg4, 102);
        (false, v4, v5)
    }

    public(friend) fun create_position<T0, T1, T2>(arg0: &mut 0x7f3d24bf4f8fd8b87aa9ebaf594fd9488524ab68391f255fe20ac1cde643a6ae::vault::Vault<T0, T1, T2>, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x2::balance::Balance<T0>, arg4: &mut 0x2::balance::Balance<T1>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (u32, u32, u128, u128) {
        swap_if_zero<T0, T1>(arg2, arg1, arg3, arg4, 0x2::object::id<0x7f3d24bf4f8fd8b87aa9ebaf594fd9488524ab68391f255fe20ac1cde643a6ae::vault::Vault<T0, T1, T2>>(arg0), arg5, arg6);
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1);
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_tick_at_sqrt_price(scale(v0, 0x7f3d24bf4f8fd8b87aa9ebaf594fd9488524ab68391f255fe20ac1cde643a6ae::vault::upper_price_scalling<T0, T1, T2>(arg0)));
        let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_tick_at_sqrt_price(scale(v0, 0x7f3d24bf4f8fd8b87aa9ebaf594fd9488524ab68391f255fe20ac1cde643a6ae::vault::lower_price_scalling<T0, T1, T2>(arg0)));
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
        0x7f3d24bf4f8fd8b87aa9ebaf594fd9488524ab68391f255fe20ac1cde643a6ae::vault::update_last_rebalance_sqrt_price<T0, T1, T2>(arg0, v0);
        0x7f3d24bf4f8fd8b87aa9ebaf594fd9488524ab68391f255fe20ac1cde643a6ae::vault::insert_position<T0, T1, T2>(arg0, v5);
        (v3, v4, scale(v0, 0x7f3d24bf4f8fd8b87aa9ebaf594fd9488524ab68391f255fe20ac1cde643a6ae::vault::lower_trigger_price_scalling<T0, T1, T2>(arg0)), scale(v0, 0x7f3d24bf4f8fd8b87aa9ebaf594fd9488524ab68391f255fe20ac1cde643a6ae::vault::upper_trigger_price_scalling<T0, T1, T2>(arg0)))
    }

    fun scale(arg0: u128, arg1: u128) : u128 {
        (((arg0 as u256) * (arg1 as u256) / (0x7f3d24bf4f8fd8b87aa9ebaf594fd9488524ab68391f255fe20ac1cde643a6ae::vault::scalling_factor() as u256)) as u128)
    }

    public fun slippage_adjusted_sqrt_price(arg0: bool, arg1: u128, arg2: u128, arg3: u128) : u128 {
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

    fun swap_if_zero<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x2::balance::Balance<T0>, arg3: &mut 0x2::balance::Balance<T1>, arg4: 0x2::object::ID, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1);
        if (0x2::balance::value<T0>(arg2) == 0 && 0x2::balance::value<T1>(arg3) / 2 > 0) {
            let v1 = 0x2::balance::value<T1>(arg3) / 2;
            let v2 = 0x2::coin::zero<T0>(arg6);
            let v3 = 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(arg3, v1), arg6);
            let (v4, v5) = swap<T0, T1>(arg0, arg1, v2, v3, false, true, v1, 79226673515401279992447579055, arg5, arg6);
            let v6 = v4;
            0x2::coin::destroy_zero<T1>(v5);
            let v7 = SwapIfZeroEvent{
                vault_id          : arg4,
                before_sqrt_price : v0,
                after_sqrt_price  : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1),
                is_a              : false,
                amount_in         : v1,
                amount_out        : 0x2::coin::value<T0>(&v6),
                timestamp_ms      : 0x2::clock::timestamp_ms(arg5),
            };
            0x2::event::emit<SwapIfZeroEvent>(v7);
            0x2::balance::join<T0>(arg2, 0x2::coin::into_balance<T0>(v6));
        };
        if (0x2::balance::value<T1>(arg3) == 0 && 0x2::balance::value<T0>(arg2) / 2 > 0) {
            let v8 = 0x2::balance::value<T0>(arg2) / 2;
            let v9 = 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(arg2, v8), arg6);
            let v10 = 0x2::coin::zero<T1>(arg6);
            let (v11, v12) = swap<T0, T1>(arg0, arg1, v9, v10, true, true, v8, 4295048016, arg5, arg6);
            let v13 = v12;
            0x2::coin::destroy_zero<T0>(v11);
            let v14 = SwapIfZeroEvent{
                vault_id          : arg4,
                before_sqrt_price : v0,
                after_sqrt_price  : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1),
                is_a              : true,
                amount_in         : v8,
                amount_out        : 0x2::coin::value<T1>(&v13),
                timestamp_ms      : 0x2::clock::timestamp_ms(arg5),
            };
            0x2::event::emit<SwapIfZeroEvent>(v14);
            0x2::balance::join<T1>(arg3, 0x2::coin::into_balance<T1>(v13));
        };
    }

    // decompiled from Move bytecode v6
}

