module 0x49320344b83a31fc83a34faad0371c4d5dc312e5c2398ea4da7f4223a6df3901::flash_swap_module {
    public entry fun swap<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = do_swap<T0, T1>(arg0, arg1, arg2, true, true, 79226673515401279992447579055, arg3, arg4, arg5, arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg6));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v1, 0x2::tx_context::sender(arg6));
    }

    public fun do_swap<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: bool, arg4: bool, arg5: u128, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg7: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg7, arg6, arg3, arg4, arg2, arg5, arg8);
        let v3 = v2;
        let v4 = v1;
        let v5 = v0;
        if (arg3) {
        };
        let (v6, v7) = if (arg3) {
            (0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3), arg9)), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3), arg9)))
        };
        0x2::coin::join<T1>(&mut arg1, 0x2::coin::from_balance<T1>(v4, arg9));
        0x2::coin::join<T0>(&mut arg0, 0x2::coin::from_balance<T0>(v5, arg9));
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg7, arg6, v6, v7, v3);
        (arg0, arg1)
    }

    // decompiled from Move bytecode v6
}

