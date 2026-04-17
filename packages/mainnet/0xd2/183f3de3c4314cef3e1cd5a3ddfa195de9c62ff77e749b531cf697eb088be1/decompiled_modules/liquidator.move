module 0xd2183f3de3c4314cef3e1cd5a3ddfa195de9c62ff77e749b531cf697eb088be1::liquidator {
    public fun flash_liq_borrow_a<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, T0>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0xd2183f3de3c4314cef3e1cd5a3ddfa195de9c62ff77e749b531cf697eb088be1::version::Version, arg4: &mut 0xd2183f3de3c4314cef3e1cd5a3ddfa195de9c62ff77e749b531cf697eb088be1::obligation::Obligation, arg5: &mut 0xd2183f3de3c4314cef3e1cd5a3ddfa195de9c62ff77e749b531cf697eb088be1::market::Market, arg6: &0xd2183f3de3c4314cef3e1cd5a3ddfa195de9c62ff77e749b531cf697eb088be1::coin_decimals_registry::CoinDecimalsRegistry, arg7: &0xd2183f3de3c4314cef3e1cd5a3ddfa195de9c62ff77e749b531cf697eb088be1::x_oracle::XOracle, arg8: u64, arg9: u128, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<0x2::sui::SUI, T0>(arg0, arg8, arg12);
        let (v2, v3) = 0xd2183f3de3c4314cef3e1cd5a3ddfa195de9c62ff77e749b531cf697eb088be1::liquidate::liquidate<T0, T1>(arg3, arg4, arg5, v0, arg6, arg7, arg11, arg12);
        let v4 = v3;
        let v5 = v2;
        if (0x2::coin::value<T0>(&v5) == 0) {
            0x2::coin::destroy_zero<T0>(v5);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v5, 0x2::tx_context::sender(arg12));
        };
        let v6 = 0x2::coin::into_balance<T1>(v4);
        let (v7, v8, v9) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, false, true, 0x2::coin::value<T1>(&v4), arg9, arg11);
        let v10 = v9;
        let v11 = v7;
        0x2::balance::destroy_zero<T1>(v8);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v6, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v10)), v10);
        if (0x2::balance::value<T1>(&v6) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v6, arg12), 0x2::tx_context::sender(arg12));
        } else {
            0x2::balance::destroy_zero<T1>(v6);
        };
        assert!(0x2::balance::value<T0>(&v11) >= arg8 + arg10, 0);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<0x2::sui::SUI, T0>(arg0, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v11, arg8), arg12), v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v11, arg12), 0x2::tx_context::sender(arg12));
    }

    public fun flash_liq_borrow_b<T0, T1, T2>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0xd2183f3de3c4314cef3e1cd5a3ddfa195de9c62ff77e749b531cf697eb088be1::version::Version, arg4: &mut 0xd2183f3de3c4314cef3e1cd5a3ddfa195de9c62ff77e749b531cf697eb088be1::obligation::Obligation, arg5: &mut 0xd2183f3de3c4314cef3e1cd5a3ddfa195de9c62ff77e749b531cf697eb088be1::market::Market, arg6: &0xd2183f3de3c4314cef3e1cd5a3ddfa195de9c62ff77e749b531cf697eb088be1::coin_decimals_registry::CoinDecimalsRegistry, arg7: &0xd2183f3de3c4314cef3e1cd5a3ddfa195de9c62ff77e749b531cf697eb088be1::x_oracle::XOracle, arg8: u64, arg9: u128, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_base<T1, T2>(arg0, arg8, arg12);
        let (v2, v3) = 0xd2183f3de3c4314cef3e1cd5a3ddfa195de9c62ff77e749b531cf697eb088be1::liquidate::liquidate<T1, T0>(arg3, arg4, arg5, v0, arg6, arg7, arg11, arg12);
        let v4 = v3;
        let v5 = v2;
        if (0x2::coin::value<T1>(&v5) == 0) {
            0x2::coin::destroy_zero<T1>(v5);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v5, 0x2::tx_context::sender(arg12));
        };
        let v6 = 0x2::coin::into_balance<T0>(v4);
        let (v7, v8, v9) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, true, true, 0x2::coin::value<T0>(&v4), arg9, arg11);
        let v10 = v9;
        let v11 = v8;
        0x2::balance::destroy_zero<T0>(v7);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::split<T0>(&mut v6, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v10)), 0x2::balance::zero<T1>(), v10);
        if (0x2::balance::value<T0>(&v6) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v6, arg12), 0x2::tx_context::sender(arg12));
        } else {
            0x2::balance::destroy_zero<T0>(v6);
        };
        assert!(0x2::balance::value<T1>(&v11) >= arg8 + arg10, 0);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_base<T1, T2>(arg0, 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v11, arg8), arg12), v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v11, arg12), 0x2::tx_context::sender(arg12));
    }

    // decompiled from Move bytecode v7
}

