module 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::converter {
    public(friend) fun swap_a2b<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: bool, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        if (0x2::coin::value<T0>(&arg2) == 0 || arg4 == 0) {
            0x2::coin::destroy_zero<T0>(arg2);
            return (0x2::coin::zero<T0>(arg6), 0x2::coin::zero<T1>(arg6))
        };
        let v0 = 0x2::coin::zero<T1>(arg6);
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, arg3, arg4, 4295048016, arg5);
        let v4 = v3;
        0x2::coin::join<T1>(&mut v0, 0x2::coin::from_balance<T1>(v2, arg6));
        0x2::coin::join<T0>(&mut arg2, 0x2::coin::from_balance<T0>(v1, arg6));
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v4), arg6)), 0x2::balance::zero<T1>(), v4);
        (arg2, v0)
    }

    public(friend) fun swap_b2a<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: bool, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        if (0x2::coin::value<T1>(&arg2) == 0 || arg4 == 0) {
            0x2::coin::destroy_zero<T1>(arg2);
            return (0x2::coin::zero<T0>(arg6), 0x2::coin::zero<T1>(arg6))
        };
        let v0 = 0x2::coin::zero<T0>(arg6);
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, false, arg3, arg4, 79226673515401279992447579055, arg5);
        let v4 = v3;
        0x2::coin::join<T1>(&mut arg2, 0x2::coin::from_balance<T1>(v2, arg6));
        0x2::coin::join<T0>(&mut v0, 0x2::coin::from_balance<T0>(v1, arg6));
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v4), arg6)), v4);
        (v0, arg2)
    }

    // decompiled from Move bytecode v6
}

