module 0x9d95e29ba5e34c4c896449099d08c4b1403e17e04e5a7291f231ecc587e030dc::swapper {
    public entry fun swap_assets<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: 0x2::coin::Coin<T0>, arg6: 0x2::coin::Coin<T1>, arg7: bool, arg8: bool, arg9: u64, arg10: u64, arg11: u128, arg12: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, arg7, arg8, arg9, arg11, arg0);
        let v3 = v2;
        let v4 = v1;
        let v5 = v0;
        let v6 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3);
        let v7 = if (arg7) {
            0x2::balance::value<T1>(&v4)
        } else {
            0x2::balance::value<T0>(&v5)
        };
        if (arg8) {
            assert!(v6 == arg9, 0);
            assert!(v7 >= arg10, 2);
        } else {
            assert!(v7 == arg9, 1);
            assert!(v6 <= arg10, 2);
        };
        let v8 = 0x2::coin::into_balance<T0>(arg3);
        let v9 = 0x2::coin::into_balance<T1>(arg4);
        let (v10, v11) = if (arg7) {
            (0x2::balance::split<T0>(&mut v8, v6), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v9, v6))
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, v10, v11, v3);
        0x2::balance::join<T0>(&mut v8, v5);
        0x2::balance::join<T1>(&mut v9, v4);
        let v12 = 0x2::tx_context::sender(arg12);
        transfer_to_coin<T0>(v8, arg5, v12, arg12);
        transfer_to_coin<T1>(v9, arg6, v12, arg12);
    }

    fun transfer_to_coin<T0>(arg0: 0x2::balance::Balance<T0>, arg1: 0x2::coin::Coin<T0>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) > 0) {
            0x2::coin::join<T0>(&mut arg1, 0x2::coin::from_balance<T0>(arg0, arg3));
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, arg2);
        } else {
            0x2::balance::destroy_zero<T0>(arg0);
            if (0x2::coin::value<T0>(&arg1) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, arg2);
            } else {
                0x2::coin::destroy_zero<T0>(arg1);
            };
        };
    }

    // decompiled from Move bytecode v6
}

