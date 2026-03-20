module 0x32951dc761707d4243f42725787074fd36f217bfb25162e59e3222fd56655c2b::momentum_agg {
    struct MomentumAgg has drop {
        dummy_field: bool,
    }

    public fun swap<T0, T1>(arg0: &0x34a3cefd2e70bef775b5ab069a06c041431d239a064fa8338b85f4205b44051::router::Router, arg1: &mut 0x34a3cefd2e70bef775b5ab069a06c041431d239a064fa8338b85f4205b44051::swap::SwapContext, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: bool, arg5: u64, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        let (v0, v1) = if (arg4) {
            let v2 = MomentumAgg{dummy_field: false};
            swap_a2b<T0, T1>(arg2, arg3, 0x34a3cefd2e70bef775b5ab069a06c041431d239a064fa8338b85f4205b44051::swap::take_balance<MomentumAgg, T0>(arg1, arg0, v2, arg5), arg6, arg7)
        } else {
            let v3 = MomentumAgg{dummy_field: false};
            swap_b2a<T0, T1>(arg2, arg3, 0x34a3cefd2e70bef775b5ab069a06c041431d239a064fa8338b85f4205b44051::swap::take_balance<MomentumAgg, T1>(arg1, arg0, v3, arg5), arg6, arg7)
        };
        let v4 = v1;
        let v5 = v0;
        if (0x2::balance::value<T0>(&v5) > 0) {
            0x34a3cefd2e70bef775b5ab069a06c041431d239a064fa8338b85f4205b44051::swap::put_balance<T0>(arg1, v5);
        } else {
            0x2::balance::destroy_zero<T0>(v5);
        };
        if (0x2::balance::value<T1>(&v4) > 0) {
            0x34a3cefd2e70bef775b5ab069a06c041431d239a064fa8338b85f4205b44051::swap::put_balance<T1>(arg1, v4);
        } else {
            0x2::balance::destroy_zero<T1>(v4);
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

