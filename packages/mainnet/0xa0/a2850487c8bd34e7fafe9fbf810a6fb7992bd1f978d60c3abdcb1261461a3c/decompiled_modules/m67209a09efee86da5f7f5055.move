module 0xa0a2850487c8bd34e7fafe9fbf810a6fb7992bd1f978d60c3abdcb1261461a3c::m67209a09efee86da5f7f5055 {
    public(friend) fun f0e8402d70bd781c43e804356<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u128, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, true, 0x2::coin::value<T0>(&arg2), arg4, arg5);
        let v3 = v2;
        let v4 = v1;
        0x2::balance::destroy_zero<T0>(v0);
        assert!(0x2::balance::value<T1>(&v4) >= arg3, 0);
        let v5 = 0x2::coin::into_balance<T0>(arg2);
        0x2::balance::destroy_zero<T0>(v5);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(&mut v5, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3)), 0x2::balance::zero<T1>(), v3);
        0x2::coin::from_balance<T1>(v4, arg6)
    }

    public(friend) fun f216c2b4a3945d04c71552809<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: u128, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, false, true, 0x2::coin::value<T1>(&arg2), arg4, arg5);
        let v3 = v2;
        let v4 = v0;
        0x2::balance::destroy_zero<T1>(v1);
        assert!(0x2::balance::value<T0>(&v4) >= arg3, 0);
        let v5 = 0x2::coin::into_balance<T1>(arg2);
        0x2::balance::destroy_zero<T1>(v5);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v5, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3)), v3);
        0x2::coin::from_balance<T0>(v4, arg6)
    }

    // decompiled from Move bytecode v7
}

