module 0x28b5243272326545793c9aec9a2c7d1abc486fd3e5ccc7657c015db4f8065b91::flash_liquidator {
    public fun fl_v3_template<T0, T1, T2, T3>(arg0: &T3, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: 0x2::object::ID, arg6: u64, arg7: u64, arg8: u64, arg9: u128, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x28b5243272326545793c9aec9a2c7d1abc486fd3e5ccc7657c015db4f8065b91::flash_adapters::flash_swap_borrow_a<T1, T2>(arg1, arg2, arg8, arg9, arg10);
        let v3 = v2;
        let v4 = v1;
        let v5 = 0x2::coin::from_balance<T1>(v0, arg11);
        0x2::balance::join<T2>(&mut v4, 0x2::coin::into_balance<T2>(0x28b5243272326545793c9aec9a2c7d1abc486fd3e5ccc7657c015db4f8065b91::executor::liquidate_and_redeem<T0, T1, T2>(arg4, arg5, arg6, arg7, arg10, &mut v5, arg11)));
        if (0x2::coin::value<T1>(&v5) > 0) {
            let (v6, v7) = 0x28b5243272326545793c9aec9a2c7d1abc486fd3e5ccc7657c015db4f8065b91::flash_adapters::swap_a_to_b<T1, T2>(arg1, arg2, 0x2::coin::into_balance<T1>(v5), arg10);
            let v8 = v6;
            0x2::balance::join<T2>(&mut v4, v7);
            if (0x2::balance::value<T1>(&v8) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v8, arg11), 0x2::tx_context::sender(arg11));
            } else {
                0x2::balance::destroy_zero<T1>(v8);
            };
        } else {
            0x2::coin::destroy_zero<T1>(v5);
        };
        let v9 = 0x28b5243272326545793c9aec9a2c7d1abc486fd3e5ccc7657c015db4f8065b91::flash_adapters::swap_pay_amount<T1, T2>(&v3);
        assert!(0x2::balance::value<T2>(&v4) >= v9, 1);
        0x28b5243272326545793c9aec9a2c7d1abc486fd3e5ccc7657c015db4f8065b91::flash_adapters::repay_flash_swap_pay_b<T1, T2>(arg1, arg2, 0x2::balance::zero<T1>(), 0x2::balance::split<T2>(&mut v4, v9), v3);
        if (0x2::balance::value<T2>(&v4) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v4, arg11), 0x2::tx_context::sender(arg11));
        } else {
            0x2::balance::destroy_zero<T2>(v4);
        };
    }

    public fun fl_v3_template_reversed<T0, T1, T2, T3>(arg0: &T3, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: 0x2::object::ID, arg6: u64, arg7: u64, arg8: u64, arg9: u128, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x28b5243272326545793c9aec9a2c7d1abc486fd3e5ccc7657c015db4f8065b91::flash_adapters::flash_swap_borrow_b<T2, T1>(arg1, arg2, arg8, arg9, arg10);
        let v3 = v2;
        let v4 = v0;
        let v5 = 0x2::coin::from_balance<T1>(v1, arg11);
        0x2::balance::join<T2>(&mut v4, 0x2::coin::into_balance<T2>(0x28b5243272326545793c9aec9a2c7d1abc486fd3e5ccc7657c015db4f8065b91::executor::liquidate_and_redeem<T0, T1, T2>(arg4, arg5, arg6, arg7, arg10, &mut v5, arg11)));
        if (0x2::coin::value<T1>(&v5) > 0) {
            let (v6, v7) = 0x28b5243272326545793c9aec9a2c7d1abc486fd3e5ccc7657c015db4f8065b91::flash_adapters::swap_b_to_a<T2, T1>(arg1, arg2, 0x2::coin::into_balance<T1>(v5), arg10);
            let v8 = v6;
            0x2::balance::join<T2>(&mut v4, v7);
            if (0x2::balance::value<T1>(&v8) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v8, arg11), 0x2::tx_context::sender(arg11));
            } else {
                0x2::balance::destroy_zero<T1>(v8);
            };
        } else {
            0x2::coin::destroy_zero<T1>(v5);
        };
        let v9 = 0x28b5243272326545793c9aec9a2c7d1abc486fd3e5ccc7657c015db4f8065b91::flash_adapters::swap_pay_amount<T2, T1>(&v3);
        assert!(0x2::balance::value<T2>(&v4) >= v9, 1);
        0x28b5243272326545793c9aec9a2c7d1abc486fd3e5ccc7657c015db4f8065b91::flash_adapters::repay_flash_swap_pay_b<T2, T1>(arg1, arg2, 0x2::balance::split<T2>(&mut v4, v9), 0x2::balance::zero<T1>(), v3);
        if (0x2::balance::value<T2>(&v4) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v4, arg11), 0x2::tx_context::sender(arg11));
        } else {
            0x2::balance::destroy_zero<T2>(v4);
        };
    }

    public fun refresh_and_fl_v3_template<T0, T1, T2, T3>(arg0: &T3, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: 0x2::object::ID, arg6: u64, arg7: u64, arg8: u64, arg9: u128, arg10: &0x2::clock::Clock, arg11: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg12: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg13: &mut 0x2::tx_context::TxContext) {
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<T0>(arg4, arg6, arg10, arg11);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<T0>(arg4, arg7, arg10, arg12);
        fl_v3_template<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg13);
    }

    public fun refresh_and_fl_v3_template_reversed<T0, T1, T2, T3>(arg0: &T3, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: 0x2::object::ID, arg6: u64, arg7: u64, arg8: u64, arg9: u128, arg10: &0x2::clock::Clock, arg11: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg12: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg13: &mut 0x2::tx_context::TxContext) {
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<T0>(arg4, arg6, arg10, arg11);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<T0>(arg4, arg7, arg10, arg12);
        fl_v3_template_reversed<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg13);
    }

    // decompiled from Move bytecode v6
}

