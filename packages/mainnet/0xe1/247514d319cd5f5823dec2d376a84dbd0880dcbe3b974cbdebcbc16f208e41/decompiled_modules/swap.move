module 0xe1247514d319cd5f5823dec2d376a84dbd0880dcbe3b974cbdebcbc16f208e41::swap {
    public fun flash_by_a_in<T0, T1>(arg0: u64, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (u64, 0x2::coin::Coin<T1>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>) {
        let v0 = 0x2::coin::zero<T0>(arg4);
        let v1 = 0x2::coin::zero<T1>(arg4);
        let (v2, v3, v4) = flash_swap_cetus<T0, T1>(v0, v1, arg0, true, arg1, arg2, arg3, arg4);
        let v5 = v3;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg4));
        (0x2::coin::value<T1>(&v5), v5, v4)
    }

    public fun flash_by_b_in<T0, T1>(arg0: u64, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (u64, 0x2::coin::Coin<T0>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>) {
        let v0 = 0x2::coin::zero<T0>(arg4);
        let v1 = 0x2::coin::zero<T1>(arg4);
        let (v2, v3, v4) = flash_swap_cetus<T0, T1>(v0, v1, arg0, true, arg1, arg2, arg3, arg4);
        let v5 = v2;
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v3, 0x2::tx_context::sender(arg4));
        (0x2::coin::value<T0>(&v5), v5, v4)
    }

    public fun flash_swap_cetus<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: bool, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>) {
        let v0 = if (arg3) {
            4295048016
        } else {
            79226673515401279992447579055
        };
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg5, arg4, arg3, true, arg2, v0, arg6);
        0x2::coin::join<T0>(&mut arg0, 0x2::coin::from_balance<T0>(v1, arg7));
        0x2::coin::join<T1>(&mut arg1, 0x2::coin::from_balance<T1>(v2, arg7));
        (arg0, arg1, v3)
    }

    public fun repay_by_a<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::zero<T1>(arg4);
        let (v1, v2) = repay_swap_cetus<T0, T1>(arg0, v0, true, arg1, arg2, arg3, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg4));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v2, 0x2::tx_context::sender(arg4));
    }

    public fun repay_by_b<T0, T1>(arg0: 0x2::coin::Coin<T1>, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::zero<T0>(arg4);
        let (v1, v2) = repay_swap_cetus<T0, T1>(v0, arg0, true, arg1, arg2, arg3, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg4));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v2, 0x2::tx_context::sender(arg4));
    }

    public fun repay_swap_cetus<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<T1>, arg2: bool, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let (v0, v1) = if (arg2) {
            (0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&arg5), arg6)), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&arg5), arg6)))
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg4, arg3, v0, v1, arg5);
        (arg0, arg1)
    }

    public fun swap_by_a_in<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (u64, 0x2::coin::Coin<T1>) {
        if (arg1 == 0) {
            arg1 = 0x2::coin::value<T0>(&arg0);
        };
        let v0 = 0x2::coin::zero<T1>(arg5);
        let (v1, v2) = swap_cetus<T0, T1>(arg0, v0, arg1, true, arg2, arg3, arg4, arg5);
        let v3 = v2;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg5));
        (0x2::coin::value<T1>(&v3), v3)
    }

    public fun swap_by_b_in<T0, T1>(arg0: 0x2::coin::Coin<T1>, arg1: u64, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (u64, 0x2::coin::Coin<T0>) {
        if (arg1 == 0) {
            arg1 = 0x2::coin::value<T1>(&arg0);
        };
        let v0 = 0x2::coin::zero<T0>(arg5);
        let (v1, v2) = swap_cetus<T0, T1>(v0, arg0, arg1, false, arg2, arg3, arg4, arg5);
        let v3 = v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v2, 0x2::tx_context::sender(arg5));
        (0x2::coin::value<T0>(&v3), v3)
    }

    public fun swap_cetus<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: bool, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let (v0, v1, v2) = flash_swap_cetus<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        repay_swap_cetus<T0, T1>(v0, v1, arg3, arg4, arg5, v2, arg7)
    }

    // decompiled from Move bytecode v6
}

