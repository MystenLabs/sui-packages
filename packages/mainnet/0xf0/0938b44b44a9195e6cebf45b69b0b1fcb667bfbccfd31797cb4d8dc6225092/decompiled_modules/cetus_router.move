module 0xf00938b44b44a9195e6cebf45b69b0b1fcb667bfbccfd31797cb4d8dc6225092::cetus_router {
    fun return_remainder<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) == 0) {
            0x2::balance::destroy_zero<T0>(arg0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg1), 0x2::tx_context::sender(arg1));
        };
    }

    public fun swap_a2b<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::into_balance<T0>(arg2);
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, true, 0x2::coin::value<T0>(&arg2), 4295048016 + 1, arg4);
        let v4 = v3;
        let v5 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v4);
        assert!(0x2::balance::value<T0>(&v0) >= v5, 2);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(&mut v0, v5), 0x2::balance::zero<T1>(), v4);
        0x2::balance::join<T0>(&mut v0, v1);
        return_remainder<T0>(v0, arg5);
        let v6 = 0x2::coin::from_balance<T1>(v2, arg5);
        assert!(0x2::coin::value<T1>(&v6) >= arg3, 1);
        v6
    }

    public fun swap_b2a<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::into_balance<T0>(arg2);
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T0>(arg0, arg1, false, true, 0x2::coin::value<T0>(&arg2), 79226673515401279992447579055 - 1, arg4);
        let v4 = v3;
        let v5 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T0>(&v4);
        assert!(0x2::balance::value<T0>(&v0) >= v5, 2);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T0>(arg0, arg1, 0x2::balance::zero<T1>(), 0x2::balance::split<T0>(&mut v0, v5), v4);
        0x2::balance::join<T0>(&mut v0, v2);
        return_remainder<T0>(v0, arg5);
        let v6 = 0x2::coin::from_balance<T1>(v1, arg5);
        assert!(0x2::coin::value<T1>(&v6) >= arg3, 1);
        v6
    }

    // decompiled from Move bytecode v7
}

