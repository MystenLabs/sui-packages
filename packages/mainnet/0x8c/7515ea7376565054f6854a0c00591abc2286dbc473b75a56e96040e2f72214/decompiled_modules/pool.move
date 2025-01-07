module 0x8c7515ea7376565054f6854a0c00591abc2286dbc473b75a56e96040e2f72214::pool {
    public fun swap<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: vector<0x2::coin::Coin<T0>>, arg3: vector<0x2::coin::Coin<T1>>, arg4: bool, arg5: bool, arg6: u64, arg7: u64, arg8: u128, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg10);
        let v1 = merge_coins<T0>(arg2, arg10);
        let v2 = merge_coins<T1>(arg3, arg10);
        let (v3, v4, v5) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, arg4, arg5, arg6, arg8, arg9);
        let v6 = v5;
        let v7 = v4;
        let v8 = v3;
        if (arg4) {
        };
        let (v9, v10) = if (arg4) {
            (0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v6), arg10)), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v6), arg10)))
        };
        0x2::coin::join<T0>(&mut v1, 0x2::coin::from_balance<T0>(v8, arg10));
        0x2::coin::join<T1>(&mut v2, 0x2::coin::from_balance<T1>(v7, arg10));
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, v9, v10, v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, v0);
    }

    public fun liquidate_swap_ab_bc<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T2>, arg5: bool, arg6: bool, arg7: bool, arg8: u64, arg9: u64, arg10: u128, arg11: u128, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T2>) {
        0x996c4d9480708fb8b92aa7acf819fb0497b5ec8e65ba06601cae2fb6db3312c3::router::swap_ab_bc<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg7, arg8, arg9, arg10, arg11, arg12, arg13)
    }

    public fun liquidate_swap_ab_cb<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T2>, arg5: bool, arg6: bool, arg7: bool, arg8: u64, arg9: u64, arg10: u128, arg11: u128, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T2>) {
        0x996c4d9480708fb8b92aa7acf819fb0497b5ec8e65ba06601cae2fb6db3312c3::router::swap_ab_cb<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg7, arg8, arg9, arg10, arg11, arg12, arg13)
    }

    public fun liquidate_swap_ba_bc<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T2>, arg5: bool, arg6: bool, arg7: bool, arg8: u64, arg9: u64, arg10: u128, arg11: u128, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T2>) {
        0x996c4d9480708fb8b92aa7acf819fb0497b5ec8e65ba06601cae2fb6db3312c3::router::swap_ba_bc<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg7, arg8, arg9, arg10, arg11, arg12, arg13)
    }

    public fun liquidate_swap_ba_cb<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T2>, arg5: bool, arg6: bool, arg7: bool, arg8: u64, arg9: u64, arg10: u128, arg11: u128, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T2>) {
        0x996c4d9480708fb8b92aa7acf819fb0497b5ec8e65ba06601cae2fb6db3312c3::router::swap_ba_cb<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg7, arg8, arg9, arg10, arg11, arg12, arg13)
    }

    public fun merge_coins<T0>(arg0: vector<0x2::coin::Coin<T0>>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::zero<T0>(arg1);
        while (!0x1::vector::is_empty<0x2::coin::Coin<T0>>(&arg0)) {
            0x2::coin::join<T0>(&mut v0, 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg0));
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<T0>>(arg0);
        v0
    }

    public fun return_swap<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: vector<0x2::coin::Coin<T0>>, arg3: vector<0x2::coin::Coin<T1>>, arg4: bool, arg5: bool, arg6: u64, arg7: u64, arg8: u128, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = merge_coins<T0>(arg2, arg10);
        let v1 = merge_coins<T1>(arg3, arg10);
        let (v2, v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, arg4, arg5, arg6, arg8, arg9);
        let v5 = v4;
        let v6 = v3;
        let v7 = v2;
        if (arg4) {
        };
        let (v8, v9) = if (arg4) {
            (0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v5), arg10)), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v5), arg10)))
        };
        0x2::coin::join<T0>(&mut v0, 0x2::coin::from_balance<T0>(v7, arg10));
        0x2::coin::join<T1>(&mut v1, 0x2::coin::from_balance<T1>(v6, arg10));
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, v8, v9, v5);
        (v0, v1)
    }

    public fun swap_a2b<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: vector<0x2::coin::Coin<T0>>, arg3: bool, arg4: u64, arg5: u64, arg6: u128, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        return_swap<T0, T1>(arg0, arg1, arg2, 0x1::vector::empty<0x2::coin::Coin<T1>>(), true, arg3, arg4, arg5, arg6, arg7, arg8)
    }

    public fun swap_b2a<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: vector<0x2::coin::Coin<T1>>, arg3: bool, arg4: u64, arg5: u64, arg6: u128, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        return_swap<T0, T1>(arg0, arg1, 0x1::vector::empty<0x2::coin::Coin<T0>>(), arg2, false, arg3, arg4, arg5, arg6, arg7, arg8)
    }

    // decompiled from Move bytecode v6
}

