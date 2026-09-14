module 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::swap {
    public fun exact_in_a_to_b<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T0>) {
        assert!(0x2::clock::timestamp_ms(arg5) <= arg4, 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::errors::deadline_expired());
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0 && arg3 > 0, 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::errors::zero_amount());
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, true, v0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_sqrt_price() + 1, arg5);
        let v4 = v3;
        let v5 = v2;
        assert!(0x2::balance::value<T1>(&v5) >= arg3, 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::errors::slippage_exceeded());
        let v6 = 0x2::coin::into_balance<T0>(arg2);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(&mut v6, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v4)), 0x2::balance::zero<T1>(), v4);
        0x2::balance::destroy_zero<T0>(v1);
        (0x2::coin::from_balance<T1>(v5, arg6), 0x2::coin::from_balance<T0>(v6, arg6))
    }

    public fun exact_in_b_to_a<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(0x2::clock::timestamp_ms(arg5) <= arg4, 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::errors::deadline_expired());
        let v0 = 0x2::coin::value<T1>(&arg2);
        assert!(v0 > 0 && arg3 > 0, 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::errors::zero_amount());
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, false, true, v0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price() - 1, arg5);
        let v4 = v3;
        let v5 = v1;
        assert!(0x2::balance::value<T0>(&v5) >= arg3, 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::errors::slippage_exceeded());
        let v6 = 0x2::coin::into_balance<T1>(arg2);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v6, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v4)), v4);
        0x2::balance::destroy_zero<T1>(v2);
        (0x2::coin::from_balance<T0>(v5, arg6), 0x2::coin::from_balance<T1>(v6, arg6))
    }

    // decompiled from Move bytecode v7
}

