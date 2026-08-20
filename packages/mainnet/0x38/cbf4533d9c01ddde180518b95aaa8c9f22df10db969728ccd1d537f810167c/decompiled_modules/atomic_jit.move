module 0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_jit {
    struct AtomicJitFundingResult has copy, drop {
        vault_id: 0x2::object::ID,
        obligation: 0x2::object::ID,
        funded: bool,
        result_code: u8,
        debt_funded_raw: u64,
        reserve_spent_raw: u64,
    }

    fun emit(arg0: &0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_vault::LiquidationVault, arg1: 0x2::object::ID, arg2: bool, arg3: u8, arg4: u64, arg5: u64) {
        let v0 = AtomicJitFundingResult{
            vault_id          : 0x2::object::id<0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_vault::LiquidationVault>(arg0),
            obligation        : arg1,
            funded            : arg2,
            result_code       : arg3,
            debt_funded_raw   : arg4,
            reserve_spent_raw : arg5,
        };
        0x2::event::emit<AtomicJitFundingResult>(v0);
    }

    public fun try_direct_a_to_b<T0, T1, T2, T3>(arg0: &mut 0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_vault::LiquidationVault, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg4: 0x2::object::ID, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u128, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : bool {
        0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_vault::assert_authorized(arg0, arg12);
        assert!(arg10 > 0, 0);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_obligation<T0>(arg1, arg4, arg11);
        if (!0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::is_liquidatable<T0>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation<T0>(arg1, arg4))) {
            emit(arg0, arg4, false, 2, 0, 0);
            return 0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic::try_liquidate_authorized<T0, T2, T3>(arg0, arg1, arg4, arg5, arg6, arg7, arg8, arg11, arg12)
        };
        let v0 = 0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_vault::balance<T2>(arg0);
        if (v0 < arg7) {
            let v1 = arg7 - v0;
            let (v2, v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T2>(arg2, arg3, true, false, v1, arg10, arg11);
            let v5 = v4;
            let v6 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T2>(&v5);
            assert!(v6 <= arg9, 1);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T2>(arg2, arg3, 0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_vault::withdraw_for_liquidation<T1>(arg0, v6), 0x2::balance::zero<T2>(), v5);
            0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_vault::deposit_balance<T1>(arg0, v2);
            0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_vault::deposit_balance<T2>(arg0, v3);
            emit(arg0, arg4, true, 0, v1, v6);
        } else {
            emit(arg0, arg4, false, 0, 0, 0);
        };
        0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic::try_liquidate_authorized<T0, T2, T3>(arg0, arg1, arg4, arg5, arg6, arg7, arg8, arg11, arg12)
    }

    public fun try_direct_b_to_a<T0, T1, T2, T3>(arg0: &mut 0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_vault::LiquidationVault, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg4: 0x2::object::ID, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u128, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : bool {
        0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_vault::assert_authorized(arg0, arg12);
        assert!(arg10 > 0, 0);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_obligation<T0>(arg1, arg4, arg11);
        if (!0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::is_liquidatable<T0>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation<T0>(arg1, arg4))) {
            emit(arg0, arg4, false, 2, 0, 0);
            return 0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic::try_liquidate_authorized<T0, T1, T3>(arg0, arg1, arg4, arg5, arg6, arg7, arg8, arg11, arg12)
        };
        let v0 = 0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_vault::balance<T1>(arg0);
        if (v0 < arg7) {
            let v1 = arg7 - v0;
            let (v2, v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T2>(arg2, arg3, false, false, v1, arg10, arg11);
            let v5 = v4;
            let v6 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T2>(&v5);
            assert!(v6 <= arg9, 1);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T2>(arg2, arg3, 0x2::balance::zero<T1>(), 0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_vault::withdraw_for_liquidation<T2>(arg0, v6), v5);
            0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_vault::deposit_balance<T1>(arg0, v2);
            0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_vault::deposit_balance<T2>(arg0, v3);
            emit(arg0, arg4, true, 0, v1, v6);
        } else {
            emit(arg0, arg4, false, 0, 0, 0);
        };
        0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic::try_liquidate_authorized<T0, T1, T3>(arg0, arg1, arg4, arg5, arg6, arg7, arg8, arg11, arg12)
    }

    // decompiled from Move bytecode v7
}

