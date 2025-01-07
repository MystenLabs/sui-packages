module 0x624ed820bdad488027e8276ada0c2570247ef63dfce67d7a7e9a7bf94257f286::swap {
    public fun check_and_swap_a_2_b<T0, T1>(arg0: 0x2::balance::Balance<T0>, arg1: 0x2::balance::Balance<T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::balance::value<T0>(&arg0);
        let v1 = 0x2::coin::from_balance<T1>(arg1, arg5);
        if (v0 > 0) {
            let (v2, v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg3, arg2, true, true, v0, 4295048016, arg4);
            let v5 = v3;
            0x2::balance::destroy_zero<T0>(v2);
            0x2::balance::value<T1>(&v5);
            0x2::coin::join<T1>(&mut v1, 0x2::coin::from_balance<T1>(v5, arg5));
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg3, arg2, arg0, 0x2::balance::zero<T1>(), v4);
        } else {
            0x2::balance::destroy_zero<T0>(arg0);
        };
        v1
    }

    public fun check_and_swap_b_2_a<T0, T1>(arg0: 0x2::balance::Balance<T0>, arg1: 0x2::balance::Balance<T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::balance::value<T1>(&arg1);
        let v1 = 0x2::coin::from_balance<T0>(arg0, arg5);
        if (v0 > 0) {
            let (v2, v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg3, arg2, false, true, v0, 79226673515401279992447579055, arg4);
            let v5 = v2;
            0x2::balance::destroy_zero<T1>(v3);
            0x2::balance::value<T0>(&v5);
            0x2::coin::join<T0>(&mut v1, 0x2::coin::from_balance<T0>(v5, arg5));
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg3, arg2, 0x2::balance::zero<T0>(), arg1, v4);
        } else {
            0x2::balance::destroy_zero<T1>(arg1);
        };
        v1
    }

    // decompiled from Move bytecode v6
}

