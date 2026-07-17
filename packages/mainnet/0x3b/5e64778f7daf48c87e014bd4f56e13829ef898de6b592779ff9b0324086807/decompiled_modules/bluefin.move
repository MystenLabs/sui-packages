module 0x3b5e64778f7daf48c87e014bd4f56e13829ef898de6b592779ff9b0324086807::bluefin {
    public fun append_model_a_to_b<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: 0xb83f53c08b28f20b9c232d06096d673f1dd738a599185bad631adbbf3dfbbb03::optimizer::RouteFormula) : 0xb83f53c08b28f20b9c232d06096d673f1dd738a599185bad631adbbf3dfbbb03::optimizer::RouteFormula {
        0xb83f53c08b28f20b9c232d06096d673f1dd738a599185bad631adbbf3dfbbb03::optimizer::append_v3_edge(arg1, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::liquidity<T0, T1>(arg0), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg0), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_fee_rate<T0, T1>(arg0), 1000000, true)
    }

    public fun append_model_b_to_a<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: 0xb83f53c08b28f20b9c232d06096d673f1dd738a599185bad631adbbf3dfbbb03::optimizer::RouteFormula) : 0xb83f53c08b28f20b9c232d06096d673f1dd738a599185bad631adbbf3dfbbb03::optimizer::RouteFormula {
        0xb83f53c08b28f20b9c232d06096d673f1dd738a599185bad631adbbf3dfbbb03::optimizer::append_v3_edge(arg1, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::liquidity<T0, T1>(arg0), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg0), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_fee_rate<T0, T1>(arg0), 1000000, false)
    }

    public fun flash_a_to_b<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: 0xb83f53c08b28f20b9c232d06096d673f1dd738a599185bad631adbbf3dfbbb03::optimizer::RouteFormula, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T0>, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::FlashSwapReceipt<T0, T1>) {
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg5, arg0, arg1, true, true, 0xb83f53c08b28f20b9c232d06096d673f1dd738a599185bad631adbbf3dfbbb03::optimizer::select_input(0xb83f53c08b28f20b9c232d06096d673f1dd738a599185bad631adbbf3dfbbb03::optimizer::prepend_v3_edge(arg2, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::liquidity<T0, T1>(arg1), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg1), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_fee_rate<T0, T1>(arg1), 1000000, true), arg3, arg4), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick_math::min_sqrt_price() + 1);
        (v1, v0, v2)
    }

    public fun flash_b_to_a<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: 0xb83f53c08b28f20b9c232d06096d673f1dd738a599185bad631adbbf3dfbbb03::optimizer::RouteFormula, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::FlashSwapReceipt<T0, T1>) {
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg5, arg0, arg1, false, true, 0xb83f53c08b28f20b9c232d06096d673f1dd738a599185bad631adbbf3dfbbb03::optimizer::select_input(0xb83f53c08b28f20b9c232d06096d673f1dd738a599185bad631adbbf3dfbbb03::optimizer::prepend_v3_edge(arg2, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::liquidity<T0, T1>(arg1), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg1), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_fee_rate<T0, T1>(arg1), 1000000, false), arg3, arg4), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick_math::max_sqrt_price() - 1)
    }

    public fun model_a_to_b<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>) : 0xb83f53c08b28f20b9c232d06096d673f1dd738a599185bad631adbbf3dfbbb03::optimizer::RouteFormula {
        0xb83f53c08b28f20b9c232d06096d673f1dd738a599185bad631adbbf3dfbbb03::optimizer::v3_route(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::liquidity<T0, T1>(arg0), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg0), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_fee_rate<T0, T1>(arg0), 1000000, true)
    }

    public fun model_b_to_a<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>) : 0xb83f53c08b28f20b9c232d06096d673f1dd738a599185bad631adbbf3dfbbb03::optimizer::RouteFormula {
        0xb83f53c08b28f20b9c232d06096d673f1dd738a599185bad631adbbf3dfbbb03::optimizer::v3_route(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::liquidity<T0, T1>(arg0), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg0), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_fee_rate<T0, T1>(arg0), 1000000, false)
    }

    public fun settle_a_to_b<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T0>, arg4: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::FlashSwapReceipt<T0, T1>, arg5: &mut 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg3, 0x2::balance::split<T0>(&mut arg2, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T1>(&arg4)));
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg0, arg1, arg3, 0x2::balance::zero<T1>(), arg4);
        0x2::balance::join<T0>(0x2::coin::balance_mut<T0>(arg5), arg2);
    }

    public fun settle_b_to_a<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T1>, arg3: 0x2::balance::Balance<T1>, arg4: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::FlashSwapReceipt<T0, T1>, arg5: &mut 0x2::coin::Coin<T1>) {
        0x2::balance::join<T1>(&mut arg3, 0x2::balance::split<T1>(&mut arg2, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T1>(&arg4)));
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), arg3, arg4);
        0x2::balance::join<T1>(0x2::coin::balance_mut<T1>(arg5), arg2);
    }

    public fun swap_exact_in_a_to_b<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock) : 0x2::balance::Balance<T1> {
        let v0 = 0x2::balance::value<T0>(&arg2);
        let (v1, v2, v3) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg3, arg0, arg1, true, true, v0, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick_math::min_sqrt_price() + 1);
        let v4 = v3;
        let v5 = v1;
        assert!(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T1>(&v4) == v0, 1);
        0x2::balance::join<T0>(&mut v5, arg2);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg0, arg1, v5, 0x2::balance::zero<T1>(), v4);
        v2
    }

    public fun swap_exact_in_b_to_a<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T1>, arg3: &0x2::clock::Clock) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::balance::value<T1>(&arg2);
        let (v1, v2, v3) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg3, arg0, arg1, false, true, v0, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick_math::max_sqrt_price() - 1);
        let v4 = v3;
        let v5 = v2;
        assert!(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T1>(&v4) == v0, 1);
        0x2::balance::join<T1>(&mut v5, arg2);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), v5, v4);
        v1
    }

    // decompiled from Move bytecode v7
}

