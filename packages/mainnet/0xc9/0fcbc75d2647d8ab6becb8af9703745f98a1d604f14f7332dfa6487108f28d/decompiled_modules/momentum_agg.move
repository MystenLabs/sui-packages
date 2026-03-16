module 0xc90fcbc75d2647d8ab6becb8af9703745f98a1d604f14f7332dfa6487108f28d::momentum_agg {
    public fun swap<T0, T1, T2>(arg0: &mut 0xc90fcbc75d2647d8ab6becb8af9703745f98a1d604f14f7332dfa6487108f28d::custom_liquidate::CustomLiquidateReceipt<T0>, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T2>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: bool, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        let (v0, v1) = if (arg3) {
            swap_a2b<T1, T2>(arg1, arg2, 0xc90fcbc75d2647d8ab6becb8af9703745f98a1d604f14f7332dfa6487108f28d::custom_liquidate::take_balance<T0, T1>(arg0, arg4), arg5, arg6)
        } else {
            swap_b2a<T1, T2>(arg1, arg2, 0xc90fcbc75d2647d8ab6becb8af9703745f98a1d604f14f7332dfa6487108f28d::custom_liquidate::take_balance<T0, T2>(arg0, arg4), arg5, arg6)
        };
        let v2 = v1;
        let v3 = v0;
        if (0x2::balance::value<T1>(&v3) > 0) {
            0xc90fcbc75d2647d8ab6becb8af9703745f98a1d604f14f7332dfa6487108f28d::custom_liquidate::put_balance<T0, T1>(arg0, v3);
        } else {
            0x2::balance::destroy_zero<T1>(v3);
        };
        if (0x2::balance::value<T2>(&v2) > 0) {
            0xc90fcbc75d2647d8ab6becb8af9703745f98a1d604f14f7332dfa6487108f28d::custom_liquidate::put_balance<T0, T2>(arg0, v2);
        } else {
            0x2::balance::destroy_zero<T2>(v2);
        };
    }

    fun swap_a2b<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = 0x2::balance::value<T0>(&arg2);
        if (v0 == 0) {
            0x2::balance::destroy_zero<T0>(arg2);
            return (0x2::balance::zero<T0>(), 0x2::balance::zero<T1>())
        };
        let (v1, v2, v3) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg0, true, true, v0, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::min_sqrt_price(), arg3, arg1, arg4);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg0, v3, arg2, 0x2::balance::zero<T1>(), arg1, arg4);
        (v1, v2)
    }

    fun swap_b2a<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: 0x2::balance::Balance<T1>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = 0x2::balance::value<T1>(&arg2);
        if (v0 == 0) {
            0x2::balance::destroy_zero<T1>(arg2);
            return (0x2::balance::zero<T0>(), 0x2::balance::zero<T1>())
        };
        let (v1, v2, v3) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg0, false, true, v0, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::max_sqrt_price(), arg3, arg1, arg4);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg0, v3, 0x2::balance::zero<T0>(), arg2, arg1, arg4);
        (v1, v2)
    }

    // decompiled from Move bytecode v6
}

