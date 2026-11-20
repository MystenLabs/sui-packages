module 0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_momentum_flash {
    struct AtomicMomentumFlashResult has copy, drop {
        vault_id: 0x2::object::ID,
        obligation: 0x2::object::ID,
        debt_type: 0x1::type_name::TypeName,
        collateral_type: 0x1::type_name::TypeName,
        profit_type: 0x1::type_name::TypeName,
        liquidated: bool,
        result_code: u8,
        repay_raw: u64,
        collateral_raw: u64,
        collateral_paid_raw: u64,
        debt_remainder_raw: u64,
        collateral_profit_raw: u64,
        route_hops: u8,
    }

    public(friend) fun assert_profit(arg0: u64, arg1: u64, arg2: u64) {
        assert!(arg1 <= 18446744073709551615 - arg2, 1);
        assert!(arg0 >= arg1 + arg2, 1);
    }

    fun emit_result<T0, T1>(arg0: &0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_vault::LiquidationVault, arg1: 0x2::object::ID, arg2: bool, arg3: u8, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64) {
        let v0 = AtomicMomentumFlashResult{
            vault_id              : 0x2::object::id<0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_vault::LiquidationVault>(arg0),
            obligation            : arg1,
            debt_type             : 0x1::type_name::with_defining_ids<T0>(),
            collateral_type       : 0x1::type_name::with_defining_ids<T1>(),
            profit_type           : 0x1::type_name::with_defining_ids<0x2::sui::SUI>(),
            liquidated            : arg2,
            result_code           : arg3,
            repay_raw             : arg4,
            collateral_raw        : arg5,
            collateral_paid_raw   : arg6,
            debt_remainder_raw    : arg7,
            collateral_profit_raw : arg8,
            route_hops            : 1,
        };
        0x2::event::emit<AtomicMomentumFlashResult>(v0);
    }

    fun finish<T0, T1>(arg0: &mut 0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_vault::LiquidationVault, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, T0>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::FlashSwapReceipt, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::balance::Balance<0x2::sui::SUI>, arg6: 0x2::object::ID, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg4);
        let v1 = arg7 - v0;
        assert!(v1 >= arg9, 2);
        let (v2, v3) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&arg3);
        assert!(v3 == 0, 3);
        assert_profit(0x2::balance::value<0x2::sui::SUI>(&arg5), v2, arg10);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<0x2::sui::SUI, T0>(arg1, arg3, 0x2::balance::split<0x2::sui::SUI>(&mut arg5, v2), 0x2::balance::zero<T0>(), arg2, arg11);
        0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_vault::deposit_balance<0x2::sui::SUI>(arg0, arg5);
        0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_vault::deposit_balance<T0>(arg0, 0x2::coin::into_balance<T0>(arg4));
        emit_result<T0, T1>(arg0, arg6, true, 0, v1, arg8, v2, v0, 0x2::balance::value<0x2::sui::SUI>(&arg5));
    }

    public fun try_lst_collateral<T0, T1, T2: drop>(arg0: &mut 0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_vault::LiquidationVault, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, T1>, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: &mut 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T2>, arg5: &mut 0x3::sui_system::SuiSystemState, arg6: 0x2::object::ID, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : bool {
        0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_vault::assert_authorized(arg0, arg13);
        assert!(arg9 > 0 && arg10 > 0, 0);
        let (v0, v1) = 0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::momentum_sizing::flash_limits<T0, T1, T2>(arg0, arg1, arg6, arg7, arg8, arg9, arg10, arg12, arg13);
        if (v0 == 0) {
            emit_result<T1, T2>(arg0, arg6, false, 2, 0, 0, 0, 0, 0);
            return false
        };
        let (v2, v3, v4) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<0x2::sui::SUI, T1>(arg2, true, false, v0, 4295048017, arg12, arg3, arg13);
        let v5 = v3;
        let v6 = 0x2::coin::from_balance<T1>(v5, arg13);
        let (v7, v8) = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::liquidate<T0, T1, T2>(arg1, arg6, arg7, arg8, arg12, &mut v6, arg13);
        let v9 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<T0, T2>(arg1, arg8, arg12, v7, 0x1::option::some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, T2>>(v8), arg13);
        let v10 = 0x2::coin::into_balance<0x2::sui::SUI>(0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::redeem<T2>(arg4, v9, arg5, arg13));
        0x2::balance::join<0x2::sui::SUI>(&mut v10, v2);
        finish<T1, T2>(arg0, arg2, arg3, v4, v6, v10, arg6, 0x2::balance::value<T1>(&v5), 0x2::coin::value<T2>(&v9), v1, arg11, arg13);
        true
    }

    public fun try_sui_collateral<T0, T1>(arg0: &mut 0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_vault::LiquidationVault, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, T1>, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: 0x2::object::ID, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : bool {
        0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_vault::assert_authorized(arg0, arg12);
        assert!(arg8 > 0 && arg9 > 0, 0);
        let (v0, v1) = 0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::momentum_sizing::flash_limits<T0, T1, 0x2::sui::SUI>(arg0, arg1, arg5, arg6, arg7, arg8, arg9, arg11, arg12);
        if (v0 == 0) {
            emit_result<T1, 0x2::sui::SUI>(arg0, arg5, false, 2, 0, 0, 0, 0, 0);
            return false
        };
        let (v2, v3, v4) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<0x2::sui::SUI, T1>(arg2, true, false, v0, 4295048017, arg11, arg3, arg12);
        let v5 = v3;
        let v6 = 0x2::coin::from_balance<T1>(v5, arg12);
        let v7 = 0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::sui_redemption::liquidate<T0, T1>(arg1, arg4, &mut v6, arg5, arg6, arg7, arg11, arg12);
        let v8 = 0x2::coin::into_balance<0x2::sui::SUI>(v7);
        0x2::balance::join<0x2::sui::SUI>(&mut v8, v2);
        finish<T1, 0x2::sui::SUI>(arg0, arg2, arg3, v4, v6, v8, arg5, 0x2::balance::value<T1>(&v5), 0x2::coin::value<0x2::sui::SUI>(&v7), v1, arg10, arg12);
        true
    }

    // decompiled from Move bytecode v7
}

