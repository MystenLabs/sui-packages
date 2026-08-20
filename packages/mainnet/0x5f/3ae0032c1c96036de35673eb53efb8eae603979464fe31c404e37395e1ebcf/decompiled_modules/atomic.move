module 0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic {
    struct AtomicResult has copy, drop {
        vault_id: 0x2::object::ID,
        obligation: 0x2::object::ID,
        debt_type: 0x1::type_name::TypeName,
        collateral_type: 0x1::type_name::TypeName,
        liquidated: bool,
        result_code: u8,
        repay_raw: u64,
        collateral_raw: u64,
        debt_remainder_raw: u64,
    }

    fun emit_result<T0, T1>(arg0: &0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_vault::LiquidationVault, arg1: 0x2::object::ID, arg2: bool, arg3: u8, arg4: u64, arg5: u64, arg6: u64) {
        let v0 = AtomicResult{
            vault_id           : 0x2::object::id<0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_vault::LiquidationVault>(arg0),
            obligation         : arg1,
            debt_type          : 0x1::type_name::with_defining_ids<T0>(),
            collateral_type    : 0x1::type_name::with_defining_ids<T1>(),
            liquidated         : arg2,
            result_code        : arg3,
            repay_raw          : arg4,
            collateral_raw     : arg5,
            debt_remainder_raw : arg6,
        };
        0x2::event::emit<AtomicResult>(v0);
    }

    public fun try_liquidate_authorized<T0, T1, T2>(arg0: &mut 0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_vault::LiquidationVault, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : bool {
        let (v0, _, _, _) = try_liquidate_authorized_with_result<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        v0
    }

    public(friend) fun try_liquidate_authorized_with_result<T0, T1, T2>(arg0: &mut 0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_vault::LiquidationVault, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (bool, u64, u64, u64) {
        0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_vault::assert_authorized(arg0, arg8);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_obligation<T0>(arg1, arg2, arg7);
        if (!0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::is_liquidatable<T0>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation<T0>(arg1, arg2))) {
            emit_result<T1, T2>(arg0, arg2, false, 2, 0, 0, 0);
            return (false, 0, 0, 0)
        };
        let v0 = 0x1::u64::min(0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_vault::balance<T1>(arg0), arg5);
        if (v0 == 0) {
            emit_result<T1, T2>(arg0, arg2, false, 1, 0, 0, 0);
            return (false, 0, 0, 0)
        };
        let v1 = 0x2::coin::from_balance<T1>(0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_vault::withdraw_for_liquidation<T1>(arg0, v0), arg8);
        let (v2, v3) = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::liquidate<T0, T1, T2>(arg1, arg2, arg3, arg4, arg7, &mut v1, arg8);
        let v4 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<T0, T2>(arg1, arg4, arg7, v2, 0x1::option::some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, T2>>(v3), arg8);
        let v5 = 0x2::coin::value<T1>(&v1);
        let v6 = 0x2::coin::value<T2>(&v4);
        let v7 = v0 - v5;
        assert!(v7 >= arg6, 13906834655379718143);
        0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_vault::deposit_balance<T1>(arg0, 0x2::coin::into_balance<T1>(v1));
        0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_vault::deposit_balance<T2>(arg0, 0x2::coin::into_balance<T2>(v4));
        emit_result<T1, T2>(arg0, arg2, true, 0, v7, v6, v5);
        (true, v7, v6, v5)
    }

    // decompiled from Move bytecode v7
}

