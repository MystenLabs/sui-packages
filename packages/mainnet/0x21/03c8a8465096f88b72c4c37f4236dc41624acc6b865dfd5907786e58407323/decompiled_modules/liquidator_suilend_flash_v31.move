module 0x4342299897150e43ed71c09aeee9b66c9f0f324cdf7e3a4089b786f513666842::liquidator_suilend_flash_v31 {
    struct BatchSkipV31 has copy, drop {
        user: address,
        reason: u8,
        index: u64,
    }

    struct ExtraSeizeDone has copy, drop {
        user: address,
        index: u64,
        extra_seize_reserve_idx: u64,
        repay_used: u64,
        slot: u8,
    }

    struct BatchLiquidatedV31 has copy, drop {
        user: address,
        index: u64,
        repay_used: u64,
        coll_seized: u64,
    }

    struct BatchSummaryV31 has copy, drop {
        batch_size: u64,
        liquidated_count: u64,
        skipped_count: u64,
        extra_seize_count: u64,
        total_repay_used: u64,
        flash_amount: u64,
        final_payout: u64,
        push_phase0: bool,
        cross_type_drains: u8,
    }

    public fun batch_flash_liq_suilend_v31_with_extra_seize_1_keeper_ride<T0, T1, T2, T3>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u128, arg13: vector<0x2::object::ID>, arg14: vector<u64>, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<T0>(arg3, arg7, arg15, arg4);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<T0>(arg3, arg8, arg15, arg5);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<T0>(arg3, arg9, arg15, arg6);
        run_v31_1<T0, T1, T2, T3>(false, arg0, arg1, arg2, arg3, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16);
    }

    public fun batch_flash_liq_suilend_v31_with_extra_seize_1_with_pyth_push<T0, T1, T2, T3>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u128, arg13: vector<0x2::object::ID>, arg14: vector<u64>, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<T0>(arg3, arg7, arg15, arg4);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<T0>(arg3, arg8, arg15, arg5);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<T0>(arg3, arg9, arg15, arg6);
        run_v31_1<T0, T1, T2, T3>(true, arg0, arg1, arg2, arg3, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16);
    }

    public fun batch_flash_liq_suilend_v31_with_extra_seize_2_keeper_ride<T0, T1, T2, T3, T4>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u128, arg15: vector<0x2::object::ID>, arg16: vector<u64>, arg17: &0x2::clock::Clock, arg18: &mut 0x2::tx_context::TxContext) {
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<T0>(arg3, arg8, arg17, arg4);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<T0>(arg3, arg9, arg17, arg5);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<T0>(arg3, arg10, arg17, arg6);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<T0>(arg3, arg11, arg17, arg7);
        run_v31_2<T0, T1, T2, T3, T4>(false, arg0, arg1, arg2, arg3, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18);
    }

    public fun batch_flash_liq_suilend_v31_with_extra_seize_2_with_pyth_push<T0, T1, T2, T3, T4>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u128, arg15: vector<0x2::object::ID>, arg16: vector<u64>, arg17: &0x2::clock::Clock, arg18: &mut 0x2::tx_context::TxContext) {
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<T0>(arg3, arg8, arg17, arg4);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<T0>(arg3, arg9, arg17, arg5);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<T0>(arg3, arg10, arg17, arg6);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<T0>(arg3, arg11, arg17, arg7);
        run_v31_2<T0, T1, T2, T3, T4>(true, arg0, arg1, arg2, arg3, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18);
    }

    public fun batch_flash_liq_suilend_v31_with_extra_seize_3_keeper_ride<T0, T1, T2, T3, T4, T5>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u128, arg17: vector<0x2::object::ID>, arg18: vector<u64>, arg19: &0x2::clock::Clock, arg20: &mut 0x2::tx_context::TxContext) {
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<T0>(arg3, arg9, arg19, arg4);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<T0>(arg3, arg10, arg19, arg5);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<T0>(arg3, arg11, arg19, arg6);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<T0>(arg3, arg12, arg19, arg7);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<T0>(arg3, arg13, arg19, arg8);
        run_v31_3<T0, T1, T2, T3, T4, T5>(false, arg0, arg1, arg2, arg3, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20);
    }

    public fun batch_flash_liq_suilend_v31_with_extra_seize_3_with_pyth_push<T0, T1, T2, T3, T4, T5>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u128, arg17: vector<0x2::object::ID>, arg18: vector<u64>, arg19: &0x2::clock::Clock, arg20: &mut 0x2::tx_context::TxContext) {
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<T0>(arg3, arg9, arg19, arg4);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<T0>(arg3, arg10, arg19, arg5);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<T0>(arg3, arg11, arg19, arg6);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<T0>(arg3, arg12, arg19, arg7);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<T0>(arg3, arg13, arg19, arg8);
        run_v31_3<T0, T1, T2, T3, T4, T5>(true, arg0, arg1, arg2, arg3, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20);
    }

    fun do_extra_seize<T0, T1, T2>(arg0: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg1: 0x2::object::ID, arg2: address, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x2::coin::Coin<T1>, arg8: &mut u64, arg9: &mut u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext, arg12: u8) {
        let v0 = 0x2::coin::value<T1>(arg7);
        if (v0 == 0) {
            return
        };
        let v1 = if (arg6 < v0) {
            arg6
        } else {
            v0
        };
        if (v1 == 0) {
            return
        };
        let v2 = 0x2::coin::split<T1>(arg7, v1, arg11);
        let v3 = 0x2::coin::value<T1>(&v2);
        let (v4, _) = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::liquidate<T0, T1, T2>(arg0, arg1, arg4, arg5, arg10, &mut v2, arg11);
        let v6 = 0x2::coin::value<T1>(&v2);
        let v7 = if (v3 > v6) {
            v3 - v6
        } else {
            0
        };
        0x2::coin::join<T1>(arg7, v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T2>>>(v4, 0x2::tx_context::sender(arg11));
        let v8 = ExtraSeizeDone{
            user                    : arg2,
            index                   : arg3,
            extra_seize_reserve_idx : arg5,
            repay_used              : v7,
            slot                    : arg12,
        };
        0x2::event::emit<ExtraSeizeDone>(v8);
        *arg9 = *arg9 + 1;
        *arg8 = *arg8 + v7;
    }

    fun do_main_seize<T0, T1, T2>(arg0: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg1: 0x2::object::ID, arg2: address, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x2::coin::Coin<T1>, arg8: &mut 0x2::balance::Balance<T2>, arg9: &mut u64, arg10: &mut u64, arg11: &mut u64, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T1>(arg7);
        let v1 = if (arg6 < v0) {
            arg6
        } else {
            v0
        };
        if (v1 == 0) {
            let v2 = BatchSkipV31{
                user   : arg2,
                reason : 1,
                index  : arg3,
            };
            0x2::event::emit<BatchSkipV31>(v2);
            *arg11 = *arg11 + 1;
            return
        };
        let v3 = 0x2::coin::value<T1>(arg7);
        let (v4, v5) = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::liquidate<T0, T1, T2>(arg0, arg1, arg4, arg5, arg12, arg7, arg13);
        let v6 = 0x2::coin::value<T1>(arg7);
        let v7 = if (v3 > v6) {
            v3 - v6
        } else {
            0
        };
        let v8 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::fulfill_liquidity_request<T0, T2>(arg0, arg5, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity_request<T0, T2>(arg0, arg5, arg12, v4, 0x1::option::some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, T2>>(v5), arg13), arg13);
        0x2::balance::join<T2>(arg8, 0x2::coin::into_balance<T2>(v8));
        let v9 = BatchLiquidatedV31{
            user        : arg2,
            index       : arg3,
            repay_used  : v7,
            coll_seized : 0x2::coin::value<T2>(&v8),
        };
        0x2::event::emit<BatchLiquidatedV31>(v9);
        *arg10 = *arg10 + 1;
        *arg9 = *arg9 + v7;
    }

    fun finalize<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, T0>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::balance::Balance<T1>, arg6: u64, arg7: u128, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: bool, arg14: u8, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<T1>(&arg5);
        if (v0 > 0) {
            let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, false, true, v0, arg7, arg15);
            let v4 = v3;
            0x2::balance::destroy_zero<T1>(v2);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut arg5, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v4)), v4);
            0x2::coin::join<T0>(&mut arg4, 0x2::coin::from_balance<T0>(v1, arg16));
        };
        if (0x2::balance::value<T1>(&arg5) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(arg5, arg16), 0x2::tx_context::sender(arg16));
        } else {
            0x2::balance::destroy_zero<T1>(arg5);
        };
        let v5 = 0x2::coin::into_balance<T0>(arg4);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<0x2::sui::SUI, T0>(arg0, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v5, arg6), arg16), arg3);
        let v6 = 0x2::balance::value<T0>(&v5);
        if (v6 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v5, arg16), 0x2::tx_context::sender(arg16));
        } else {
            0x2::balance::destroy_zero<T0>(v5);
        };
        let v7 = BatchSummaryV31{
            batch_size        : arg8,
            liquidated_count  : arg9,
            skipped_count     : arg10,
            extra_seize_count : arg11,
            total_repay_used  : arg12,
            flash_amount      : arg6,
            final_payout      : v6,
            push_phase0       : arg13,
            cross_type_drains : arg14,
        };
        0x2::event::emit<BatchSummaryV31>(v7);
    }

    fun run_v31_1<T0, T1, T2, T3>(arg0: bool, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u128, arg11: vector<0x2::object::ID>, arg12: vector<u64>, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<0x2::object::ID>(&arg11);
        assert!(v0 == 0x1::vector::length<u64>(&arg12), 3);
        assert!(v0 > 0, 4);
        let (v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<0x2::sui::SUI, T1>(arg1, arg9, arg14);
        let v3 = v1;
        let v4 = 0x2::balance::zero<T2>();
        let v5 = 0;
        let v6 = 0;
        let v7 = 0;
        let v8 = 0;
        let v9 = 0;
        while (v9 < v0) {
            let v10 = *0x1::vector::borrow<0x2::object::ID>(&arg11, v9);
            let v11 = 0x2::object::id_to_address(&v10);
            let v12 = *0x1::vector::borrow<u64>(&arg12, v9);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_obligation<T0>(arg4, v10, arg13);
            if (!0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::is_liquidatable<T0>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation<T0>(arg4, v10))) {
                let v13 = BatchSkipV31{
                    user   : v11,
                    reason : 0,
                    index  : v9,
                };
                0x2::event::emit<BatchSkipV31>(v13);
                let v14 = v7;
                v7 = v14 + 1;
                v9 = v9 + 1;
                continue
            };
            let v15 = &mut v3;
            let v16 = &mut v5;
            let v17 = &mut v8;
            do_extra_seize<T0, T1, T3>(arg4, v10, v11, v9, arg5, arg7, arg8, v15, v16, v17, arg13, arg14, 1);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_obligation<T0>(arg4, v10, arg13);
            if (!0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::is_liquidatable<T0>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation<T0>(arg4, v10))) {
                let v18 = BatchSkipV31{
                    user   : v11,
                    reason : 2,
                    index  : v9,
                };
                0x2::event::emit<BatchSkipV31>(v18);
                let v19 = v7;
                v7 = v19 + 1;
                v9 = v9 + 1;
                continue
            };
            let v20 = &mut v3;
            let v21 = &mut v4;
            let v22 = &mut v5;
            let v23 = &mut v6;
            let v24 = &mut v7;
            do_main_seize<T0, T1, T2>(arg4, v10, v11, v9, arg5, arg6, v12, v20, v21, v22, v23, v24, arg13, arg14);
            v9 = v9 + 1;
        };
        finalize<T1, T2>(arg1, arg2, arg3, v2, v3, v4, arg9, arg10, v0, v6, v7, v8, v5, arg0, 1, arg13, arg14);
    }

    fun run_v31_2<T0, T1, T2, T3, T4>(arg0: bool, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u128, arg12: vector<0x2::object::ID>, arg13: vector<u64>, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<0x2::object::ID>(&arg12);
        assert!(v0 == 0x1::vector::length<u64>(&arg13), 3);
        assert!(v0 > 0, 4);
        let (v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<0x2::sui::SUI, T1>(arg1, arg10, arg15);
        let v3 = v1;
        let v4 = 0x2::balance::zero<T2>();
        let v5 = 0;
        let v6 = 0;
        let v7 = 0;
        let v8 = 0;
        let v9 = 0;
        while (v9 < v0) {
            let v10 = *0x1::vector::borrow<0x2::object::ID>(&arg12, v9);
            let v11 = 0x2::object::id_to_address(&v10);
            let v12 = *0x1::vector::borrow<u64>(&arg13, v9);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_obligation<T0>(arg4, v10, arg14);
            if (!0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::is_liquidatable<T0>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation<T0>(arg4, v10))) {
                let v13 = BatchSkipV31{
                    user   : v11,
                    reason : 0,
                    index  : v9,
                };
                0x2::event::emit<BatchSkipV31>(v13);
                let v14 = v7;
                v7 = v14 + 1;
                v9 = v9 + 1;
                continue
            };
            let v15 = &mut v3;
            let v16 = &mut v5;
            let v17 = &mut v8;
            do_extra_seize<T0, T1, T3>(arg4, v10, v11, v9, arg5, arg7, arg9, v15, v16, v17, arg14, arg15, 1);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_obligation<T0>(arg4, v10, arg14);
            if (0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::is_liquidatable<T0>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation<T0>(arg4, v10))) {
                let v18 = &mut v3;
                let v19 = &mut v5;
                let v20 = &mut v8;
                do_extra_seize<T0, T1, T4>(arg4, v10, v11, v9, arg5, arg8, arg9, v18, v19, v20, arg14, arg15, 2);
            };
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_obligation<T0>(arg4, v10, arg14);
            if (!0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::is_liquidatable<T0>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation<T0>(arg4, v10))) {
                let v21 = BatchSkipV31{
                    user   : v11,
                    reason : 2,
                    index  : v9,
                };
                0x2::event::emit<BatchSkipV31>(v21);
                let v22 = v7;
                v7 = v22 + 1;
                v9 = v9 + 1;
                continue
            };
            let v23 = &mut v3;
            let v24 = &mut v4;
            let v25 = &mut v5;
            let v26 = &mut v6;
            let v27 = &mut v7;
            do_main_seize<T0, T1, T2>(arg4, v10, v11, v9, arg5, arg6, v12, v23, v24, v25, v26, v27, arg14, arg15);
            v9 = v9 + 1;
        };
        finalize<T1, T2>(arg1, arg2, arg3, v2, v3, v4, arg10, arg11, v0, v6, v7, v8, v5, arg0, 2, arg14, arg15);
    }

    fun run_v31_3<T0, T1, T2, T3, T4, T5>(arg0: bool, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u128, arg13: vector<0x2::object::ID>, arg14: vector<u64>, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<0x2::object::ID>(&arg13);
        assert!(v0 == 0x1::vector::length<u64>(&arg14), 3);
        assert!(v0 > 0, 4);
        let (v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<0x2::sui::SUI, T1>(arg1, arg11, arg16);
        let v3 = v1;
        let v4 = 0x2::balance::zero<T2>();
        let v5 = 0;
        let v6 = 0;
        let v7 = 0;
        let v8 = 0;
        let v9 = 0;
        while (v9 < v0) {
            let v10 = *0x1::vector::borrow<0x2::object::ID>(&arg13, v9);
            let v11 = 0x2::object::id_to_address(&v10);
            let v12 = *0x1::vector::borrow<u64>(&arg14, v9);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_obligation<T0>(arg4, v10, arg15);
            if (!0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::is_liquidatable<T0>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation<T0>(arg4, v10))) {
                let v13 = BatchSkipV31{
                    user   : v11,
                    reason : 0,
                    index  : v9,
                };
                0x2::event::emit<BatchSkipV31>(v13);
                let v14 = v7;
                v7 = v14 + 1;
                v9 = v9 + 1;
                continue
            };
            let v15 = &mut v3;
            let v16 = &mut v5;
            let v17 = &mut v8;
            do_extra_seize<T0, T1, T3>(arg4, v10, v11, v9, arg5, arg7, arg10, v15, v16, v17, arg15, arg16, 1);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_obligation<T0>(arg4, v10, arg15);
            if (0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::is_liquidatable<T0>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation<T0>(arg4, v10))) {
                let v18 = &mut v3;
                let v19 = &mut v5;
                let v20 = &mut v8;
                do_extra_seize<T0, T1, T4>(arg4, v10, v11, v9, arg5, arg8, arg10, v18, v19, v20, arg15, arg16, 2);
            };
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_obligation<T0>(arg4, v10, arg15);
            if (0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::is_liquidatable<T0>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation<T0>(arg4, v10))) {
                let v21 = &mut v3;
                let v22 = &mut v5;
                let v23 = &mut v8;
                do_extra_seize<T0, T1, T5>(arg4, v10, v11, v9, arg5, arg9, arg10, v21, v22, v23, arg15, arg16, 3);
            };
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_obligation<T0>(arg4, v10, arg15);
            if (!0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::is_liquidatable<T0>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation<T0>(arg4, v10))) {
                let v24 = BatchSkipV31{
                    user   : v11,
                    reason : 2,
                    index  : v9,
                };
                0x2::event::emit<BatchSkipV31>(v24);
                let v25 = v7;
                v7 = v25 + 1;
                v9 = v9 + 1;
                continue
            };
            let v26 = &mut v3;
            let v27 = &mut v4;
            let v28 = &mut v5;
            let v29 = &mut v6;
            let v30 = &mut v7;
            do_main_seize<T0, T1, T2>(arg4, v10, v11, v9, arg5, arg6, v12, v26, v27, v28, v29, v30, arg15, arg16);
            v9 = v9 + 1;
        };
        finalize<T1, T2>(arg1, arg2, arg3, v2, v3, v4, arg11, arg12, v0, v6, v7, v8, v5, arg0, 3, arg15, arg16);
    }

    // decompiled from Move bytecode v7
}

