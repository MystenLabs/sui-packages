module 0xd87c4368ea4f07a4856d9f49320808a460aec01191a1ca9ddb0d4373cd66e14a::flash_liquidator {
    public entry fun refresh_and_s0fl_v3_template<T0, T1, T2>(arg0: &T2, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, 0x2::sui::SUI>, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: 0x2::object::ID, arg6: u64, arg7: u64, arg8: u64, arg9: u128, arg10: &0x2::clock::Clock, arg11: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg12: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg13: &mut 0x2::tx_context::TxContext) {
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<T0>(arg4, arg6, arg10, arg11);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<T0>(arg4, arg7, arg10, arg12);
        s0fl_v3_template<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg13);
    }

    public entry fun s0fl_v3_template<T0, T1, T2>(arg0: &T2, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, 0x2::sui::SUI>, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: 0x2::object::ID, arg6: u64, arg7: u64, arg8: u64, arg9: u128, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0xd87c4368ea4f07a4856d9f49320808a460aec01191a1ca9ddb0d4373cd66e14a::flash_adapters::flash_swap<T1>(arg1, arg2, arg8, arg9, arg10);
        let v3 = v2;
        let v4 = v1;
        let v5 = 0x2::coin::from_balance<T1>(v0, arg11);
        0x2::balance::join<0x2::sui::SUI>(&mut v4, 0x2::coin::into_balance<0x2::sui::SUI>(0xd87c4368ea4f07a4856d9f49320808a460aec01191a1ca9ddb0d4373cd66e14a::executor::liquidate_and_redeem_sui<T0, T1>(arg4, arg5, arg6, arg7, arg10, &mut v5, arg3, arg11)));
        if (0x2::coin::value<T1>(&v5) > 0) {
            let (v6, v7) = 0xd87c4368ea4f07a4856d9f49320808a460aec01191a1ca9ddb0d4373cd66e14a::flash_adapters::swap_repay_to_sui<T1>(arg1, arg2, 0x2::coin::into_balance<T1>(v5), arg10);
            let v8 = v6;
            0x2::balance::join<0x2::sui::SUI>(&mut v4, v7);
            if (0x2::balance::value<T1>(&v8) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v8, arg11), 0x2::tx_context::sender(arg11));
            } else {
                0x2::balance::destroy_zero<T1>(v8);
            };
        } else {
            0x2::coin::destroy_zero<T1>(v5);
        };
        let v9 = 0xd87c4368ea4f07a4856d9f49320808a460aec01191a1ca9ddb0d4373cd66e14a::flash_adapters::swap_pay_amount<T1>(&v3);
        assert!(0x2::balance::value<0x2::sui::SUI>(&v4) >= v9, 1);
        0xd87c4368ea4f07a4856d9f49320808a460aec01191a1ca9ddb0d4373cd66e14a::flash_adapters::repay_flash_swap<T1>(arg1, arg2, 0x2::balance::zero<T1>(), 0x2::balance::split<0x2::sui::SUI>(&mut v4, v9), v3);
        if (0x2::balance::value<0x2::sui::SUI>(&v4) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v4, arg11), 0x2::tx_context::sender(arg11));
        } else {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v4);
        };
    }

    // decompiled from Move bytecode v6
}

