module 0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_scallop_flash {
    struct AtomicScallopFlashResult has copy, drop {
        vault_id: 0x2::object::ID,
        obligation: 0x2::object::ID,
        debt_type: 0x1::type_name::TypeName,
        collateral_type: 0x1::type_name::TypeName,
        liquidated: bool,
        result_code: u8,
        flash_raw: u64,
        repay_raw: u64,
        collateral_raw: u64,
        profit_raw: u64,
        route_hops: u8,
    }

    fun emit_noop<T0, T1>(arg0: &0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_vault::LiquidationVault, arg1: 0x2::object::ID) {
        let v0 = AtomicScallopFlashResult{
            vault_id        : 0x2::object::id<0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_vault::LiquidationVault>(arg0),
            obligation      : arg1,
            debt_type       : 0x1::type_name::with_defining_ids<T0>(),
            collateral_type : 0x1::type_name::with_defining_ids<T1>(),
            liquidated      : false,
            result_code     : 2,
            flash_raw       : 0,
            repay_raw       : 0,
            collateral_raw  : 0,
            profit_raw      : 0,
            route_hops      : 0,
        };
        0x2::event::emit<AtomicScallopFlashResult>(v0);
    }

    fun liquidate<T0, T1, T2>(arg0: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg1: &mut 0x2::coin::Coin<T1>, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        let (v0, v1) = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::liquidate<T0, T1, T2>(arg0, arg2, arg3, arg4, arg5, arg1, arg6);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<T0, T2>(arg0, arg4, arg5, v0, 0x1::option::some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, T2>>(v1), arg6)
    }

    fun prepare<T0, T1>(arg0: &0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_vault::LiquidationVault, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: 0x2::object::ID, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) : u64 {
        0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_vault::assert_authorized(arg0, arg5);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_obligation<T0>(arg1, arg2, arg4);
        let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation<T0>(arg1, arg2);
        if (!0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::is_liquidatable<T0>(v0)) {
            return 0
        };
        let v1 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::ceil(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::borrowed_amount<T0, T1>(v0));
        if (v1 < arg3) {
            v1
        } else {
            arg3
        }
    }

    fun prepare_partial<T0, T1>(arg0: &0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_vault::LiquidationVault, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: 0x2::object::ID, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) : u64 {
        let v0 = prepare<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
        if (v0 == 0) {
            return 0
        };
        if (v0 % 5 == 0) {
            v0 / 5
        } else {
            v0 / 5 + 1
        }
    }

    fun settle<T0, T1>(arg0: &mut 0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_vault::LiquidationVault, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: 0x2::object::ID, arg4: 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::FlashLoan<T0>, arg5: 0x2::coin::Coin<T0>, arg6: 0x2::balance::Balance<T0>, arg7: 0x2::balance::Balance<T1>, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u8, arg13: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::flash_loan_loan_amount<T0>(&arg4) + 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::flash_loan_fee<T0>(&arg4);
        let v1 = 0x2::coin::into_balance<T0>(arg5);
        0x2::balance::join<T0>(&mut v1, arg6);
        assert!(v0 <= 18446744073709551615 - arg11, 1);
        assert!(0x2::balance::value<T0>(&v1) >= v0 + arg11, 1);
        0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_vault::deposit_balance<T0>(arg0, v1);
        0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_vault::deposit_balance<T1>(arg0, arg7);
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::flash_loan::repay_flash_loan<T0>(arg1, arg2, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v1, v0), arg13), arg4, arg13);
        let v2 = AtomicScallopFlashResult{
            vault_id        : 0x2::object::id<0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_vault::LiquidationVault>(arg0),
            obligation      : arg3,
            debt_type       : 0x1::type_name::with_defining_ids<T0>(),
            collateral_type : 0x1::type_name::with_defining_ids<T1>(),
            liquidated      : true,
            result_code     : 0,
            flash_raw       : arg8,
            repay_raw       : arg9,
            collateral_raw  : arg10,
            profit_raw      : 0x2::balance::value<T0>(&v1),
            route_hops      : arg12,
        };
        0x2::event::emit<AtomicScallopFlashResult>(v2);
    }

    fun swap_a_to_b<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: u128, arg4: &0x2::clock::Clock) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T0>) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, true, 0x2::balance::value<T0>(&arg2), arg3, arg4);
        let v3 = v2;
        0x2::balance::join<T0>(&mut arg2, v0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(&mut arg2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3)), 0x2::balance::zero<T1>(), v3);
        (v1, arg2)
    }

    fun swap_b_to_a<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T1>, arg3: u128, arg4: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, false, true, 0x2::balance::value<T1>(&arg2), arg3, arg4);
        let v3 = v2;
        0x2::balance::join<T1>(&mut arg2, v1);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut arg2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3)), v3);
        (v0, arg2)
    }

    public fun try_bridge_debt_lst_stable<T0, T1, T2, T3: drop>(arg0: &mut 0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_vault::LiquidationVault, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, 0x2::sui::SUI>, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg7: &mut 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T3>, arg8: &mut 0x3::sui_system::SuiSystemState, arg9: 0x2::object::ID, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u128, arg16: u128, arg17: u128, arg18: u64, arg19: &0x2::clock::Clock, arg20: &mut 0x2::tx_context::TxContext) : bool {
        0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_vault::assert_authorized(arg0, arg20);
        let v0 = if (arg15 > 0) {
            if (arg16 > 0) {
                arg17 > 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 0);
        let v1 = prepare_partial<T0, T2>(arg0, arg1, arg9, arg13, arg19, arg20);
        if (v1 == 0) {
            emit_noop<T2, T3>(arg0, arg9);
            return false
        };
        let (v2, v3) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::flash_loan::borrow_flash_loan<T1>(arg2, arg3, v1, arg20);
        let (v4, v5) = swap_a_to_b<T1, T2>(arg4, arg6, 0x2::coin::into_balance<T1>(v2), arg15, arg19);
        let v6 = v5;
        let v7 = 0x2::coin::from_balance<T2>(v4, arg20);
        let v8 = &mut v7;
        let v9 = liquidate<T0, T2, T3>(arg1, v8, arg9, arg10, arg11, arg19, arg20);
        let v10 = if (0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::is_liquidatable<T0>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation<T0>(arg1, arg9))) {
            let v11 = &mut v7;
            liquidate<T0, T2, T1>(arg1, v11, arg9, arg10, arg12, arg19, arg20)
        } else {
            0x2::coin::zero<T1>(arg20)
        };
        let v12 = 0x2::coin::value<T2>(&v7) - 0x2::coin::value<T2>(&v7);
        assert!(v12 >= arg14, 2);
        let (v13, v14) = swap_b_to_a<T1, 0x2::sui::SUI>(arg4, arg5, 0x2::coin::into_balance<0x2::sui::SUI>(0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::redeem<T3>(arg7, v9, arg8, arg20)), arg16, arg19);
        0x2::balance::join<T1>(&mut v6, v13);
        0x2::balance::join<T1>(&mut v6, 0x2::coin::into_balance<T1>(v10));
        let (v15, v16) = swap_b_to_a<T1, T2>(arg4, arg6, 0x2::coin::into_balance<T2>(v7), arg17, arg19);
        0x2::balance::join<T1>(&mut v6, v15);
        0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_vault::deposit_balance<0x2::sui::SUI>(arg0, v14);
        0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_vault::deposit_balance<T2>(arg0, v16);
        let v17 = 0x2::coin::zero<T1>(arg20);
        settle<T1, T3>(arg0, arg2, arg3, arg9, v3, v17, v6, 0x2::balance::zero<T3>(), v1, v12, 0x2::coin::value<T3>(&v9), arg18, 3, arg20);
        true
    }

    public fun try_cetus_flash_debt_a_sui_b<T0, T1>(arg0: &mut 0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_vault::LiquidationVault, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, 0x2::sui::SUI>, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: 0x2::object::ID, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : bool {
        0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_vault::assert_authorized(arg0, arg12);
        let v0 = prepare<T0, T1>(arg0, arg1, arg5, arg8, arg11, arg12);
        if (v0 == 0) {
            emit_noop<T1, 0x2::sui::SUI>(arg0, arg5);
            return false
        };
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, 0x2::sui::SUI>(arg2, arg3, false, false, v0, 79226673515401279992447579055, arg11);
        let v4 = v3;
        let v5 = 0x2::coin::from_balance<T1>(v1, arg12);
        let (v6, v7) = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::liquidate<T0, T1, 0x2::sui::SUI>(arg1, arg5, arg6, arg7, arg11, &mut v5, arg12);
        let v8 = v0 - 0x2::coin::value<T1>(&v5);
        assert!(v8 >= arg9, 2);
        let v9 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity_request<T0, 0x2::sui::SUI>(arg1, arg7, arg11, v6, 0x1::option::some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, 0x2::sui::SUI>>(v7), arg12);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::unstake_sui_from_staker<T0>(arg1, arg7, &v9, arg4, arg12);
        let v10 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::fulfill_liquidity_request<T0, 0x2::sui::SUI>(arg1, arg7, v9, arg12);
        let v11 = 0x2::coin::into_balance<0x2::sui::SUI>(v10);
        0x2::balance::join<0x2::sui::SUI>(&mut v11, v2);
        if (0x2::coin::value<T1>(&v5) == 0) {
            0x2::coin::destroy_zero<T1>(v5);
        } else {
            let (v12, v13) = swap_a_to_b<T1, 0x2::sui::SUI>(arg2, arg3, 0x2::coin::into_balance<T1>(v5), 79226673515401279992447579055, arg11);
            0x2::balance::join<0x2::sui::SUI>(&mut v11, v12);
            0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_vault::deposit_balance<T1>(arg0, v13);
        };
        let v14 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, 0x2::sui::SUI>(&v4);
        assert!(v14 <= 18446744073709551615 - arg10, 1);
        assert!(0x2::balance::value<0x2::sui::SUI>(&v11) >= v14 + arg10, 1);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, 0x2::sui::SUI>(arg2, arg3, 0x2::balance::zero<T1>(), 0x2::balance::split<0x2::sui::SUI>(&mut v11, v14), v4);
        0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_vault::deposit_balance<0x2::sui::SUI>(arg0, v11);
        let v15 = AtomicScallopFlashResult{
            vault_id        : 0x2::object::id<0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_vault::LiquidationVault>(arg0),
            obligation      : arg5,
            debt_type       : 0x1::type_name::with_defining_ids<T1>(),
            collateral_type : 0x1::type_name::with_defining_ids<0x2::sui::SUI>(),
            liquidated      : true,
            result_code     : 0,
            flash_raw       : v0,
            repay_raw       : v8,
            collateral_raw  : 0x2::coin::value<0x2::sui::SUI>(&v10),
            profit_raw      : 0x2::balance::value<0x2::sui::SUI>(&v11),
            route_hops      : 1,
        };
        0x2::event::emit<AtomicScallopFlashResult>(v15);
        true
    }

    public fun try_direct_a_to_b<T0, T1, T2>(arg0: &mut 0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_vault::LiquidationVault, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg6: 0x2::object::ID, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u128, arg12: u64, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) : bool {
        0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_vault::assert_authorized(arg0, arg14);
        assert!(arg11 > 0, 0);
        let v0 = prepare<T0, T2>(arg0, arg1, arg6, arg9, arg13, arg14);
        if (v0 == 0) {
            emit_noop<T2, T1>(arg0, arg6);
            return false
        };
        let (v1, v2) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::flash_loan::borrow_flash_loan<T2>(arg2, arg3, v0, arg14);
        let v3 = v1;
        let v4 = &mut v3;
        let v5 = liquidate<T0, T2, T1>(arg1, v4, arg6, arg7, arg8, arg13, arg14);
        let v6 = v0 - 0x2::coin::value<T2>(&v3);
        assert!(v6 >= arg10, 2);
        let (v7, v8) = swap_a_to_b<T1, T2>(arg4, arg5, 0x2::coin::into_balance<T1>(v5), arg11, arg13);
        settle<T2, T1>(arg0, arg2, arg3, arg6, v2, v3, v7, v8, v0, v6, 0x2::coin::value<T1>(&v5), arg12, 1, arg14);
        true
    }

    public fun try_direct_b_to_a<T0, T1, T2>(arg0: &mut 0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_vault::LiquidationVault, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg6: 0x2::object::ID, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u128, arg12: u64, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) : bool {
        0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_vault::assert_authorized(arg0, arg14);
        assert!(arg11 > 0, 0);
        let v0 = prepare<T0, T1>(arg0, arg1, arg6, arg9, arg13, arg14);
        if (v0 == 0) {
            emit_noop<T1, T2>(arg0, arg6);
            return false
        };
        let (v1, v2) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::flash_loan::borrow_flash_loan<T1>(arg2, arg3, v0, arg14);
        let v3 = v1;
        let v4 = &mut v3;
        let v5 = liquidate<T0, T1, T2>(arg1, v4, arg6, arg7, arg8, arg13, arg14);
        let v6 = v0 - 0x2::coin::value<T1>(&v3);
        assert!(v6 >= arg10, 2);
        let (v7, v8) = swap_b_to_a<T1, T2>(arg4, arg5, 0x2::coin::into_balance<T2>(v5), arg11, arg13);
        settle<T1, T2>(arg0, arg2, arg3, arg6, v2, v3, v7, v8, v0, v6, 0x2::coin::value<T2>(&v5), arg12, 1, arg14);
        true
    }

    public fun try_lst_to_debt_b_to_a<T0, T1, T2: drop>(arg0: &mut 0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_vault::LiquidationVault, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, 0x2::sui::SUI>, arg6: &mut 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T2>, arg7: &mut 0x3::sui_system::SuiSystemState, arg8: 0x2::object::ID, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u128, arg14: u64, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) : bool {
        0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_vault::assert_authorized(arg0, arg16);
        assert!(arg13 > 0, 0);
        let v0 = prepare<T0, T1>(arg0, arg1, arg8, arg11, arg15, arg16);
        if (v0 == 0) {
            emit_noop<T1, T2>(arg0, arg8);
            return false
        };
        let (v1, v2) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::flash_loan::borrow_flash_loan<T1>(arg2, arg3, v0, arg16);
        let v3 = v1;
        let v4 = &mut v3;
        let v5 = liquidate<T0, T1, T2>(arg1, v4, arg8, arg9, arg10, arg15, arg16);
        let v6 = v0 - 0x2::coin::value<T1>(&v3);
        assert!(v6 >= arg12, 2);
        let (v7, v8) = swap_b_to_a<T1, 0x2::sui::SUI>(arg4, arg5, 0x2::coin::into_balance<0x2::sui::SUI>(0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::redeem<T2>(arg6, v5, arg7, arg16)), arg13, arg15);
        0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_vault::deposit_balance<0x2::sui::SUI>(arg0, v8);
        settle<T1, T2>(arg0, arg2, arg3, arg8, v2, v3, v7, 0x2::balance::zero<T2>(), v0, v6, 0x2::coin::value<T2>(&v5), arg14, 1, arg16);
        true
    }

    public fun try_lst_to_sui<T0, T1: drop>(arg0: &mut 0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_vault::LiquidationVault, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &mut 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T1>, arg5: &mut 0x3::sui_system::SuiSystemState, arg6: 0x2::object::ID, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : bool {
        0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_vault::assert_authorized(arg0, arg13);
        let v0 = prepare<T0, 0x2::sui::SUI>(arg0, arg1, arg6, arg9, arg12, arg13);
        if (v0 == 0) {
            emit_noop<0x2::sui::SUI, T1>(arg0, arg6);
            return false
        };
        let (v1, v2) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::flash_loan::borrow_flash_loan<0x2::sui::SUI>(arg2, arg3, v0, arg13);
        let v3 = v1;
        let v4 = &mut v3;
        let v5 = liquidate<T0, 0x2::sui::SUI, T1>(arg1, v4, arg6, arg7, arg8, arg12, arg13);
        let v6 = v0 - 0x2::coin::value<0x2::sui::SUI>(&v3);
        assert!(v6 >= arg10, 2);
        let v7 = 0x2::coin::into_balance<0x2::sui::SUI>(0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::redeem<T1>(arg4, v5, arg5, arg13));
        settle<0x2::sui::SUI, T1>(arg0, arg2, arg3, arg6, v2, v3, v7, 0x2::balance::zero<T1>(), v0, v6, 0x2::coin::value<T1>(&v5), arg11, 0, arg13);
        true
    }

    public fun try_same_asset<T0, T1>(arg0: &mut 0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_vault::LiquidationVault, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: 0x2::object::ID, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : bool {
        0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_vault::assert_authorized(arg0, arg11);
        let v0 = prepare<T0, T1>(arg0, arg1, arg4, arg7, arg10, arg11);
        if (v0 == 0) {
            emit_noop<T1, T1>(arg0, arg4);
            return false
        };
        let (v1, v2) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::flash_loan::borrow_flash_loan<T1>(arg2, arg3, v0, arg11);
        let v3 = v1;
        let v4 = &mut v3;
        let v5 = liquidate<T0, T1, T1>(arg1, v4, arg4, arg5, arg6, arg10, arg11);
        let v6 = v0 - 0x2::coin::value<T1>(&v3);
        assert!(v6 >= arg8, 2);
        settle<T1, T1>(arg0, arg2, arg3, arg4, v2, v3, 0x2::coin::into_balance<T1>(v5), 0x2::balance::zero<T1>(), v0, v6, 0x2::coin::value<T1>(&v5), arg9, 0, arg11);
        true
    }

    public fun try_stable_lst_bridge<T0, T1, T2: drop, T3>(arg0: &mut 0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_vault::LiquidationVault, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, 0x2::sui::SUI>, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T3>, arg7: &mut 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T2>, arg8: &mut 0x3::sui_system::SuiSystemState, arg9: 0x2::object::ID, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u128, arg16: u128, arg17: u64, arg18: &0x2::clock::Clock, arg19: &mut 0x2::tx_context::TxContext) : bool {
        0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_vault::assert_authorized(arg0, arg19);
        assert!(arg15 > 0 && arg16 > 0, 0);
        let v0 = prepare_partial<T0, T1>(arg0, arg1, arg9, arg13, arg18, arg19);
        if (v0 == 0) {
            emit_noop<T1, T2>(arg0, arg9);
            return false
        };
        let (v1, v2) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::flash_loan::borrow_flash_loan<T1>(arg2, arg3, v0, arg19);
        let v3 = v1;
        let v4 = &mut v3;
        let v5 = liquidate<T0, T1, T2>(arg1, v4, arg9, arg10, arg11, arg18, arg19);
        let v6 = if (0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::is_liquidatable<T0>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation<T0>(arg1, arg9))) {
            let v7 = &mut v3;
            liquidate<T0, T1, T3>(arg1, v7, arg9, arg10, arg12, arg18, arg19)
        } else {
            0x2::coin::zero<T3>(arg19)
        };
        let v8 = v0 - 0x2::coin::value<T1>(&v3);
        assert!(v8 >= arg14, 2);
        let (v9, v10) = swap_b_to_a<T1, 0x2::sui::SUI>(arg4, arg5, 0x2::coin::into_balance<0x2::sui::SUI>(0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::redeem<T2>(arg7, v5, arg8, arg19)), arg15, arg18);
        let v11 = v9;
        let (v12, v13) = swap_b_to_a<T1, T3>(arg4, arg6, 0x2::coin::into_balance<T3>(v6), arg16, arg18);
        0x2::balance::join<T1>(&mut v11, v12);
        0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_vault::deposit_balance<0x2::sui::SUI>(arg0, v10);
        0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_vault::deposit_balance<T3>(arg0, v13);
        settle<T1, T2>(arg0, arg2, arg3, arg9, v2, v3, v11, 0x2::balance::zero<T2>(), v0, v8, 0x2::coin::value<T2>(&v5), arg17, 2, arg19);
        true
    }

    public fun try_sui_lst_deep_usdc<T0, T1: drop, T2, T3>(arg0: &mut 0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_vault::LiquidationVault, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, 0x2::sui::SUI>, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, 0x2::sui::SUI>, arg7: &mut 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T1>, arg8: &mut 0x3::sui_system::SuiSystemState, arg9: 0x2::object::ID, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u128, arg17: u128, arg18: u64, arg19: &0x2::clock::Clock, arg20: &mut 0x2::tx_context::TxContext) : bool {
        0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_vault::assert_authorized(arg0, arg20);
        assert!(arg16 > 0 && arg17 > 0, 0);
        let v0 = prepare<T0, 0x2::sui::SUI>(arg0, arg1, arg9, arg14, arg19, arg20);
        if (v0 == 0) {
            emit_noop<0x2::sui::SUI, T1>(arg0, arg9);
            return false
        };
        let (v1, v2) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::flash_loan::borrow_flash_loan<0x2::sui::SUI>(arg2, arg3, v0, arg20);
        let v3 = v1;
        let v4 = &mut v3;
        let v5 = liquidate<T0, 0x2::sui::SUI, T1>(arg1, v4, arg9, arg10, arg11, arg19, arg20);
        let v6 = &mut v3;
        let v7 = liquidate<T0, 0x2::sui::SUI, T2>(arg1, v6, arg9, arg10, arg12, arg19, arg20);
        let v8 = &mut v3;
        let v9 = liquidate<T0, 0x2::sui::SUI, T3>(arg1, v8, arg9, arg10, arg13, arg19, arg20);
        let v10 = v0 - 0x2::coin::value<0x2::sui::SUI>(&v3);
        assert!(v10 >= arg15, 2);
        let v11 = 0x2::coin::into_balance<0x2::sui::SUI>(0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::redeem<T1>(arg7, v5, arg8, arg20));
        let (v12, v13) = swap_a_to_b<T2, 0x2::sui::SUI>(arg4, arg5, 0x2::coin::into_balance<T2>(v7), arg16, arg19);
        let (v14, v15) = swap_a_to_b<T3, 0x2::sui::SUI>(arg4, arg6, 0x2::coin::into_balance<T3>(v9), arg17, arg19);
        0x2::balance::join<0x2::sui::SUI>(&mut v11, v12);
        0x2::balance::join<0x2::sui::SUI>(&mut v11, v14);
        0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_vault::deposit_balance<T2>(arg0, v13);
        0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_vault::deposit_balance<T3>(arg0, v15);
        settle<0x2::sui::SUI, T1>(arg0, arg2, arg3, arg9, v2, v3, v11, 0x2::balance::zero<T1>(), v0, v10, 0x2::coin::value<T1>(&v5), arg18, 2, arg20);
        true
    }

    public fun try_two_ab_ab<T0, T1, T2, T3>(arg0: &mut 0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_vault::LiquidationVault, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg7: 0x2::object::ID, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u128, arg13: u128, arg14: u64, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) : bool {
        0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_vault::assert_authorized(arg0, arg16);
        assert!(arg12 > 0 && arg13 > 0, 0);
        let v0 = prepare<T0, T3>(arg0, arg1, arg7, arg10, arg15, arg16);
        if (v0 == 0) {
            emit_noop<T3, T1>(arg0, arg7);
            return false
        };
        let (v1, v2) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::flash_loan::borrow_flash_loan<T3>(arg2, arg3, v0, arg16);
        let v3 = v1;
        let v4 = &mut v3;
        let v5 = liquidate<T0, T3, T1>(arg1, v4, arg7, arg8, arg9, arg15, arg16);
        let v6 = v0 - 0x2::coin::value<T3>(&v3);
        assert!(v6 >= arg11, 2);
        let (v7, v8) = swap_a_to_b<T1, T2>(arg4, arg5, 0x2::coin::into_balance<T1>(v5), arg12, arg15);
        let (v9, v10) = swap_a_to_b<T2, T3>(arg4, arg6, v7, arg13, arg15);
        0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_vault::deposit_balance<T2>(arg0, v10);
        settle<T3, T1>(arg0, arg2, arg3, arg7, v2, v3, v9, v8, v0, v6, 0x2::coin::value<T1>(&v5), arg14, 2, arg16);
        true
    }

    public fun try_two_ab_ba<T0, T1, T2, T3>(arg0: &mut 0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_vault::LiquidationVault, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T2>, arg7: 0x2::object::ID, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u128, arg13: u128, arg14: u64, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) : bool {
        0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_vault::assert_authorized(arg0, arg16);
        assert!(arg12 > 0 && arg13 > 0, 0);
        let v0 = prepare<T0, T3>(arg0, arg1, arg7, arg10, arg15, arg16);
        if (v0 == 0) {
            emit_noop<T3, T1>(arg0, arg7);
            return false
        };
        let (v1, v2) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::flash_loan::borrow_flash_loan<T3>(arg2, arg3, v0, arg16);
        let v3 = v1;
        let v4 = &mut v3;
        let v5 = liquidate<T0, T3, T1>(arg1, v4, arg7, arg8, arg9, arg15, arg16);
        let v6 = v0 - 0x2::coin::value<T3>(&v3);
        assert!(v6 >= arg11, 2);
        let (v7, v8) = swap_a_to_b<T1, T2>(arg4, arg5, 0x2::coin::into_balance<T1>(v5), arg12, arg15);
        let (v9, v10) = swap_b_to_a<T3, T2>(arg4, arg6, v7, arg13, arg15);
        0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_vault::deposit_balance<T2>(arg0, v10);
        settle<T3, T1>(arg0, arg2, arg3, arg7, v2, v3, v9, v8, v0, v6, 0x2::coin::value<T1>(&v5), arg14, 2, arg16);
        true
    }

    // decompiled from Move bytecode v7
}

