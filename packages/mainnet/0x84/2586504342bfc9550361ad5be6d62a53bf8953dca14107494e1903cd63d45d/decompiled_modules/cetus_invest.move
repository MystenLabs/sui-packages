module 0x842586504342bfc9550361ad5be6d62a53bf8953dca14107494e1903cd63d45d::cetus_invest {
    public entry fun buy<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: bool, arg4: bool, arg5: u64, arg6: u64, arg7: u128, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, arg3, arg4, arg5, arg7, arg8);
        let v3 = v2;
        let v4 = v1;
        let v5 = v0;
        if (arg3) {
        };
        0x2::coin::join<T1>(&mut arg2, 0x2::coin::from_balance<T1>(v4, arg9));
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3), arg9)), v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v5, arg9), 0x2::tx_context::sender(arg9));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg2, 0x2::tx_context::sender(arg9));
    }

    // decompiled from Move bytecode v6
}

