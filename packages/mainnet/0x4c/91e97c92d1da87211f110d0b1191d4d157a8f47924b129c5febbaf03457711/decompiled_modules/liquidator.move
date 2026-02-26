module 0x4c91e97c92d1da87211f110d0b1191d4d157a8f47924b129c5febbaf03457711::liquidator {
    public fun flash_liq_borrow_a<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x4c91e97c92d1da87211f110d0b1191d4d157a8f47924b129c5febbaf03457711::version::Version, arg3: &mut 0x4c91e97c92d1da87211f110d0b1191d4d157a8f47924b129c5febbaf03457711::obligation::Obligation, arg4: &mut 0x4c91e97c92d1da87211f110d0b1191d4d157a8f47924b129c5febbaf03457711::market::Market, arg5: &0x4c91e97c92d1da87211f110d0b1191d4d157a8f47924b129c5febbaf03457711::coin_decimals_registry::CoinDecimalsRegistry, arg6: &0x4c91e97c92d1da87211f110d0b1191d4d157a8f47924b129c5febbaf03457711::x_oracle::XOracle, arg7: u64, arg8: u128, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, false, false, arg7, arg8, arg10);
        let v3 = v2;
        0x2::balance::destroy_zero<T1>(v1);
        let (v4, v5) = 0x4c91e97c92d1da87211f110d0b1191d4d157a8f47924b129c5febbaf03457711::liquidate::liquidate<T0, T1>(arg2, arg3, arg4, 0x2::coin::from_balance<T0>(v0, arg11), arg5, arg6, arg10, arg11);
        let v6 = v4;
        if (0x2::coin::value<T0>(&v6) == 0) {
            0x2::coin::destroy_zero<T0>(v6);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v6, 0x2::tx_context::sender(arg11));
        };
        let v7 = 0x2::coin::into_balance<T1>(v5);
        assert!(0x2::balance::value<T1>(&v7) >= arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v7, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3)), v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v7, arg11), 0x2::tx_context::sender(arg11));
    }

    public fun flash_liq_borrow_b<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x4c91e97c92d1da87211f110d0b1191d4d157a8f47924b129c5febbaf03457711::version::Version, arg3: &mut 0x4c91e97c92d1da87211f110d0b1191d4d157a8f47924b129c5febbaf03457711::obligation::Obligation, arg4: &mut 0x4c91e97c92d1da87211f110d0b1191d4d157a8f47924b129c5febbaf03457711::market::Market, arg5: &0x4c91e97c92d1da87211f110d0b1191d4d157a8f47924b129c5febbaf03457711::coin_decimals_registry::CoinDecimalsRegistry, arg6: &0x4c91e97c92d1da87211f110d0b1191d4d157a8f47924b129c5febbaf03457711::x_oracle::XOracle, arg7: u64, arg8: u128, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, false, arg7, arg8, arg10);
        let v3 = v2;
        0x2::balance::destroy_zero<T0>(v0);
        let (v4, v5) = 0x4c91e97c92d1da87211f110d0b1191d4d157a8f47924b129c5febbaf03457711::liquidate::liquidate<T1, T0>(arg2, arg3, arg4, 0x2::coin::from_balance<T1>(v1, arg11), arg5, arg6, arg10, arg11);
        let v6 = v4;
        if (0x2::coin::value<T1>(&v6) == 0) {
            0x2::coin::destroy_zero<T1>(v6);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v6, 0x2::tx_context::sender(arg11));
        };
        let v7 = 0x2::coin::into_balance<T0>(v5);
        assert!(0x2::balance::value<T0>(&v7) >= arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(&mut v7, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3)), 0x2::balance::zero<T1>(), v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v7, arg11), 0x2::tx_context::sender(arg11));
    }

    // decompiled from Move bytecode v6
}

