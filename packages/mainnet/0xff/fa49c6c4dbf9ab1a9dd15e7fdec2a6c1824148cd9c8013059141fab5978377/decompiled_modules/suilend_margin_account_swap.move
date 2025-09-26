module 0xfffa49c6c4dbf9ab1a9dd15e7fdec2a6c1824148cd9c8013059141fab5978377::suilend_margin_account_swap {
    public fun swap<T0, T1>(arg0: &mut 0xfffa49c6c4dbf9ab1a9dd15e7fdec2a6c1824148cd9c8013059141fab5978377::suilend_margin_account::ProtectedMarginAccount, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg2: &mut 0x3236de80fab6042a0b3a1b89d8c4d12733652727a1d451a5d0470ed17416ca8e::rfq_account::Account, arg3: u128, arg4: u128, arg5: u64, arg6: vector<u8>, arg7: u64, arg8: u64, arg9: u64, arg10: 0x2::coin::Coin<T0>, arg11: &0x2::clock::Clock, arg12: &mut 0x3::sui_system::SuiSystemState, arg13: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x3236de80fab6042a0b3a1b89d8c4d12733652727a1d451a5d0470ed17416ca8e::rfq_account::verify_signature<T0, T1>(arg2, arg3, 0x2::object::id<0xfffa49c6c4dbf9ab1a9dd15e7fdec2a6c1824148cd9c8013059141fab5978377::suilend_margin_account::ProtectedMarginAccount>(arg0), arg4, arg7, arg8, arg9, arg5, arg6, arg11);
        let v0 = 0x2::coin::value<T0>(&arg10);
        let v1 = 0x3236de80fab6042a0b3a1b89d8c4d12733652727a1d451a5d0470ed17416ca8e::rfq_account::calc_output_by_quote(arg7, arg8, arg9, v0);
        0xfffa49c6c4dbf9ab1a9dd15e7fdec2a6c1824148cd9c8013059141fab5978377::suilend_margin_account::assert_for_account(arg0, arg2);
        let (v2, v3) = 0xfffa49c6c4dbf9ab1a9dd15e7fdec2a6c1824148cd9c8013059141fab5978377::suilend_margin_account::unsafe_borrow_obligation_cap(arg0);
        let v4 = v2;
        let v5 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation_id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(&v4);
        let v6 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve_array_index<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>(arg1);
        if (0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::ceil(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::borrowed_amount<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg1, v5))) != 0) {
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::repay<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>(arg1, v6, v5, arg11, &mut arg10, arg13);
        };
        if (0x2::coin::value<T0>(&arg10) != 0) {
            0xfffa49c6c4dbf9ab1a9dd15e7fdec2a6c1824148cd9c8013059141fab5978377::suilend_margin_account::deposit_liquidity<T0>(arg1, &v4, v6, arg10, arg11, arg12, arg13);
        } else {
            0x2::coin::destroy_zero<T0>(arg10);
        };
        let v7 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve_array_index<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T1>(arg1);
        let v8 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::deposited_ctoken_amount<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T1>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg1, v5));
        let v9 = tokens_to_ctokens<T1>(arg1, v7, v1, arg11);
        let v10 = 0x2::coin::zero<T1>(arg13);
        if (v8 != 0) {
            0x2::coin::join<T1>(&mut v10, 0xfffa49c6c4dbf9ab1a9dd15e7fdec2a6c1824148cd9c8013059141fab5978377::suilend_margin_account::withdraw_collateral<T1>(arg1, &v4, v7, 0x1::u64::min(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::ceil(v9), v8), arg11, arg12, arg13));
        };
        if (v1 > 0x2::coin::value<T1>(&v10)) {
            0x2::coin::join<T1>(&mut v10, 0xfffa49c6c4dbf9ab1a9dd15e7fdec2a6c1824148cd9c8013059141fab5978377::suilend_margin_account::borrow_liquidity<T1>(arg1, &v4, v7, v1 - 0x2::coin::value<T1>(&v10), arg11, arg12, arg13));
        };
        0x3236de80fab6042a0b3a1b89d8c4d12733652727a1d451a5d0470ed17416ca8e::swap::emit_swap_event<T0, T1>(arg3, 0x2::object::id<0x3236de80fab6042a0b3a1b89d8c4d12733652727a1d451a5d0470ed17416ca8e::rfq_account::Account>(arg2), 0x2::object::id<0xfffa49c6c4dbf9ab1a9dd15e7fdec2a6c1824148cd9c8013059141fab5978377::suilend_margin_account::ProtectedMarginAccount>(arg0), arg4, v0, 0x2::coin::value<T1>(&v10));
        0xfffa49c6c4dbf9ab1a9dd15e7fdec2a6c1824148cd9c8013059141fab5978377::suilend_margin_account::return_obligation_cap(arg0, v4, v3);
        v10
    }

    fun tokens_to_ctokens<T0>(arg0: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock) : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal {
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::compound_interest<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg0, arg1, arg3);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::div(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(arg2), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::ctoken_ratio<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>(arg0)))
    }

    // decompiled from Move bytecode v6
}

