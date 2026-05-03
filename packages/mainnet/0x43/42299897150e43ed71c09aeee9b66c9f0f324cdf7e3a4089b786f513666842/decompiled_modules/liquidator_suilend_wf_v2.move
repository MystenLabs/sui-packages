module 0x4342299897150e43ed71c09aeee9b66c9f0f324cdf7e3a4089b786f513666842::liquidator_suilend_wf_v2 {
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
        wallet_in: u64,
        final_payout: u64,
        push_phase0: bool,
        variant: u8,
    }

    public fun batch_wf_liq_suilend_keeper_ride<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: u64, arg6: u64, arg7: u128, arg8: 0x2::coin::Coin<T1>, arg9: vector<0x2::object::ID>, arg10: vector<u64>, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<T0>(arg2, arg5, arg11, arg3);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<T0>(arg2, arg6, arg11, arg4);
        batch_wf_liquidate_swap_a<T0, T1, T2>(false, arg0, arg1, arg2, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    public fun batch_wf_liq_suilend_with_pyth_push<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: u64, arg6: u64, arg7: u128, arg8: 0x2::coin::Coin<T1>, arg9: vector<0x2::object::ID>, arg10: vector<u64>, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<T0>(arg2, arg5, arg11, arg3);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<T0>(arg2, arg6, arg11, arg4);
        batch_wf_liquidate_swap_a<T0, T1, T2>(true, arg0, arg1, arg2, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    fun batch_wf_liquidate_swap_a<T0, T1, T2>(arg0: bool, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: u64, arg5: u64, arg6: u128, arg7: 0x2::coin::Coin<T1>, arg8: vector<0x2::object::ID>, arg9: vector<u64>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<0x2::object::ID>(&arg8);
        assert!(v0 == 0x1::vector::length<u64>(&arg9), 3);
        assert!(v0 > 0, 4);
        let v1 = 0x2::balance::zero<T2>();
        let v2 = 0;
        let v3 = 0;
        let v4 = 0;
        let v5 = 0;
        while (v5 < v0) {
            let v6 = *0x1::vector::borrow<0x2::object::ID>(&arg8, v5);
            let v7 = 0x2::object::id_to_address(&v6);
            let v8 = *0x1::vector::borrow<u64>(&arg9, v5);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_obligation<T0>(arg3, v6, arg10);
            if (!0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::is_liquidatable<T0>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation<T0>(arg3, v6))) {
                let v9 = BatchSkip{
                    user   : v7,
                    reason : 0,
                    index  : v5,
                };
                0x2::event::emit<BatchSkip>(v9);
                v4 = v4 + 1;
                v5 = v5 + 1;
                continue
            };
            let v10 = 0x2::coin::value<T1>(&arg7);
            let v11 = if (v8 < v10) {
                v8
            } else {
                v10
            };
            if (v11 == 0) {
                let v12 = BatchSkip{
                    user   : v7,
                    reason : 1,
                    index  : v5,
                };
                0x2::event::emit<BatchSkip>(v12);
                v4 = v4 + 1;
                v5 = v5 + 1;
                continue
            };
            let v13 = 0x2::coin::value<T1>(&arg7);
            let (v14, v15) = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::liquidate<T0, T1, T2>(arg3, v6, arg4, arg5, arg10, &mut arg7, arg11);
            let v16 = 0x2::coin::value<T1>(&arg7);
            let v17 = if (v13 > v16) {
                v13 - v16
            } else {
                0
            };
            let v18 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::fulfill_liquidity_request<T0, T2>(arg3, arg5, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity_request<T0, T2>(arg3, arg5, arg10, v14, 0x1::option::some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, T2>>(v15), arg11), arg11);
            0x2::balance::join<T2>(&mut v1, 0x2::coin::into_balance<T2>(v18));
            let v19 = BatchLiquidated{
                user        : v7,
                index       : v5,
                repay_used  : v17,
                coll_seized : 0x2::coin::value<T2>(&v18),
            };
            0x2::event::emit<BatchLiquidated>(v19);
            v3 = v3 + 1;
            v2 = v2 + v17;
            v5 = v5 + 1;
        };
        let v20 = 0x2::balance::value<T2>(&v1);
        if (v20 > 0) {
            let (v21, v22, v23) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T2>(arg1, arg2, false, true, v20, arg6, arg10);
            let v24 = v23;
            0x2::balance::destroy_zero<T2>(v22);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T2>(arg1, arg2, 0x2::balance::zero<T1>(), 0x2::balance::split<T2>(&mut v1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T2>(&v24)), v24);
            0x2::coin::join<T1>(&mut arg7, 0x2::coin::from_balance<T1>(v21, arg11));
        };
        if (0x2::balance::value<T2>(&v1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v1, arg11), 0x2::tx_context::sender(arg11));
        } else {
            0x2::balance::destroy_zero<T2>(v1);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg7, 0x2::tx_context::sender(arg11));
        let v25 = BatchSummary{
            batch_size       : v0,
            liquidated_count : v3,
            skipped_count    : v4,
            total_repay_used : v2,
            wallet_in        : 0x2::coin::value<T1>(&arg7),
            final_payout     : 0x2::coin::value<T1>(&arg7),
            push_phase0      : arg0,
            variant          : 0,
        };
        0x2::event::emit<BatchSummary>(v25);
    }

    // decompiled from Move bytecode v6
}

