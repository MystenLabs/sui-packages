module 0xacda4f87f55a978c99a9b343bebfc3fff8c204d59bf955aef89c60131b00f66a::migrate {
    public fun add_final_lp<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x40b6713907acadc6c8b8d9d98f36d2f24f80bd08440d5477f9f868e3b5e1e12d::pool::Pool<T0, T1>, arg3: &mut 0x40b6713907acadc6c8b8d9d98f36d2f24f80bd08440d5477f9f868e3b5e1e12d::position::Position, arg4: &0x2::clock::Clock, arg5: &0x40b6713907acadc6c8b8d9d98f36d2f24f80bd08440d5477f9f868e3b5e1e12d::version::Version, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0x40b6713907acadc6c8b8d9d98f36d2f24f80bd08440d5477f9f868e3b5e1e12d::liquidity::add_liquidity<T0, T1>(arg2, arg3, arg0, arg1, 0, 0, arg4, arg5, arg6)
    }

    public fun fix_add_lp_residual<T0, T1>(arg0: u128, arg1: u128, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: &mut 0x40b6713907acadc6c8b8d9d98f36d2f24f80bd08440d5477f9f868e3b5e1e12d::pool::Pool<T0, T1>, arg5: &0x2::clock::Clock, arg6: &0x40b6713907acadc6c8b8d9d98f36d2f24f80bd08440d5477f9f868e3b5e1e12d::version::Version, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, u64, 0x40b6713907acadc6c8b8d9d98f36d2f24f80bd08440d5477f9f868e3b5e1e12d::position::Position) {
        let v0 = 0x40b6713907acadc6c8b8d9d98f36d2f24f80bd08440d5477f9f868e3b5e1e12d::tick_math::get_tick_at_sqrt_price(arg0);
        let v1 = 0x40b6713907acadc6c8b8d9d98f36d2f24f80bd08440d5477f9f868e3b5e1e12d::tick_math::get_tick_at_sqrt_price(arg1);
        let v2 = 0x40b6713907acadc6c8b8d9d98f36d2f24f80bd08440d5477f9f868e3b5e1e12d::i32::from(0x40b6713907acadc6c8b8d9d98f36d2f24f80bd08440d5477f9f868e3b5e1e12d::pool::tick_spacing<T0, T1>(arg4));
        let v3 = 0x40b6713907acadc6c8b8d9d98f36d2f24f80bd08440d5477f9f868e3b5e1e12d::i32::sub(v1, 0x40b6713907acadc6c8b8d9d98f36d2f24f80bd08440d5477f9f868e3b5e1e12d::i32::mod(v1, v2));
        let v4 = 0x40b6713907acadc6c8b8d9d98f36d2f24f80bd08440d5477f9f868e3b5e1e12d::i32::sub(v0, 0x40b6713907acadc6c8b8d9d98f36d2f24f80bd08440d5477f9f868e3b5e1e12d::i32::mod(v0, v2));
        let (v5, v6, v7) = 0xacda4f87f55a978c99a9b343bebfc3fff8c204d59bf955aef89c60131b00f66a::utils::check_is_fix_coin_a(0x40b6713907acadc6c8b8d9d98f36d2f24f80bd08440d5477f9f868e3b5e1e12d::tick_math::get_sqrt_price_at_tick(v4), 0x40b6713907acadc6c8b8d9d98f36d2f24f80bd08440d5477f9f868e3b5e1e12d::tick_math::get_sqrt_price_at_tick(v3), 0x40b6713907acadc6c8b8d9d98f36d2f24f80bd08440d5477f9f868e3b5e1e12d::pool::sqrt_price<T0, T1>(arg4), 0x2::coin::value<T0>(&arg2), 0x2::coin::value<T1>(&arg3));
        let v8 = 0x40b6713907acadc6c8b8d9d98f36d2f24f80bd08440d5477f9f868e3b5e1e12d::liquidity::open_position<T0, T1>(arg4, v4, v3, arg6, arg7);
        if (v5) {
            let (v9, v10) = 0x40b6713907acadc6c8b8d9d98f36d2f24f80bd08440d5477f9f868e3b5e1e12d::liquidity::add_liquidity<T0, T1>(arg4, &mut v8, arg2, 0x2::coin::split<T1>(&mut arg3, v7, arg7), 0, 0, arg5, arg6, arg7);
            let (v11, _) = 0x40b6713907acadc6c8b8d9d98f36d2f24f80bd08440d5477f9f868e3b5e1e12d::trade::get_optimal_swap_amount_for_single_sided_liquidity<T0, T1>(arg4, 0x2::coin::value<T1>(&arg3), &v8, 79226673515401279992447579054, false, 10);
            return (v9, v10, 0x2::coin::zero<T0>(arg7), arg3, v11, v8)
        };
        let (v13, v14) = 0x40b6713907acadc6c8b8d9d98f36d2f24f80bd08440d5477f9f868e3b5e1e12d::liquidity::add_liquidity<T0, T1>(arg4, &mut v8, 0x2::coin::split<T0>(&mut arg2, v6, arg7), arg3, 0, 0, arg5, arg6, arg7);
        let (v15, _) = 0x40b6713907acadc6c8b8d9d98f36d2f24f80bd08440d5477f9f868e3b5e1e12d::trade::get_optimal_swap_amount_for_single_sided_liquidity<T0, T1>(arg4, 0x2::coin::value<T0>(&arg2), &v8, 4295048017, true, 10);
        (v13, v14, arg2, 0x2::coin::zero<T1>(arg7), v15, v8)
    }

    // decompiled from Move bytecode v6
}

