module 0x72ffb0d663eb5c08ecb0f4edefde1dca3e8d8eb1b312e71ef41b5b86c3bbf7fb::router {
    public fun flash_liq_suilend_bf_direct<T0, T1, T2>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: address, arg4: u64, arg5: u64, arg6: u64, arg7: u128, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = flash_liq_suilend_bf_direct_coin<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v0, 0x2::tx_context::sender(arg11));
    }

    public fun flash_liq_suilend_bf_direct_coin<T0, T1, T2>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: address, arg4: u64, arg5: u64, arg6: u64, arg7: u128, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T1>(arg10, arg0, arg1, true, false, arg6, arg7);
        let v3 = v2;
        0x2::balance::destroy_zero<T2>(v0);
        let v4 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T2, T1>(&v3);
        let v5 = 0x2::coin::from_balance<T1>(v1, arg11);
        let (v6, v7) = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::liquidate<T0, T1, T2>(arg2, 0x2::object::id_from_address(arg3), arg4, arg5, arg10, &mut v5, arg11);
        if (0x2::coin::value<T1>(&v5) == 0) {
            0x2::coin::destroy_zero<T1>(v5);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v5, 0x2::tx_context::sender(arg11));
        };
        let v8 = 0x2::coin::into_balance<T2>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::fulfill_liquidity_request<T0, T2>(arg2, arg5, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity_request<T0, T2>(arg2, arg5, arg10, v6, 0x1::option::some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, T2>>(v7), arg11), arg11));
        0x72ffb0d663eb5c08ecb0f4edefde1dca3e8d8eb1b312e71ef41b5b86c3bbf7fb::guards::assert_settlement(0x2::balance::value<T2>(&v8), v4, arg8, arg9);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T2, T1>(arg0, arg1, 0x2::balance::split<T2>(&mut v8, v4), 0x2::balance::zero<T1>(), v3);
        0x2::coin::from_balance<T2>(v8, arg11)
    }

    public fun flash_liq_suilend_bf_sui_coin<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, T1>, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: address, arg5: u64, arg6: u64, arg7: u64, arg8: u128, arg9: u64, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<0x2::sui::SUI, T1>(arg11, arg0, arg1, true, false, arg7, arg8);
        let v3 = v2;
        0x2::balance::destroy_zero<0x2::sui::SUI>(v0);
        let v4 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<0x2::sui::SUI, T1>(&v3);
        let v5 = 0x2::coin::from_balance<T1>(v1, arg12);
        let (v6, v7) = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::liquidate<T0, T1, 0x2::sui::SUI>(arg2, 0x2::object::id_from_address(arg4), arg5, arg6, arg11, &mut v5, arg12);
        let v8 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity_request<T0, 0x2::sui::SUI>(arg2, arg6, arg11, v6, 0x1::option::some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, 0x2::sui::SUI>>(v7), arg12);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::unstake_sui_from_staker<T0>(arg2, arg6, &v8, arg3, arg12);
        if (0x2::coin::value<T1>(&v5) == 0) {
            0x2::coin::destroy_zero<T1>(v5);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v5, 0x2::tx_context::sender(arg12));
        };
        let v9 = 0x2::coin::into_balance<0x2::sui::SUI>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::fulfill_liquidity_request<T0, 0x2::sui::SUI>(arg2, arg6, v8, arg12));
        0x72ffb0d663eb5c08ecb0f4edefde1dca3e8d8eb1b312e71ef41b5b86c3bbf7fb::guards::assert_settlement(0x2::balance::value<0x2::sui::SUI>(&v9), v4, arg9, arg10);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<0x2::sui::SUI, T1>(arg0, arg1, 0x2::balance::split<0x2::sui::SUI>(&mut v9, v4), 0x2::balance::zero<T1>(), v3);
        0x2::coin::from_balance<0x2::sui::SUI>(v9, arg12)
    }

    // decompiled from Move bytecode v7
}

