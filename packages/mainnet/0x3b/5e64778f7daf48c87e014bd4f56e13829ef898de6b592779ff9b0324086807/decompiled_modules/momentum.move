module 0x3b5e64778f7daf48c87e014bd4f56e13829ef898de6b592779ff9b0324086807::momentum {
    public fun append_model_a_to_b<T0, T1>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: 0xb83f53c08b28f20b9c232d06096d673f1dd738a599185bad631adbbf3dfbbb03::optimizer::RouteFormula) : 0xb83f53c08b28f20b9c232d06096d673f1dd738a599185bad631adbbf3dfbbb03::optimizer::RouteFormula {
        0xb83f53c08b28f20b9c232d06096d673f1dd738a599185bad631adbbf3dfbbb03::optimizer::append_v3_edge(arg1, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::liquidity<T0, T1>(arg0), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::sqrt_price<T0, T1>(arg0), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::swap_fee_rate<T0, T1>(arg0), 1000000, true)
    }

    public fun append_model_b_to_a<T0, T1>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: 0xb83f53c08b28f20b9c232d06096d673f1dd738a599185bad631adbbf3dfbbb03::optimizer::RouteFormula) : 0xb83f53c08b28f20b9c232d06096d673f1dd738a599185bad631adbbf3dfbbb03::optimizer::RouteFormula {
        0xb83f53c08b28f20b9c232d06096d673f1dd738a599185bad631adbbf3dfbbb03::optimizer::append_v3_edge(arg1, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::liquidity<T0, T1>(arg0), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::sqrt_price<T0, T1>(arg0), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::swap_fee_rate<T0, T1>(arg0), 1000000, false)
    }

    public fun flash_a_to_b<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: 0xb83f53c08b28f20b9c232d06096d673f1dd738a599185bad631adbbf3dfbbb03::optimizer::RouteFormula, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T0>, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::FlashSwapReceipt) {
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg0, true, true, 0xb83f53c08b28f20b9c232d06096d673f1dd738a599185bad631adbbf3dfbbb03::optimizer::select_input(0xb83f53c08b28f20b9c232d06096d673f1dd738a599185bad631adbbf3dfbbb03::optimizer::prepend_v3_edge(arg2, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::liquidity<T0, T1>(arg0), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::sqrt_price<T0, T1>(arg0), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::swap_fee_rate<T0, T1>(arg0), 1000000, true), arg3, arg4), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::min_sqrt_price(), arg5, arg1, arg6);
        (v1, v0, v2)
    }

    public fun flash_b_to_a<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: 0xb83f53c08b28f20b9c232d06096d673f1dd738a599185bad631adbbf3dfbbb03::optimizer::RouteFormula, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::FlashSwapReceipt) {
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg0, false, true, 0xb83f53c08b28f20b9c232d06096d673f1dd738a599185bad631adbbf3dfbbb03::optimizer::select_input(0xb83f53c08b28f20b9c232d06096d673f1dd738a599185bad631adbbf3dfbbb03::optimizer::prepend_v3_edge(arg2, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::liquidity<T0, T1>(arg0), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::sqrt_price<T0, T1>(arg0), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::swap_fee_rate<T0, T1>(arg0), 1000000, false), arg3, arg4), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::max_sqrt_price(), arg5, arg1, arg6)
    }

    public fun model_a_to_b<T0, T1>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>) : 0xb83f53c08b28f20b9c232d06096d673f1dd738a599185bad631adbbf3dfbbb03::optimizer::RouteFormula {
        0xb83f53c08b28f20b9c232d06096d673f1dd738a599185bad631adbbf3dfbbb03::optimizer::v3_route(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::liquidity<T0, T1>(arg0), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::sqrt_price<T0, T1>(arg0), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::swap_fee_rate<T0, T1>(arg0), 1000000, true)
    }

    public fun model_b_to_a<T0, T1>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>) : 0xb83f53c08b28f20b9c232d06096d673f1dd738a599185bad631adbbf3dfbbb03::optimizer::RouteFormula {
        0xb83f53c08b28f20b9c232d06096d673f1dd738a599185bad631adbbf3dfbbb03::optimizer::v3_route(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::liquidity<T0, T1>(arg0), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::sqrt_price<T0, T1>(arg0), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::swap_fee_rate<T0, T1>(arg0), 1000000, false)
    }

    public fun settle_a_to_b<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T0>, arg4: 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::FlashSwapReceipt, arg5: &mut 0x2::coin::Coin<T0>, arg6: &0x2::tx_context::TxContext) {
        let (v0, _) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&arg4);
        0x2::balance::join<T0>(&mut arg3, 0x2::balance::split<T0>(&mut arg2, v0));
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg0, arg4, arg3, 0x2::balance::zero<T1>(), arg1, arg6);
        0x2::balance::join<T0>(0x2::coin::balance_mut<T0>(arg5), arg2);
    }

    public fun settle_b_to_a<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: 0x2::balance::Balance<T1>, arg3: 0x2::balance::Balance<T1>, arg4: 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::FlashSwapReceipt, arg5: &mut 0x2::coin::Coin<T1>, arg6: &0x2::tx_context::TxContext) {
        let (_, v1) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&arg4);
        0x2::balance::join<T1>(&mut arg3, 0x2::balance::split<T1>(&mut arg2, v1));
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg0, arg4, 0x2::balance::zero<T0>(), arg3, arg1, arg6);
        0x2::balance::join<T1>(0x2::coin::balance_mut<T1>(arg5), arg2);
    }

    public fun swap_exact_in_a_to_b<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let v0 = 0x2::balance::value<T0>(&arg2);
        let (v1, v2, v3) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg0, true, true, v0, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::min_sqrt_price(), arg3, arg1, arg4);
        let v4 = v3;
        let v5 = v1;
        let (v6, v7) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v4);
        assert!(v6 == v0, 1);
        assert!(v7 == 0, 2);
        0x2::balance::join<T0>(&mut v5, arg2);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg0, v4, v5, 0x2::balance::zero<T1>(), arg1, arg4);
        v2
    }

    public fun swap_exact_in_b_to_a<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: 0x2::balance::Balance<T1>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::balance::value<T1>(&arg2);
        let (v1, v2, v3) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg0, false, true, v0, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::max_sqrt_price(), arg3, arg1, arg4);
        let v4 = v3;
        let v5 = v2;
        let (v6, v7) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v4);
        assert!(v6 == 0, 2);
        assert!(v7 == v0, 1);
        0x2::balance::join<T1>(&mut v5, arg2);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg0, v4, 0x2::balance::zero<T0>(), v5, arg1, arg4);
        v1
    }

    // decompiled from Move bytecode v7
}

