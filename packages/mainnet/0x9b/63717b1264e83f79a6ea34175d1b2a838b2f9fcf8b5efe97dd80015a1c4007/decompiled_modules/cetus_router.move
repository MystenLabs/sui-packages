module 0xbb43c13df112bf6319e7aeca95b4d8edbed62023a182d9f9f3ede42f22837e5e::cetus_router {
    fun return_remainder<T0>(arg0: 0x2::balance::Balance<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<T0>(&arg0);
        if (v0 == 0) {
            0x2::balance::destroy_zero<T0>(arg0);
        } else {
            assert!(v0 * 1000 <= arg1, 3);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg2), 0x2::tx_context::sender(arg2));
        };
    }

    public fun swap_a2b<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::value<T0>(&arg2);
        let v1 = 0x2::coin::into_balance<T0>(arg2);
        let (v2, v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, true, v0, 4295048016 + 1, arg4);
        let v5 = v4;
        let v6 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v5);
        assert!(0x2::balance::value<T0>(&v1) >= v6, 2);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(&mut v1, v6), 0x2::balance::zero<T1>(), v5);
        0x2::balance::join<T0>(&mut v1, v2);
        return_remainder<T0>(v1, v0, arg5);
        let v7 = 0x2::coin::from_balance<T1>(v3, arg5);
        assert!(0x2::coin::value<T1>(&v7) >= arg3, 1);
        v7
    }

    public fun swap_b2a<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::value<T0>(&arg2);
        let v1 = 0x2::coin::into_balance<T0>(arg2);
        let (v2, v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T0>(arg0, arg1, false, true, v0, 79226673515401279992447579055 - 1, arg4);
        let v5 = v4;
        let v6 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T0>(&v5);
        assert!(0x2::balance::value<T0>(&v1) >= v6, 2);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T0>(arg0, arg1, 0x2::balance::zero<T1>(), 0x2::balance::split<T0>(&mut v1, v6), v5);
        0x2::balance::join<T0>(&mut v1, v3);
        return_remainder<T0>(v1, v0, arg5);
        let v7 = 0x2::coin::from_balance<T1>(v2, arg5);
        assert!(0x2::coin::value<T1>(&v7) >= arg3, 1);
        v7
    }

    // decompiled from Move bytecode v7
}

