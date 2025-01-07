module 0x3bb094ce8ec90be6d0da8925b6c239ed43a4602f2198f47e7d156f4be9ac6617::swap {
    public fun add_final_lp<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x40b6713907acadc6c8b8d9d98f36d2f24f80bd08440d5477f9f868e3b5e1e12d::pool::Pool<T0, T1>, arg3: &mut 0x40b6713907acadc6c8b8d9d98f36d2f24f80bd08440d5477f9f868e3b5e1e12d::position::Position, arg4: &0x2::clock::Clock, arg5: &0x40b6713907acadc6c8b8d9d98f36d2f24f80bd08440d5477f9f868e3b5e1e12d::version::Version, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0x40b6713907acadc6c8b8d9d98f36d2f24f80bd08440d5477f9f868e3b5e1e12d::liquidity::add_liquidity<T0, T1>(arg2, arg3, arg0, arg1, 0, 0, arg4, arg5, arg6)
    }

    public fun fix_add_lp_residual<T0, T1>(arg0: u128, arg1: u128, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: &mut 0x40b6713907acadc6c8b8d9d98f36d2f24f80bd08440d5477f9f868e3b5e1e12d::pool::Pool<T0, T1>, arg5: &0x2::clock::Clock, arg6: &0x40b6713907acadc6c8b8d9d98f36d2f24f80bd08440d5477f9f868e3b5e1e12d::version::Version, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, u64, 0x40b6713907acadc6c8b8d9d98f36d2f24f80bd08440d5477f9f868e3b5e1e12d::position::Position) {
        let (v0, v1, v2) = 0x3bb094ce8ec90be6d0da8925b6c239ed43a4602f2198f47e7d156f4be9ac6617::utils::check_is_fix_coin_a(arg0, arg1, 0x2::coin::value<T0>(&arg2), 0x2::coin::value<T1>(&arg3));
        let v3 = 0x40b6713907acadc6c8b8d9d98f36d2f24f80bd08440d5477f9f868e3b5e1e12d::liquidity::open_position<T0, T1>(arg4, 0x40b6713907acadc6c8b8d9d98f36d2f24f80bd08440d5477f9f868e3b5e1e12d::tick_math::get_tick_at_sqrt_price(arg1), 0x40b6713907acadc6c8b8d9d98f36d2f24f80bd08440d5477f9f868e3b5e1e12d::tick_math::get_tick_at_sqrt_price(arg0), arg6, arg7);
        if (v0) {
            let (v4, v5) = 0x40b6713907acadc6c8b8d9d98f36d2f24f80bd08440d5477f9f868e3b5e1e12d::liquidity::add_liquidity<T0, T1>(arg4, &mut v3, arg2, 0x2::coin::split<T1>(&mut arg3, v2, arg7), 0, 0, arg5, arg6, arg7);
            let (v6, _) = 0x40b6713907acadc6c8b8d9d98f36d2f24f80bd08440d5477f9f868e3b5e1e12d::trade::get_optimal_swap_amount_for_single_sided_liquidity<T0, T1>(arg4, 0x2::coin::value<T1>(&arg3), &v3, 79226673515401279992447579055, false, 20);
            return (v4, v5, 0x2::coin::zero<T0>(arg7), arg3, v6, v3)
        };
        let (v8, v9) = 0x40b6713907acadc6c8b8d9d98f36d2f24f80bd08440d5477f9f868e3b5e1e12d::liquidity::add_liquidity<T0, T1>(arg4, &mut v3, 0x2::coin::split<T0>(&mut arg2, v1, arg7), arg3, 0, 0, arg5, arg6, arg7);
        let (v10, _) = 0x40b6713907acadc6c8b8d9d98f36d2f24f80bd08440d5477f9f868e3b5e1e12d::trade::get_optimal_swap_amount_for_single_sided_liquidity<T0, T1>(arg4, 0x2::coin::value<T0>(&arg2), &v3, 4295048016, true, 20);
        (v8, v9, arg2, 0x2::coin::zero<T1>(arg7), v10, v3)
    }

    public fun swap_cetus<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(0x2::coin::value<T0>(&arg0) == 0 || 0x2::coin::value<T1>(&arg1) == 0, 0);
        if (0x2::coin::value<T0>(&arg0) == 0) {
            let (v0, v1) = 0x3bb094ce8ec90be6d0da8925b6c239ed43a4602f2198f47e7d156f4be9ac6617::utils::cetus_swap<T0, T1>(arg4, arg3, arg0, 0x2::coin::split<T1>(&mut arg1, arg2, arg6), false, true, arg2, 79226673515401279992447579055, arg5, arg6);
            0x2::coin::destroy_zero<T1>(v1);
            return (v0, arg1)
        };
        let (v2, v3) = 0x3bb094ce8ec90be6d0da8925b6c239ed43a4602f2198f47e7d156f4be9ac6617::utils::cetus_swap<T0, T1>(arg4, arg3, 0x2::coin::split<T0>(&mut arg0, arg2, arg6), arg1, true, true, arg2, 4295048016, arg5, arg6);
        0x2::coin::destroy_zero<T0>(v2);
        (arg0, v3)
    }

    public fun swap_kriya<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: &mut 0x40b6713907acadc6c8b8d9d98f36d2f24f80bd08440d5477f9f868e3b5e1e12d::pool::Pool<T0, T1>, arg4: &0x40b6713907acadc6c8b8d9d98f36d2f24f80bd08440d5477f9f868e3b5e1e12d::version::Version, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(0x2::coin::value<T0>(&arg0) == 0 || 0x2::coin::value<T1>(&arg1) == 0, 0);
        if (0x2::coin::value<T0>(&arg0) == 0) {
            let (v0, v1) = 0x3bb094ce8ec90be6d0da8925b6c239ed43a4602f2198f47e7d156f4be9ac6617::utils::kriya_swap<T0, T1>(arg3, arg0, 0x2::coin::split<T1>(&mut arg1, arg2, arg6), false, true, arg2, 79226673515401279992447579055, arg5, arg4, arg6);
            0x2::coin::destroy_zero<T1>(v1);
            return (v0, arg1)
        };
        let (v2, v3) = 0x3bb094ce8ec90be6d0da8925b6c239ed43a4602f2198f47e7d156f4be9ac6617::utils::kriya_swap<T0, T1>(arg3, 0x2::coin::split<T0>(&mut arg0, arg2, arg6), arg1, true, true, arg2, 4295048016, arg5, arg4, arg6);
        0x2::coin::destroy_zero<T0>(v2);
        (arg0, v3)
    }

    // decompiled from Move bytecode v6
}

