module 0xd3facfe140fc40d4d170aae42c12b1d8d014df094f84301c5bbe6b513bb4577::cetus {
    public fun swap_a2b<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg3, arg2, true, true, 0x2::coin::value<T0>(&arg0), 4295048017, arg4);
        let v3 = v1;
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg3, arg2, 0x2::coin::into_balance<T0>(arg0), 0x2::balance::zero<T1>(), v2);
        0xd3facfe140fc40d4d170aae42c12b1d8d014df094f84301c5bbe6b513bb4577::bbag::transfer_or_destroy_balance<T0>(v0, arg5);
        assert!(0x2::balance::value<T1>(&v3) >= arg1, 2);
        0x2::coin::from_balance<T1>(v3, arg5)
    }

    public fun swap_b2a<T0, T1>(arg0: 0x2::coin::Coin<T1>, arg1: u64, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg3, arg2, false, true, 0x2::coin::value<T1>(&arg0), 79226673515401279992447579054, arg4);
        let v3 = v0;
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg3, arg2, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(arg0), v2);
        0xd3facfe140fc40d4d170aae42c12b1d8d014df094f84301c5bbe6b513bb4577::bbag::transfer_or_destroy_balance<T1>(v1, arg5);
        assert!(0x2::balance::value<T0>(&v3) >= arg1, 2);
        0x2::coin::from_balance<T0>(v3, arg5)
    }

    // decompiled from Move bytecode v6
}

