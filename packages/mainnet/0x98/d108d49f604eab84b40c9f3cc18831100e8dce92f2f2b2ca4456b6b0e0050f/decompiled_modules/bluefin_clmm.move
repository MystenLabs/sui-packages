module 0x98d108d49f604eab84b40c9f3cc18831100e8dce92f2f2b2ca4456b6b0e0050f::bluefin_clmm {
    public fun bluefin_clmm_add_liquidity<T0, T1>(arg0: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &0x2::clock::Clock, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::lower_tick(arg3));
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::upper_tick(arg3));
        let v2 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg0);
        let v3 = 0;
        let v4 = 0;
        if (v2 < v1) {
            let v5 = if (v2 <= v0) {
                0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_liquidity_from_a(v0, v1, 0x2::coin::value<T0>(&arg4), false)
            } else {
                0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_liquidity_from_a(v2, v1, 0x2::coin::value<T0>(&arg4), false)
            };
            v3 = v5;
        };
        if (v2 > v0) {
            let v6 = if (v2 >= v1) {
                0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_liquidity_from_b(v0, v1, 0x2::coin::value<T1>(&arg5), false)
            } else {
                0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_liquidity_from_b(v0, v2, 0x2::coin::value<T1>(&arg5), false)
            };
            v4 = v6;
        };
        let v7 = if (v2 <= v0) {
            v3
        } else if (v2 >= v1) {
            v4
        } else if (v3 < v4) {
            v3
        } else {
            v4
        };
        if (v7 == 0) {
            return (arg4, arg5)
        };
        let (_, _, v10, v11) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity<T0, T1>(arg2, arg1, arg0, arg3, 0x2::coin::into_balance<T0>(arg4), 0x2::coin::into_balance<T1>(arg5), v7);
        (0x2::coin::from_balance<T0>(v10, arg6), 0x2::coin::from_balance<T1>(v11, arg6))
    }

    public fun bluefin_clmm_close_position<T0, T1>(arg0: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &0x2::clock::Clock, arg3: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position) {
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::close_position_v2<T0, T1>(arg2, arg1, arg0, arg3);
    }

    public fun bluefin_clmm_collect_fee<T0, T1>(arg0: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &0x2::clock::Clock, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg4: bool, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let (_, _, v2, v3) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_fee<T0, T1>(arg2, arg1, arg0, arg3);
        let v4 = v3;
        let v5 = v2;
        if (arg4) {
            0x2::balance::join<T0>(&mut v5, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, T0>(arg2, arg1, arg0, arg3));
        };
        if (arg5) {
            0x2::balance::join<T1>(&mut v4, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, T1>(arg2, arg1, arg0, arg3));
        };
        (0x2::coin::from_balance<T0>(v5, arg6), 0x2::coin::from_balance<T1>(v4, arg6))
    }

    public fun bluefin_clmm_collect_reward<T0, T1, T2>(arg0: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &0x2::clock::Clock, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0x2::coin::from_balance<T2>(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, T2>(arg2, arg1, arg0, arg3), arg4)
    }

    public fun bluefin_clmm_flashswap_a2b<T0, T1>(arg0: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &0x2::clock::Clock, arg3: u64, arg4: u128, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::FlashSwapReceipt<T0, T1>) {
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg2, arg1, arg0, true, true, arg3, arg4);
        0x2::balance::destroy_zero<T0>(v0);
        (0x2::coin::from_balance<T1>(v1, arg5), v2)
    }

    public fun bluefin_clmm_flashswap_b2a<T0, T1>(arg0: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &0x2::clock::Clock, arg3: u64, arg4: u128, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::FlashSwapReceipt<T0, T1>) {
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg2, arg1, arg0, false, true, arg3, arg4);
        0x2::balance::destroy_zero<T1>(v1);
        (0x2::coin::from_balance<T0>(v0, arg5), v2)
    }

    public fun bluefin_clmm_open_position<T0, T1>(arg0: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: u32, arg3: u32, arg4: &mut 0x2::tx_context::TxContext) : 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position {
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<T0, T1>(arg1, arg0, arg2, arg3, arg4)
    }

    public fun bluefin_clmm_remove_liquidity<T0, T1>(arg0: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &0x2::clock::Clock, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg4: u128, arg5: bool, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        if (arg4 == 0) {
            arg4 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(arg3);
        };
        let (v0, v1) = if (arg4 > 0) {
            let (v2, v3, v4, v5) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::remove_liquidity<T0, T1>(arg1, arg0, arg3, arg4, arg2);
            let _ = v3;
            let _ = v2;
            (v4, v5)
        } else {
            let _ = 0;
            let _ = 0;
            (0x2::balance::zero<T0>(), 0x2::balance::zero<T1>())
        };
        let v8 = v1;
        let v9 = v0;
        let (_, _, v12, v13) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_fee<T0, T1>(arg2, arg1, arg0, arg3);
        0x2::balance::join<T0>(&mut v9, v12);
        0x2::balance::join<T1>(&mut v8, v13);
        if (arg5) {
            0x2::balance::join<T0>(&mut v9, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, T0>(arg2, arg1, arg0, arg3));
        };
        if (arg6) {
            0x2::balance::join<T1>(&mut v8, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, T1>(arg2, arg1, arg0, arg3));
        };
        (0x2::coin::from_balance<T0>(v9, arg7), 0x2::coin::from_balance<T1>(v8, arg7))
    }

    public fun bluefin_clmm_repay_flashswap_a2b<T0, T1>(arg0: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: 0x2::coin::Coin<T0>, arg3: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::FlashSwapReceipt<T0, T1>) {
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg1, arg0, 0x2::coin::into_balance<T0>(arg2), 0x2::balance::zero<T1>(), arg3);
    }

    public fun bluefin_clmm_repay_flashswap_b2a<T0, T1>(arg0: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: 0x2::coin::Coin<T1>, arg3: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::FlashSwapReceipt<T0, T1>) {
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg1, arg0, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(arg2), arg3);
    }

    public fun bluefin_clmm_swap_a2b<T0, T1>(arg0: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<T0>, arg4: u128, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let (v0, v1) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, T1>(arg2, arg1, arg0, 0x2::coin::into_balance<T0>(arg3), 0x2::balance::zero<T1>(), true, true, 0x2::coin::value<T0>(&arg3), 0, arg4);
        0x2::balance::destroy_zero<T0>(v0);
        0x2::coin::from_balance<T1>(v1, arg5)
    }

    public fun bluefin_clmm_swap_b2a<T0, T1>(arg0: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<T1>, arg4: u128, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, T1>(arg2, arg1, arg0, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(arg3), false, true, 0x2::coin::value<T1>(&arg3), 0, arg4);
        0x2::balance::destroy_zero<T1>(v1);
        0x2::coin::from_balance<T0>(v0, arg5)
    }

    fun transfer_or_destroy_balance<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg1), 0x2::tx_context::sender(arg1));
        } else {
            0x2::balance::destroy_zero<T0>(arg0);
        };
    }

    // decompiled from Move bytecode v7
}

