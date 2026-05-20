module 0x4342299897150e43ed71c09aeee9b66c9f0f324cdf7e3a4089b786f513666842::liquidator_suilend_flash_v3 {
    struct BatchSkipV3 has copy, drop {
        user: address,
        reason: u8,
        index: u64,
    }

    struct PreRedeemDone has copy, drop {
        user: address,
        index: u64,
        pre_redeem_reserve_idx: u64,
        repay_used: u64,
    }

    struct BatchLiquidatedV3 has copy, drop {
        user: address,
        index: u64,
        repay_used: u64,
        coll_seized: u64,
    }

    struct BatchSummaryV3 has copy, drop {
        batch_size: u64,
        liquidated_count: u64,
        skipped_count: u64,
        pre_redeem_count: u64,
        total_repay_used: u64,
        flash_amount: u64,
        final_payout: u64,
        push_phase0: bool,
        variant: u8,
    }

    public fun batch_flash_liq_suilend_v3_keeper_ride<T0, T1, T2>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &vector<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>, arg7: vector<u64>, arg8: u64, arg9: u64, arg10: vector<u64>, arg11: u64, arg12: u64, arg13: u128, arg14: vector<0x2::object::ID>, arg15: vector<u64>, arg16: &0x2::clock::Clock, arg17: &mut 0x2::tx_context::TxContext) {
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<T0>(arg3, arg8, arg16, arg4);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<T0>(arg3, arg9, arg16, arg5);
        refresh_extras<T0>(arg3, arg16, arg6, &arg7);
        batch_flash_liquidate_v3_swap_a<T0, T1, T2>(false, arg0, arg1, arg2, arg3, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17);
    }

    public fun batch_flash_liq_suilend_v3_with_pyth_push<T0, T1, T2>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &vector<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>, arg7: vector<u64>, arg8: u64, arg9: u64, arg10: vector<u64>, arg11: u64, arg12: u64, arg13: u128, arg14: vector<0x2::object::ID>, arg15: vector<u64>, arg16: &0x2::clock::Clock, arg17: &mut 0x2::tx_context::TxContext) {
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<T0>(arg3, arg8, arg16, arg4);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<T0>(arg3, arg9, arg16, arg5);
        refresh_extras<T0>(arg3, arg16, arg6, &arg7);
        batch_flash_liquidate_v3_swap_a<T0, T1, T2>(true, arg0, arg1, arg2, arg3, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17);
    }

    fun batch_flash_liquidate_v3_swap_a<T0, T1, T2>(arg0: bool, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: u64, arg6: u64, arg7: vector<u64>, arg8: u64, arg9: u64, arg10: u128, arg11: vector<0x2::object::ID>, arg12: vector<u64>, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
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
                let v13 = BatchSkipV3{
                    user   : v11,
                    reason : 0,
                    index  : v9,
                };
                0x2::event::emit<BatchSkipV3>(v13);
                v7 = v7 + 1;
                v9 = v9 + 1;
                continue
            };
            let v14 = 0;
            while (v14 < 0x1::vector::length<u64>(&arg7)) {
                let v15 = *0x1::vector::borrow<u64>(&arg7, v14);
                0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_obligation<T0>(arg4, v10, arg13);
                if (!0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::is_liquidatable<T0>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation<T0>(arg4, v10))) {
                    break
                };
                let v16 = 0x2::coin::value<T1>(&v3);
                if (v16 == 0) {
                    break
                };
                let v17 = if (arg8 < v16) {
                    arg8
                } else {
                    v16
                };
                if (v17 == 0) {
                    break
                };
                let v18 = 0x2::coin::split<T1>(&mut v3, v17, arg14);
                let v19 = 0x2::coin::value<T1>(&v18);
                let (v20, _) = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::liquidate<T0, T1, T2>(arg4, v10, arg5, v15, arg13, &mut v18, arg14);
                let v22 = 0x2::coin::value<T1>(&v18);
                let v23 = if (v19 > v22) {
                    v19 - v22
                } else {
                    0
                };
                0x2::coin::join<T1>(&mut v3, v18);
                0x2::transfer::public_transfer<0x2::coin::Coin<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T2>>>(v20, 0x2::tx_context::sender(arg14));
                let v24 = PreRedeemDone{
                    user                   : v11,
                    index                  : v9,
                    pre_redeem_reserve_idx : v15,
                    repay_used             : v23,
                };
                0x2::event::emit<PreRedeemDone>(v24);
                v8 = v8 + 1;
                v5 = v5 + v23;
                v14 = v14 + 1;
            };
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_obligation<T0>(arg4, v10, arg13);
            if (!0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::is_liquidatable<T0>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation<T0>(arg4, v10))) {
                let v25 = BatchSkipV3{
                    user   : v11,
                    reason : 2,
                    index  : v9,
                };
                0x2::event::emit<BatchSkipV3>(v25);
                v7 = v7 + 1;
                v9 = v9 + 1;
                continue
            };
            let v26 = 0x2::coin::value<T1>(&v3);
            let v27 = if (v12 < v26) {
                v12
            } else {
                v26
            };
            if (v27 == 0) {
                let v28 = BatchSkipV3{
                    user   : v11,
                    reason : 1,
                    index  : v9,
                };
                0x2::event::emit<BatchSkipV3>(v28);
                v7 = v7 + 1;
                v9 = v9 + 1;
                continue
            };
            let v29 = 0x2::coin::value<T1>(&v3);
            let (v30, v31) = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::liquidate<T0, T1, T2>(arg4, v10, arg5, arg6, arg13, &mut v3, arg14);
            let v32 = 0x2::coin::value<T1>(&v3);
            let v33 = if (v29 > v32) {
                v29 - v32
            } else {
                0
            };
            let v34 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::fulfill_liquidity_request<T0, T2>(arg4, arg6, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity_request<T0, T2>(arg4, arg6, arg13, v30, 0x1::option::some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, T2>>(v31), arg14), arg14);
            0x2::balance::join<T2>(&mut v4, 0x2::coin::into_balance<T2>(v34));
            let v35 = BatchLiquidatedV3{
                user        : v11,
                index       : v9,
                repay_used  : v33,
                coll_seized : 0x2::coin::value<T2>(&v34),
            };
            0x2::event::emit<BatchLiquidatedV3>(v35);
            v6 = v6 + 1;
            v5 = v5 + v33;
            v9 = v9 + 1;
        };
        let v36 = 0x2::balance::value<T2>(&v4);
        if (v36 > 0) {
            let (v37, v38, v39) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T2>(arg2, arg3, false, true, v36, arg10, arg13);
            let v40 = v39;
            0x2::balance::destroy_zero<T2>(v38);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T2>(arg2, arg3, 0x2::balance::zero<T1>(), 0x2::balance::split<T2>(&mut v4, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T2>(&v40)), v40);
            0x2::coin::join<T1>(&mut v3, 0x2::coin::from_balance<T1>(v37, arg14));
        };
        if (0x2::balance::value<T2>(&v4) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v4, arg14), 0x2::tx_context::sender(arg14));
        } else {
            0x2::balance::destroy_zero<T2>(v4);
        };
        let v41 = 0x2::coin::into_balance<T1>(v3);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<0x2::sui::SUI, T1>(arg1, 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v41, arg9), arg14), v2);
        let v42 = 0x2::balance::value<T1>(&v41);
        if (v42 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v41, arg14), 0x2::tx_context::sender(arg14));
        } else {
            0x2::balance::destroy_zero<T1>(v41);
        };
        let v43 = BatchSummaryV3{
            batch_size       : v0,
            liquidated_count : v6,
            skipped_count    : v7,
            pre_redeem_count : v8,
            total_repay_used : v5,
            flash_amount     : arg9,
            final_payout     : v42,
            push_phase0      : arg0,
            variant          : 0,
        };
        0x2::event::emit<BatchSummaryV3>(v43);
    }

    fun refresh_extras<T0>(arg0: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg1: &0x2::clock::Clock, arg2: &vector<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>, arg3: &vector<u64>) {
        let v0 = 0x1::vector::length<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg2);
        assert!(v0 == 0x1::vector::length<u64>(arg3), 5);
        let v1 = 0;
        while (v1 < v0) {
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<T0>(arg0, *0x1::vector::borrow<u64>(arg3, v1), arg1, 0x1::vector::borrow<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg2, v1));
            v1 = v1 + 1;
        };
    }

    // decompiled from Move bytecode v7
}

