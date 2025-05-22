module 0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::converter {
    public(friend) fun swap_a2b<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: bool, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        if (0x2::coin::value<T0>(&arg2) == 0 || arg4 == 0) {
            0x2::coin::destroy_zero<T0>(arg2);
            return (0x2::coin::zero<T0>(arg6), 0x2::coin::zero<T1>(arg6))
        };
        let v0 = 0x2::coin::zero<T1>(arg6);
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::fee_rate<T0, T1>(arg1);
        let v2 = if (v1 == 100) {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1) * 999749968 / 1000000000
        } else if (v1 == 10000) {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1) * 992471662 / 1000000000
        } else {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1) * 994987437 / 1000000000
        };
        let v3 = v2;
        if (v2 < 4295048016) {
            v3 = 4295048016;
        };
        let (v4, v5, v6) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, arg3, arg4, v3, arg5);
        let v7 = v6;
        let v8 = v5;
        let v9 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v7);
        if (arg3) {
            assert!(v9 == 0x2::coin::value<T0>(&arg2), 0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::error::high_slippage());
        } else {
            assert!(arg4 == 0x2::balance::value<T1>(&v8), 0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::error::high_slippage());
            assert!(0x2::coin::value<T0>(&arg2) >= v9, 0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::error::insufficient_balance_error());
        };
        0x2::coin::join<T1>(&mut v0, 0x2::coin::from_balance<T1>(v8, arg6));
        0x2::coin::join<T0>(&mut arg2, 0x2::coin::from_balance<T0>(v4, arg6));
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg2, v9, arg6)), 0x2::balance::zero<T1>(), v7);
        (arg2, v0)
    }

    public(friend) fun swap_a2b_with_fixed_limit<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: bool, arg4: u64, arg5: u128, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        if (0x2::coin::value<T0>(&arg2) == 0 || arg4 == 0) {
            0x2::coin::destroy_zero<T0>(arg2);
            return (0x2::coin::zero<T0>(arg7), 0x2::coin::zero<T1>(arg7))
        };
        let v0 = 0x2::coin::zero<T1>(arg7);
        let v1 = if (arg5 < 4295048016) {
            4295048016
        } else {
            arg5
        };
        let (v2, v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, arg3, arg4, v1, arg6);
        let v5 = v4;
        let v6 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v5);
        assert!(v6 == 0x2::coin::value<T0>(&arg2), 0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::error::high_slippage());
        0x2::coin::join<T1>(&mut v0, 0x2::coin::from_balance<T1>(v3, arg7));
        0x2::coin::join<T0>(&mut arg2, 0x2::coin::from_balance<T0>(v2, arg7));
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg2, v6, arg7)), 0x2::balance::zero<T1>(), v5);
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

    public fun swap_b2a_with_fixed_limit<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: bool, arg4: u64, arg5: u128, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        if (0x2::coin::value<T1>(&arg2) == 0 || arg4 == 0) {
            0x2::coin::destroy_zero<T1>(arg2);
            return (0x2::coin::zero<T0>(arg7), 0x2::coin::zero<T1>(arg7))
        };
        let v0 = 0x2::coin::zero<T0>(arg7);
        let v1 = if (arg5 > 79226673515401279992447579055) {
            79226673515401279992447579055
        } else {
            arg5
        };
        let (v2, v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, false, arg3, arg4, v1, arg6);
        let v5 = v4;
        let v6 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v5);
        assert!(v6 == 0x2::coin::value<T1>(&arg2), 0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::error::high_slippage());
        0x2::coin::join<T1>(&mut arg2, 0x2::coin::from_balance<T1>(v3, arg7));
        0x2::coin::join<T0>(&mut v0, 0x2::coin::from_balance<T0>(v2, arg7));
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg2, v6, arg7)), v5);
        (v0, arg2)
    }

    // decompiled from Move bytecode v6
}

