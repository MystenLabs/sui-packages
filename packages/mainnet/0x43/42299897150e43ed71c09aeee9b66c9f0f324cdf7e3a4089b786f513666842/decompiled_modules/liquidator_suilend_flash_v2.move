module 0x4342299897150e43ed71c09aeee9b66c9f0f324cdf7e3a4089b786f513666842::liquidator_suilend_flash_v2 {
    struct BatchSkip has copy, drop {
        user: address,
        reason: u8,
        index: u64,
    }

    struct BatchLiquidated has copy, drop {
        user: address,
        index: u64,
        repay_used: u64,
        coll_seized: u64,
    }

    struct BatchSummary has copy, drop {
        batch_size: u64,
        liquidated_count: u64,
        skipped_count: u64,
        total_repay_used: u64,
        flash_amount: u64,
        final_payout: u64,
        push_phase0: bool,
        variant: u8,
    }

    public fun batch_flash_liq_suilend_keeper_ride<T0, T1, T2>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: u64, arg7: u64, arg8: u64, arg9: u128, arg10: vector<0x2::object::ID>, arg11: vector<u64>, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<T0>(arg3, arg6, arg12, arg4);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<T0>(arg3, arg7, arg12, arg5);
        batch_flash_liquidate_swap_a<T0, T1, T2>(false, arg0, arg1, arg2, arg3, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
    }

    public fun batch_flash_liq_suilend_with_pyth_push<T0, T1, T2>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: u64, arg7: u64, arg8: u64, arg9: u128, arg10: vector<0x2::object::ID>, arg11: vector<u64>, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<T0>(arg3, arg6, arg12, arg4);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<T0>(arg3, arg7, arg12, arg5);
        batch_flash_liquidate_swap_a<T0, T1, T2>(true, arg0, arg1, arg2, arg3, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
    }

    fun batch_flash_liquidate_swap_a<T0, T1, T2>(arg0: bool, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: u64, arg6: u64, arg7: u64, arg8: u128, arg9: vector<0x2::object::ID>, arg10: vector<u64>, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<0x2::object::ID>(&arg9);
        assert!(v0 == 0x1::vector::length<u64>(&arg10), 3);
        assert!(v0 > 0, 4);
        let (v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<0x2::sui::SUI, T1>(arg1, arg7, arg12);
        let v3 = v1;
        let v4 = 0x2::balance::zero<T2>();
        let v5 = 0;
        let v6 = 0;
        let v7 = 0;
        let v8 = 0;
        while (v8 < v0) {
            let v9 = *0x1::vector::borrow<0x2::object::ID>(&arg9, v8);
            let v10 = 0x2::object::id_to_address(&v9);
            let v11 = *0x1::vector::borrow<u64>(&arg10, v8);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_obligation<T0>(arg4, v9, arg11);
            if (!0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::is_liquidatable<T0>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation<T0>(arg4, v9))) {
                let v12 = BatchSkip{
                    user   : v10,
                    reason : 0,
                    index  : v8,
                };
                0x2::event::emit<BatchSkip>(v12);
                v7 = v7 + 1;
                v8 = v8 + 1;
                continue
            };
            let v13 = 0x2::coin::value<T1>(&v3);
            let v14 = if (v11 < v13) {
                v11
            } else {
                v13
            };
            if (v14 == 0) {
                let v15 = BatchSkip{
                    user   : v10,
                    reason : 1,
                    index  : v8,
                };
                0x2::event::emit<BatchSkip>(v15);
                v7 = v7 + 1;
                v8 = v8 + 1;
                continue
            };
            let v16 = 0x2::coin::value<T1>(&v3);
            let (v17, v18) = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::liquidate<T0, T1, T2>(arg4, v9, arg5, arg6, arg11, &mut v3, arg12);
            let v19 = 0x2::coin::value<T1>(&v3);
            let v20 = if (v16 > v19) {
                v16 - v19
            } else {
                0
            };
            let v21 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::fulfill_liquidity_request<T0, T2>(arg4, arg6, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity_request<T0, T2>(arg4, arg6, arg11, v17, 0x1::option::some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, T2>>(v18), arg12), arg12);
            0x2::balance::join<T2>(&mut v4, 0x2::coin::into_balance<T2>(v21));
            let v22 = BatchLiquidated{
                user        : v10,
                index       : v8,
                repay_used  : v20,
                coll_seized : 0x2::coin::value<T2>(&v21),
            };
            0x2::event::emit<BatchLiquidated>(v22);
            v6 = v6 + 1;
            v5 = v5 + v20;
            v8 = v8 + 1;
        };
        let v23 = 0x2::balance::value<T2>(&v4);
        if (v23 > 0) {
            let (v24, v25, v26) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T2>(arg2, arg3, false, true, v23, arg8, arg11);
            let v27 = v26;
            0x2::balance::destroy_zero<T2>(v25);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T2>(arg2, arg3, 0x2::balance::zero<T1>(), 0x2::balance::split<T2>(&mut v4, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T2>(&v27)), v27);
            0x2::coin::join<T1>(&mut v3, 0x2::coin::from_balance<T1>(v24, arg12));
        };
        if (0x2::balance::value<T2>(&v4) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v4, arg12), 0x2::tx_context::sender(arg12));
        } else {
            0x2::balance::destroy_zero<T2>(v4);
        };
        let v28 = 0x2::coin::into_balance<T1>(v3);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<0x2::sui::SUI, T1>(arg1, 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v28, arg7), arg12), v2);
        let v29 = 0x2::balance::value<T1>(&v28);
        if (v29 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v28, arg12), 0x2::tx_context::sender(arg12));
        } else {
            0x2::balance::destroy_zero<T1>(v28);
        };
        let v30 = BatchSummary{
            batch_size       : v0,
            liquidated_count : v6,
            skipped_count    : v7,
            total_repay_used : v5,
            flash_amount     : arg7,
            final_payout     : v29,
            push_phase0      : arg0,
            variant          : 0,
        };
        0x2::event::emit<BatchSummary>(v30);
    }

    // decompiled from Move bytecode v6
}

