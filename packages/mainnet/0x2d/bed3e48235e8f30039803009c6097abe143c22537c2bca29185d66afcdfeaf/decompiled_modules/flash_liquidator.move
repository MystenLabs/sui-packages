module 0xfb8906dbc39e821f2cd42faeac156a289fa5b3a714a36ee5c25383e84a4ad637::flash_liquidator {
    public fun fl_v3_template<T0, T1, T2, T3>(arg0: &T3, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: 0x2::object::ID, arg6: u64, arg7: u64, arg8: u64, arg9: u128, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0xfb8906dbc39e821f2cd42faeac156a289fa5b3a714a36ee5c25383e84a4ad637::flash_adapters::flash_swap_borrow_a<T1, T2>(arg1, arg2, arg8, arg9, arg10);
        let v3 = v2;
        let v4 = v1;
        let v5 = 0x2::coin::from_balance<T1>(v0, arg11);
        0x2::balance::join<T2>(&mut v4, 0x2::coin::into_balance<T2>(0xfb8906dbc39e821f2cd42faeac156a289fa5b3a714a36ee5c25383e84a4ad637::executor::liquidate_and_redeem<T0, T1, T2>(arg4, arg5, arg6, arg7, arg10, &mut v5, arg11)));
        if (0x2::coin::value<T1>(&v5) > 0) {
            let (v6, v7) = 0xfb8906dbc39e821f2cd42faeac156a289fa5b3a714a36ee5c25383e84a4ad637::flash_adapters::swap_a_to_b<T1, T2>(arg1, arg2, 0x2::coin::into_balance<T1>(v5), arg10);
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
        let v9 = 0xfb8906dbc39e821f2cd42faeac156a289fa5b3a714a36ee5c25383e84a4ad637::flash_adapters::swap_pay_amount<T1, T2>(&v3);
        assert!(0x2::balance::value<T2>(&v4) >= v9, 1);
        0xfb8906dbc39e821f2cd42faeac156a289fa5b3a714a36ee5c25383e84a4ad637::flash_adapters::repay_flash_swap_pay_b<T1, T2>(arg1, arg2, 0x2::balance::zero<T1>(), 0x2::balance::split<T2>(&mut v4, v9), v3);
        if (0x2::balance::value<T2>(&v4) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v4, arg11), 0x2::tx_context::sender(arg11));
        } else {
            0x2::balance::destroy_zero<T2>(v4);
        };
    }

    public fun fl_v3_template_reversed<T0, T1, T2, T3>(arg0: &T3, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: 0x2::object::ID, arg6: u64, arg7: u64, arg8: u64, arg9: u128, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0xfb8906dbc39e821f2cd42faeac156a289fa5b3a714a36ee5c25383e84a4ad637::flash_adapters::flash_swap_borrow_b<T2, T1>(arg1, arg2, arg8, arg9, arg10);
        let v3 = v2;
        let v4 = v0;
        let v5 = 0x2::coin::from_balance<T1>(v1, arg11);
        0x2::balance::join<T2>(&mut v4, 0x2::coin::into_balance<T2>(0xfb8906dbc39e821f2cd42faeac156a289fa5b3a714a36ee5c25383e84a4ad637::executor::liquidate_and_redeem<T0, T1, T2>(arg4, arg5, arg6, arg7, arg10, &mut v5, arg11)));
        if (0x2::coin::value<T1>(&v5) > 0) {
            let (v6, v7) = 0xfb8906dbc39e821f2cd42faeac156a289fa5b3a714a36ee5c25383e84a4ad637::flash_adapters::swap_b_to_a<T2, T1>(arg1, arg2, 0x2::coin::into_balance<T1>(v5), arg10);
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
        let v9 = 0xfb8906dbc39e821f2cd42faeac156a289fa5b3a714a36ee5c25383e84a4ad637::flash_adapters::swap_pay_amount<T2, T1>(&v3);
        assert!(0x2::balance::value<T2>(&v4) >= v9, 1);
        0xfb8906dbc39e821f2cd42faeac156a289fa5b3a714a36ee5c25383e84a4ad637::flash_adapters::repay_flash_swap_pay_b<T2, T1>(arg1, arg2, 0x2::balance::split<T2>(&mut v4, v9), 0x2::balance::zero<T1>(), v3);
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

    public fun refresh_extra_and_fl_v3_template<T0, T1, T2, T3>(arg0: &T3, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: 0x2::object::ID, arg6: u64, arg7: u64, arg8: u64, arg9: u128, arg10: &0x2::clock::Clock, arg11: u64, arg12: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg13: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg14: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: &mut 0x2::tx_context::TxContext) {
        refresh_extra_reserve_if_needed<T0>(arg4, arg6, arg7, arg10, arg11, arg12);
        refresh_and_fl_v3_template<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg13, arg14, arg15);
    }

    public fun refresh_extra_and_fl_v3_template_reversed<T0, T1, T2, T3>(arg0: &T3, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: 0x2::object::ID, arg6: u64, arg7: u64, arg8: u64, arg9: u128, arg10: &0x2::clock::Clock, arg11: u64, arg12: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg13: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg14: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: &mut 0x2::tx_context::TxContext) {
        refresh_extra_reserve_if_needed<T0>(arg4, arg6, arg7, arg10, arg11, arg12);
        refresh_and_fl_v3_template_reversed<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg13, arg14, arg15);
    }

    fun refresh_extra_reserve_if_needed<T0>(arg0: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: u64, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject) {
        if (arg4 != arg1 && arg4 != arg2) {
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<T0>(arg0, arg4, arg3, arg5);
        };
    }

    fun refresh_extra_reserves<T0>(arg0: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &vector<u64>, arg5: &vector<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>) {
        let v0 = 0x1::vector::length<u64>(arg4);
        assert!(v0 == 0x1::vector::length<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg5), 2);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = *0x1::vector::borrow<u64>(arg4, v1);
            if (v2 != arg1 && v2 != arg2) {
                0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<T0>(arg0, v2, arg3, 0x1::vector::borrow<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg5, v1));
            };
            v1 = v1 + 1;
        };
    }

    public fun refresh_five_extra_and_fl_v3_template<T0, T1, T2, T3>(arg0: &T3, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: 0x2::object::ID, arg6: u64, arg7: u64, arg8: u64, arg9: u128, arg10: &0x2::clock::Clock, arg11: u64, arg12: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg13: u64, arg14: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: u64, arg16: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg17: u64, arg18: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg19: u64, arg20: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg21: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg22: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg23: &mut 0x2::tx_context::TxContext) {
        refresh_extra_reserve_if_needed<T0>(arg4, arg6, arg7, arg10, arg11, arg12);
        refresh_extra_reserve_if_needed<T0>(arg4, arg6, arg7, arg10, arg13, arg14);
        refresh_extra_reserve_if_needed<T0>(arg4, arg6, arg7, arg10, arg15, arg16);
        refresh_extra_reserve_if_needed<T0>(arg4, arg6, arg7, arg10, arg17, arg18);
        refresh_extra_reserve_if_needed<T0>(arg4, arg6, arg7, arg10, arg19, arg20);
        refresh_and_fl_v3_template<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg21, arg22, arg23);
    }

    public fun refresh_five_extra_and_fl_v3_template_reversed<T0, T1, T2, T3>(arg0: &T3, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: 0x2::object::ID, arg6: u64, arg7: u64, arg8: u64, arg9: u128, arg10: &0x2::clock::Clock, arg11: u64, arg12: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg13: u64, arg14: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: u64, arg16: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg17: u64, arg18: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg19: u64, arg20: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg21: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg22: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg23: &mut 0x2::tx_context::TxContext) {
        refresh_extra_reserve_if_needed<T0>(arg4, arg6, arg7, arg10, arg11, arg12);
        refresh_extra_reserve_if_needed<T0>(arg4, arg6, arg7, arg10, arg13, arg14);
        refresh_extra_reserve_if_needed<T0>(arg4, arg6, arg7, arg10, arg15, arg16);
        refresh_extra_reserve_if_needed<T0>(arg4, arg6, arg7, arg10, arg17, arg18);
        refresh_extra_reserve_if_needed<T0>(arg4, arg6, arg7, arg10, arg19, arg20);
        refresh_and_fl_v3_template_reversed<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg21, arg22, arg23);
    }

    public fun refresh_four_extra_and_fl_v3_template<T0, T1, T2, T3>(arg0: &T3, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: 0x2::object::ID, arg6: u64, arg7: u64, arg8: u64, arg9: u128, arg10: &0x2::clock::Clock, arg11: u64, arg12: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg13: u64, arg14: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: u64, arg16: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg17: u64, arg18: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg19: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg20: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg21: &mut 0x2::tx_context::TxContext) {
        refresh_extra_reserve_if_needed<T0>(arg4, arg6, arg7, arg10, arg11, arg12);
        refresh_extra_reserve_if_needed<T0>(arg4, arg6, arg7, arg10, arg13, arg14);
        refresh_extra_reserve_if_needed<T0>(arg4, arg6, arg7, arg10, arg15, arg16);
        refresh_extra_reserve_if_needed<T0>(arg4, arg6, arg7, arg10, arg17, arg18);
        refresh_and_fl_v3_template<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg19, arg20, arg21);
    }

    public fun refresh_four_extra_and_fl_v3_template_reversed<T0, T1, T2, T3>(arg0: &T3, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: 0x2::object::ID, arg6: u64, arg7: u64, arg8: u64, arg9: u128, arg10: &0x2::clock::Clock, arg11: u64, arg12: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg13: u64, arg14: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: u64, arg16: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg17: u64, arg18: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg19: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg20: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg21: &mut 0x2::tx_context::TxContext) {
        refresh_extra_reserve_if_needed<T0>(arg4, arg6, arg7, arg10, arg11, arg12);
        refresh_extra_reserve_if_needed<T0>(arg4, arg6, arg7, arg10, arg13, arg14);
        refresh_extra_reserve_if_needed<T0>(arg4, arg6, arg7, arg10, arg15, arg16);
        refresh_extra_reserve_if_needed<T0>(arg4, arg6, arg7, arg10, arg17, arg18);
        refresh_and_fl_v3_template_reversed<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg19, arg20, arg21);
    }

    public fun refresh_many_and_fl_v3_template<T0, T1, T2, T3>(arg0: &T3, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: 0x2::object::ID, arg6: u64, arg7: u64, arg8: u64, arg9: u128, arg10: &0x2::clock::Clock, arg11: vector<u64>, arg12: &vector<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>, arg13: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg14: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: &mut 0x2::tx_context::TxContext) {
        refresh_extra_reserves<T0>(arg4, arg6, arg7, arg10, &arg11, arg12);
        refresh_and_fl_v3_template<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg13, arg14, arg15);
    }

    public fun refresh_many_and_fl_v3_template_reversed<T0, T1, T2, T3>(arg0: &T3, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: 0x2::object::ID, arg6: u64, arg7: u64, arg8: u64, arg9: u128, arg10: &0x2::clock::Clock, arg11: vector<u64>, arg12: &vector<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>, arg13: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg14: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: &mut 0x2::tx_context::TxContext) {
        refresh_extra_reserves<T0>(arg4, arg6, arg7, arg10, &arg11, arg12);
        refresh_and_fl_v3_template_reversed<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg13, arg14, arg15);
    }

    public fun refresh_seven_extra_and_fl_v3_template<T0, T1, T2, T3>(arg0: &T3, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: 0x2::object::ID, arg6: u64, arg7: u64, arg8: u64, arg9: u128, arg10: &0x2::clock::Clock, arg11: u64, arg12: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg13: u64, arg14: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: u64, arg16: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg17: u64, arg18: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg19: u64, arg20: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg21: u64, arg22: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg23: u64, arg24: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg25: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg26: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg27: &mut 0x2::tx_context::TxContext) {
        refresh_extra_reserve_if_needed<T0>(arg4, arg6, arg7, arg10, arg11, arg12);
        refresh_extra_reserve_if_needed<T0>(arg4, arg6, arg7, arg10, arg13, arg14);
        refresh_extra_reserve_if_needed<T0>(arg4, arg6, arg7, arg10, arg15, arg16);
        refresh_extra_reserve_if_needed<T0>(arg4, arg6, arg7, arg10, arg17, arg18);
        refresh_extra_reserve_if_needed<T0>(arg4, arg6, arg7, arg10, arg19, arg20);
        refresh_extra_reserve_if_needed<T0>(arg4, arg6, arg7, arg10, arg21, arg22);
        refresh_extra_reserve_if_needed<T0>(arg4, arg6, arg7, arg10, arg23, arg24);
        refresh_and_fl_v3_template<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg25, arg26, arg27);
    }

    public fun refresh_seven_extra_and_fl_v3_template_reversed<T0, T1, T2, T3>(arg0: &T3, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: 0x2::object::ID, arg6: u64, arg7: u64, arg8: u64, arg9: u128, arg10: &0x2::clock::Clock, arg11: u64, arg12: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg13: u64, arg14: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: u64, arg16: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg17: u64, arg18: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg19: u64, arg20: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg21: u64, arg22: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg23: u64, arg24: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg25: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg26: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg27: &mut 0x2::tx_context::TxContext) {
        refresh_extra_reserve_if_needed<T0>(arg4, arg6, arg7, arg10, arg11, arg12);
        refresh_extra_reserve_if_needed<T0>(arg4, arg6, arg7, arg10, arg13, arg14);
        refresh_extra_reserve_if_needed<T0>(arg4, arg6, arg7, arg10, arg15, arg16);
        refresh_extra_reserve_if_needed<T0>(arg4, arg6, arg7, arg10, arg17, arg18);
        refresh_extra_reserve_if_needed<T0>(arg4, arg6, arg7, arg10, arg19, arg20);
        refresh_extra_reserve_if_needed<T0>(arg4, arg6, arg7, arg10, arg21, arg22);
        refresh_extra_reserve_if_needed<T0>(arg4, arg6, arg7, arg10, arg23, arg24);
        refresh_and_fl_v3_template_reversed<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg25, arg26, arg27);
    }

    public fun refresh_six_extra_and_fl_v3_template<T0, T1, T2, T3>(arg0: &T3, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: 0x2::object::ID, arg6: u64, arg7: u64, arg8: u64, arg9: u128, arg10: &0x2::clock::Clock, arg11: u64, arg12: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg13: u64, arg14: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: u64, arg16: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg17: u64, arg18: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg19: u64, arg20: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg21: u64, arg22: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg23: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg24: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg25: &mut 0x2::tx_context::TxContext) {
        refresh_extra_reserve_if_needed<T0>(arg4, arg6, arg7, arg10, arg11, arg12);
        refresh_extra_reserve_if_needed<T0>(arg4, arg6, arg7, arg10, arg13, arg14);
        refresh_extra_reserve_if_needed<T0>(arg4, arg6, arg7, arg10, arg15, arg16);
        refresh_extra_reserve_if_needed<T0>(arg4, arg6, arg7, arg10, arg17, arg18);
        refresh_extra_reserve_if_needed<T0>(arg4, arg6, arg7, arg10, arg19, arg20);
        refresh_extra_reserve_if_needed<T0>(arg4, arg6, arg7, arg10, arg21, arg22);
        refresh_and_fl_v3_template<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg23, arg24, arg25);
    }

    public fun refresh_six_extra_and_fl_v3_template_reversed<T0, T1, T2, T3>(arg0: &T3, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: 0x2::object::ID, arg6: u64, arg7: u64, arg8: u64, arg9: u128, arg10: &0x2::clock::Clock, arg11: u64, arg12: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg13: u64, arg14: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: u64, arg16: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg17: u64, arg18: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg19: u64, arg20: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg21: u64, arg22: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg23: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg24: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg25: &mut 0x2::tx_context::TxContext) {
        refresh_extra_reserve_if_needed<T0>(arg4, arg6, arg7, arg10, arg11, arg12);
        refresh_extra_reserve_if_needed<T0>(arg4, arg6, arg7, arg10, arg13, arg14);
        refresh_extra_reserve_if_needed<T0>(arg4, arg6, arg7, arg10, arg15, arg16);
        refresh_extra_reserve_if_needed<T0>(arg4, arg6, arg7, arg10, arg17, arg18);
        refresh_extra_reserve_if_needed<T0>(arg4, arg6, arg7, arg10, arg19, arg20);
        refresh_extra_reserve_if_needed<T0>(arg4, arg6, arg7, arg10, arg21, arg22);
        refresh_and_fl_v3_template_reversed<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg23, arg24, arg25);
    }

    public fun refresh_three_extra_and_fl_v3_template<T0, T1, T2, T3>(arg0: &T3, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: 0x2::object::ID, arg6: u64, arg7: u64, arg8: u64, arg9: u128, arg10: &0x2::clock::Clock, arg11: u64, arg12: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg13: u64, arg14: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: u64, arg16: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg17: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg18: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg19: &mut 0x2::tx_context::TxContext) {
        refresh_extra_reserve_if_needed<T0>(arg4, arg6, arg7, arg10, arg11, arg12);
        refresh_extra_reserve_if_needed<T0>(arg4, arg6, arg7, arg10, arg13, arg14);
        refresh_extra_reserve_if_needed<T0>(arg4, arg6, arg7, arg10, arg15, arg16);
        refresh_and_fl_v3_template<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg17, arg18, arg19);
    }

    public fun refresh_three_extra_and_fl_v3_template_reversed<T0, T1, T2, T3>(arg0: &T3, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: 0x2::object::ID, arg6: u64, arg7: u64, arg8: u64, arg9: u128, arg10: &0x2::clock::Clock, arg11: u64, arg12: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg13: u64, arg14: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: u64, arg16: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg17: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg18: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg19: &mut 0x2::tx_context::TxContext) {
        refresh_extra_reserve_if_needed<T0>(arg4, arg6, arg7, arg10, arg11, arg12);
        refresh_extra_reserve_if_needed<T0>(arg4, arg6, arg7, arg10, arg13, arg14);
        refresh_extra_reserve_if_needed<T0>(arg4, arg6, arg7, arg10, arg15, arg16);
        refresh_and_fl_v3_template_reversed<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg17, arg18, arg19);
    }

    public fun refresh_two_extra_and_fl_v3_template<T0, T1, T2, T3>(arg0: &T3, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: 0x2::object::ID, arg6: u64, arg7: u64, arg8: u64, arg9: u128, arg10: &0x2::clock::Clock, arg11: u64, arg12: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg13: u64, arg14: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg16: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg17: &mut 0x2::tx_context::TxContext) {
        refresh_extra_reserve_if_needed<T0>(arg4, arg6, arg7, arg10, arg11, arg12);
        refresh_extra_reserve_if_needed<T0>(arg4, arg6, arg7, arg10, arg13, arg14);
        refresh_and_fl_v3_template<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg15, arg16, arg17);
    }

    public fun refresh_two_extra_and_fl_v3_template_reversed<T0, T1, T2, T3>(arg0: &T3, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: 0x2::object::ID, arg6: u64, arg7: u64, arg8: u64, arg9: u128, arg10: &0x2::clock::Clock, arg11: u64, arg12: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg13: u64, arg14: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg16: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg17: &mut 0x2::tx_context::TxContext) {
        refresh_extra_reserve_if_needed<T0>(arg4, arg6, arg7, arg10, arg11, arg12);
        refresh_extra_reserve_if_needed<T0>(arg4, arg6, arg7, arg10, arg13, arg14);
        refresh_and_fl_v3_template_reversed<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg15, arg16, arg17);
    }

    // decompiled from Move bytecode v6
}

