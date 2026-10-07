module 0x38ea4a3b567e11660deb7172899420b0a8e469cdc16094219864ee917131e51b::router {
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
        0x38ea4a3b567e11660deb7172899420b0a8e469cdc16094219864ee917131e51b::guards::assert_settlement(0x2::balance::value<T2>(&v8), v4, arg8, arg9);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T2, T1>(arg0, arg1, 0x2::balance::split<T2>(&mut v8, v4), 0x2::balance::zero<T1>(), v3);
        0x2::coin::from_balance<T2>(v8, arg11)
    }

    // decompiled from Move bytecode v7
}

