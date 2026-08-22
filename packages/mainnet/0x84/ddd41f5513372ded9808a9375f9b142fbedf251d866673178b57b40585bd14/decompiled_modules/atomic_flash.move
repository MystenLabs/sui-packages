module 0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_flash {
    struct AtomicFlashResult has copy, drop {
        vault_id: 0x2::object::ID,
        obligation: 0x2::object::ID,
        debt_type: 0x1::type_name::TypeName,
        collateral_type: 0x1::type_name::TypeName,
        liquidated: bool,
        result_code: u8,
        repay_raw: u64,
        collateral_raw: u64,
        collateral_paid_raw: u64,
        collateral_profit_raw: u64,
        debt_remainder_raw: u64,
        route_hops: u8,
    }

    fun emit_noop<T0, T1>(arg0: &0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_vault::LiquidationVault, arg1: 0x2::object::ID) {
        let v0 = AtomicFlashResult{
            vault_id              : 0x2::object::id<0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_vault::LiquidationVault>(arg0),
            obligation            : arg1,
            debt_type             : 0x1::type_name::with_defining_ids<T0>(),
            collateral_type       : 0x1::type_name::with_defining_ids<T1>(),
            liquidated            : false,
            result_code           : 2,
            repay_raw             : 0,
            collateral_raw        : 0,
            collateral_paid_raw   : 0,
            collateral_profit_raw : 0,
            debt_remainder_raw    : 0,
            route_hops            : 0,
        };
        0x2::event::emit<AtomicFlashResult>(v0);
    }

    fun finish<T0, T1>(arg0: &mut 0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_vault::LiquidationVault, arg1: 0x2::object::ID, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T1>, arg4: u64, arg5: u64, arg6: u64, arg7: u8) {
        let v0 = 0x2::balance::value<T0>(&arg2);
        let v1 = arg4 - v0;
        assert!(v1 >= arg5, 13906835522963111935);
        let v2 = 0x2::balance::value<T1>(&arg3);
        0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_vault::deposit_balance<T0>(arg0, arg2);
        0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_vault::deposit_balance<T1>(arg0, arg3);
        let v3 = AtomicFlashResult{
            vault_id              : 0x2::object::id<0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_vault::LiquidationVault>(arg0),
            obligation            : arg1,
            debt_type             : 0x1::type_name::with_defining_ids<T0>(),
            collateral_type       : 0x1::type_name::with_defining_ids<T1>(),
            liquidated            : true,
            result_code           : 0,
            repay_raw             : v1,
            collateral_raw        : v2 + arg6,
            collateral_paid_raw   : arg6,
            collateral_profit_raw : v2,
            debt_remainder_raw    : v0,
            route_hops            : arg7,
        };
        0x2::event::emit<AtomicFlashResult>(v3);
    }

    fun finish_redeemed_lst<T0, T1>(arg0: &mut 0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_vault::LiquidationVault, arg1: 0x2::object::ID, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<0x2::sui::SUI>, arg4: u64, arg5: u64, arg6: u64, arg7: u64) {
        let v0 = 0x2::balance::value<T0>(&arg2);
        let v1 = arg4 - v0;
        assert!(v1 >= arg5, 13906835664697032703);
        0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_vault::deposit_balance<T0>(arg0, arg2);
        0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_vault::deposit_balance<0x2::sui::SUI>(arg0, arg3);
        let v2 = AtomicFlashResult{
            vault_id              : 0x2::object::id<0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_vault::LiquidationVault>(arg0),
            obligation            : arg1,
            debt_type             : 0x1::type_name::with_defining_ids<T0>(),
            collateral_type       : 0x1::type_name::with_defining_ids<T1>(),
            liquidated            : true,
            result_code           : 0,
            repay_raw             : v1,
            collateral_raw        : arg6,
            collateral_paid_raw   : arg7,
            collateral_profit_raw : 0x2::balance::value<0x2::sui::SUI>(&arg3),
            debt_remainder_raw    : v0,
            route_hops            : 2,
        };
        0x2::event::emit<AtomicFlashResult>(v2);
    }

    fun liquidate<T0, T1, T2>(arg0: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg1: &mut 0x2::coin::Coin<T1>, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        let (v0, v1) = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::liquidate<T0, T1, T2>(arg0, arg2, arg3, arg4, arg5, arg1, arg6);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<T0, T2>(arg0, arg4, arg5, v0, 0x1::option::some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, T2>>(v1), arg6)
    }

    fun prepare<T0>(arg0: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) : bool {
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_obligation<T0>(arg0, arg1, arg2);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::is_liquidatable<T0>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation<T0>(arg0, arg1))
    }

    fun require_profit<T0>(arg0: &0x2::balance::Balance<T0>, arg1: u64, arg2: u64) {
        assert!(arg1 <= 18446744073709551615 - arg2, 1);
        assert!(0x2::balance::value<T0>(arg0) >= arg1 + arg2, 1);
    }

    fun settle_direct<T0, T1>(arg0: &mut 0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_vault::LiquidationVault, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: 0x2::object::ID, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::balance::Balance<T1>, arg6: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T1, T0>, arg7: u64, arg8: u64, arg9: u64, arg10: u64) {
        require_profit<T1>(&arg5, arg9, arg10);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T0>(arg1, arg2, 0x2::balance::split<T1>(&mut arg5, arg9), 0x2::balance::zero<T0>(), arg6);
        finish<T0, T1>(arg0, arg3, 0x2::coin::into_balance<T0>(arg4), arg5, arg7, arg8, arg9, 1);
    }

    public fun try_direct_a_to_b<T0, T1, T2>(arg0: &mut 0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_vault::LiquidationVault, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg4: 0x2::object::ID, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u128, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : bool {
        0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_vault::assert_authorized(arg0, arg12);
        assert!(arg9 > 0, 0);
        let v0 = prepare<T0>(arg1, arg4, arg11);
        if (!v0) {
            emit_noop<T2, T1>(arg0, arg4);
            return false
        };
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T2>(arg2, arg3, true, false, arg7, arg9, arg11);
        let v4 = v3;
        let v5 = 0x2::coin::from_balance<T2>(v2, arg12);
        let v6 = &mut v5;
        let v7 = 0x2::coin::into_balance<T1>(liquidate<T0, T2, T1>(arg1, v6, arg4, arg5, arg6, arg11, arg12));
        0x2::balance::join<T1>(&mut v7, v1);
        settle_direct<T2, T1>(arg0, arg2, arg3, arg4, v5, v7, v4, arg7, arg8, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T2>(&v4), arg10);
        true
    }

    public fun try_direct_b_to_a<T0, T1, T2>(arg0: &mut 0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_vault::LiquidationVault, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg4: 0x2::object::ID, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u128, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : bool {
        0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_vault::assert_authorized(arg0, arg12);
        assert!(arg9 > 0, 0);
        let v0 = prepare<T0>(arg1, arg4, arg11);
        if (!v0) {
            emit_noop<T1, T2>(arg0, arg4);
            return false
        };
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T2>(arg2, arg3, false, false, arg7, arg9, arg11);
        let v4 = v3;
        let v5 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T2>(&v4);
        let v6 = 0x2::coin::from_balance<T1>(v1, arg12);
        let v7 = &mut v6;
        let v8 = 0x2::coin::into_balance<T2>(liquidate<T0, T1, T2>(arg1, v7, arg4, arg5, arg6, arg11, arg12));
        0x2::balance::join<T2>(&mut v8, v2);
        require_profit<T2>(&v8, v5, arg10);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T2>(arg2, arg3, 0x2::balance::zero<T1>(), 0x2::balance::split<T2>(&mut v8, v5), v4);
        finish<T1, T2>(arg0, arg4, 0x2::coin::into_balance<T1>(v6), v8, arg7, arg8, v5, 1);
        true
    }

    public fun try_lst_b_to_a<T0, T1, T2: drop>(arg0: &mut 0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_vault::LiquidationVault, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, 0x2::sui::SUI>, arg4: &mut 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T2>, arg5: &mut 0x3::sui_system::SuiSystemState, arg6: 0x2::object::ID, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u128, arg12: u64, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) : bool {
        0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_vault::assert_authorized(arg0, arg14);
        assert!(arg11 > 0, 0);
        let v0 = prepare<T0>(arg1, arg6, arg13);
        if (!v0) {
            emit_noop<T1, T2>(arg0, arg6);
            return false
        };
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, 0x2::sui::SUI>(arg2, arg3, false, false, arg9, arg11, arg13);
        let v4 = v3;
        let v5 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, 0x2::sui::SUI>(&v4);
        let v6 = 0x2::coin::from_balance<T1>(v1, arg14);
        let v7 = &mut v6;
        let v8 = liquidate<T0, T1, T2>(arg1, v7, arg6, arg7, arg8, arg13, arg14);
        let v9 = 0x2::coin::into_balance<0x2::sui::SUI>(0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::redeem<T2>(arg4, v8, arg5, arg14));
        0x2::balance::join<0x2::sui::SUI>(&mut v9, v2);
        require_profit<0x2::sui::SUI>(&v9, v5, arg12);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, 0x2::sui::SUI>(arg2, arg3, 0x2::balance::zero<T1>(), 0x2::balance::split<0x2::sui::SUI>(&mut v9, v5), v4);
        finish_redeemed_lst<T1, T2>(arg0, arg6, 0x2::coin::into_balance<T1>(v6), v9, arg9, arg10, 0x2::coin::value<T2>(&v8), v5);
        true
    }

    public fun try_two_ab_ba<T0, T1, T2, T3>(arg0: &mut 0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_vault::LiquidationVault, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T2>, arg5: 0x2::object::ID, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u128, arg11: u128, arg12: u64, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) : bool {
        0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_vault::assert_authorized(arg0, arg14);
        assert!(arg10 > 0 && arg11 > 0, 0);
        let v0 = prepare<T0>(arg1, arg5, arg13);
        if (!v0) {
            emit_noop<T3, T1>(arg0, arg5);
            return false
        };
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T3, T2>(arg2, arg4, false, false, arg8, arg11, arg13);
        let v4 = v3;
        let (v5, v6, v7) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T2>(arg2, arg3, true, false, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T3, T2>(&v4), arg10, arg13);
        let v8 = v7;
        let v9 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T2>(&v8);
        let v10 = 0x2::coin::from_balance<T3>(v1, arg14);
        let v11 = &mut v10;
        let v12 = 0x2::coin::into_balance<T1>(liquidate<T0, T3, T1>(arg1, v11, arg5, arg6, arg7, arg13, arg14));
        0x2::balance::join<T1>(&mut v12, v5);
        require_profit<T1>(&v12, v9, arg12);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T2>(arg2, arg3, 0x2::balance::split<T1>(&mut v12, v9), 0x2::balance::zero<T2>(), v8);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T3, T2>(arg2, arg4, 0x2::balance::zero<T3>(), v6, v4);
        0x2::balance::destroy_zero<T2>(v2);
        finish<T3, T1>(arg0, arg5, 0x2::coin::into_balance<T3>(v10), v12, arg8, arg9, v9, 2);
        true
    }

    // decompiled from Move bytecode v7
}

