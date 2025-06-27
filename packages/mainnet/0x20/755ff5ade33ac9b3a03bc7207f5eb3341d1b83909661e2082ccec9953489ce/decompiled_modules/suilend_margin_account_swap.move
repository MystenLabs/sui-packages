module 0x20755ff5ade33ac9b3a03bc7207f5eb3341d1b83909661e2082ccec9953489ce::suilend_margin_account_swap {
    public fun swap<T0, T1>(arg0: &0x20755ff5ade33ac9b3a03bc7207f5eb3341d1b83909661e2082ccec9953489ce::suilend_margin_account::ProtectedMarginAccount, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg2: &mut 0x20755ff5ade33ac9b3a03bc7207f5eb3341d1b83909661e2082ccec9953489ce::rfq_account::Account, arg3: u128, arg4: &mut 0x20755ff5ade33ac9b3a03bc7207f5eb3341d1b83909661e2082ccec9953489ce::rfq_account::NonceLane, arg5: u64, arg6: vector<u8>, arg7: u64, arg8: 0x2::coin::Coin<T0>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::value<T0>(&arg8);
        0x20755ff5ade33ac9b3a03bc7207f5eb3341d1b83909661e2082ccec9953489ce::rfq_account::verify_signature<T0, T1>(arg2, arg3, 0x2::object::id<0x20755ff5ade33ac9b3a03bc7207f5eb3341d1b83909661e2082ccec9953489ce::suilend_margin_account::ProtectedMarginAccount>(arg0), arg4, arg7, v0, arg5, arg6, arg9);
        0x20755ff5ade33ac9b3a03bc7207f5eb3341d1b83909661e2082ccec9953489ce::suilend_margin_account::assert_for_account(arg0, arg2);
        let v1 = 0x20755ff5ade33ac9b3a03bc7207f5eb3341d1b83909661e2082ccec9953489ce::suilend_margin_account::unsafe_borrow_obligation_cap(arg0);
        let v2 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation_id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(v1);
        let v3 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve_array_index<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>(arg1);
        if (0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::ceil(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::borrowed_amount<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg1, v2))) != 0) {
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::repay<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>(arg1, v3, v2, arg9, &mut arg8, arg10);
        };
        if (0x2::coin::value<T0>(&arg8) != 0) {
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_ctokens_into_obligation<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>(arg1, v3, v1, arg9, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_liquidity_and_mint_ctokens<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>(arg1, v3, arg9, arg8, arg10), arg10);
        } else {
            0x2::coin::destroy_zero<T0>(arg8);
        };
        let v4 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve_array_index<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T1>(arg1);
        let v5 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::deposited_ctoken_amount<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T1>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg1, v2));
        let v6 = tokens_to_ctokens<T1>(arg1, v4, arg7, arg9);
        let v7 = 0x2::coin::zero<T1>(arg10);
        if (v5 != 0) {
            0x2::coin::join<T1>(&mut v7, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T1>(arg1, v4, arg9, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::withdraw_ctokens<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T1>(arg1, v4, v1, arg9, 0x1::u64::min(v6, v5), arg10), 0x1::option::none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T1>>(), arg10));
        };
        let v8 = arg7 - 0x2::coin::value<T1>(&v7);
        if (v8 != 0) {
            0x2::coin::join<T1>(&mut v7, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T1>(arg1, v4, v1, arg9, v8, arg10));
        };
        0x20755ff5ade33ac9b3a03bc7207f5eb3341d1b83909661e2082ccec9953489ce::swap::emit_swap_event<T0, T1>(arg3, 0x2::object::id<0x20755ff5ade33ac9b3a03bc7207f5eb3341d1b83909661e2082ccec9953489ce::rfq_account::Account>(arg2), 0x2::object::id<0x20755ff5ade33ac9b3a03bc7207f5eb3341d1b83909661e2082ccec9953489ce::rfq_account::NonceLane>(arg4), 0x20755ff5ade33ac9b3a03bc7207f5eb3341d1b83909661e2082ccec9953489ce::rfq_account::nonce_lane_value(arg4), v0, arg7);
        v7
    }

    fun tokens_to_ctokens<T0>(arg0: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock) : u64 {
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::compound_interest<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg0, arg1, arg3);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::floor(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::div(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(arg2), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::ctoken_ratio<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>(arg0))))
    }

    // decompiled from Move bytecode v6
}

