module 0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_deepbook_flash {
    struct AtomicDeepbookFlashResult has copy, drop {
        vault_id: 0x2::object::ID,
        obligation: 0x2::object::ID,
        stable_type: 0x1::type_name::TypeName,
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

    fun emit_noop<T0, T1, T2>(arg0: &0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_vault::LiquidationVault, arg1: 0x2::object::ID) {
        let v0 = AtomicDeepbookFlashResult{
            vault_id        : 0x2::object::id<0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_vault::LiquidationVault>(arg0),
            obligation      : arg1,
            stable_type     : 0x1::type_name::with_defining_ids<T0>(),
            debt_type       : 0x1::type_name::with_defining_ids<T1>(),
            collateral_type : 0x1::type_name::with_defining_ids<T2>(),
            liquidated      : false,
            result_code     : 2,
            flash_raw       : 0,
            repay_raw       : 0,
            collateral_raw  : 0,
            profit_raw      : 0,
            route_hops      : 0,
        };
        0x2::event::emit<AtomicDeepbookFlashResult>(v0);
    }

    fun liquidate<T0, T1, T2>(arg0: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg1: &mut 0x2::coin::Coin<T1>, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        let (v0, v1) = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::liquidate<T0, T1, T2>(arg0, arg2, arg3, arg4, arg5, arg1, arg6);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<T0, T2>(arg0, arg4, arg5, v0, 0x1::option::some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, T2>>(v1), arg6)
    }

    fun retain_balance<T0>(arg0: &mut 0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_vault::LiquidationVault, arg1: 0x2::balance::Balance<T0>) {
        if (0x2::balance::value<T0>(&arg1) == 0) {
            0x2::balance::destroy_zero<T0>(arg1);
        } else {
            0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_vault::deposit_balance<T0>(arg0, arg1);
        };
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

    public fun try_usdc_bridge_a<T0, T1, T2, T3>(arg0: &mut 0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_vault::LiquidationVault, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, T1>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T3>, arg6: 0x2::object::ID, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u128, arg13: u128, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) : bool {
        0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_vault::assert_authorized(arg0, arg15);
        assert!(arg9 > 0, 0);
        assert!(arg12 > 0, 1);
        assert!(arg13 > 0, 1);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_obligation<T0>(arg1, arg6, arg14);
        if (!0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::is_liquidatable<T0>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation<T0>(arg1, arg6))) {
            emit_noop<T1, T2, T3>(arg0, arg6);
            return false
        };
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<0x2::sui::SUI, T1>(arg2, arg9, arg15);
        let (v2, v3) = swap_a_to_b<T1, T2>(arg3, arg4, 0x2::coin::into_balance<T1>(v0), arg12, arg14);
        let v4 = v3;
        let v5 = v2;
        let v6 = 0x2::coin::from_balance<T2>(v5, arg15);
        let v7 = &mut v6;
        let v8 = liquidate<T0, T2, T3>(arg1, v7, arg6, arg7, arg8, arg14, arg15);
        let v9 = 0x2::balance::value<T2>(&v5) - 0x2::coin::value<T2>(&v6);
        assert!(v9 >= arg10, 2);
        let v10 = 0x2::coin::into_balance<T3>(v8);
        let (v11, v12) = swap_b_to_a<T1, T3>(arg3, arg5, v10, arg13, arg14);
        0x2::balance::join<T1>(&mut v4, v11);
        retain_balance<T3>(arg0, v12);
        let v13 = 0x2::coin::into_balance<T2>(v6);
        if (0x2::balance::value<T2>(&v13) == 0) {
            0x2::balance::destroy_zero<T2>(v13);
        } else {
            let (v14, v15) = swap_b_to_a<T1, T2>(arg3, arg4, v13, 79226673515401279992447579055, arg14);
            0x2::balance::join<T1>(&mut v4, v14);
            retain_balance<T2>(arg0, v15);
        };
        assert!(arg9 <= 18446744073709551615 - arg11, 3);
        assert!(0x2::balance::value<T1>(&v4) >= arg9 + arg11, 3);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<0x2::sui::SUI, T1>(arg2, 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v4, arg9), arg15), v1);
        0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_vault::deposit_balance<T1>(arg0, v4);
        let v16 = AtomicDeepbookFlashResult{
            vault_id        : 0x2::object::id<0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_vault::LiquidationVault>(arg0),
            obligation      : arg6,
            stable_type     : 0x1::type_name::with_defining_ids<T1>(),
            debt_type       : 0x1::type_name::with_defining_ids<T2>(),
            collateral_type : 0x1::type_name::with_defining_ids<T3>(),
            liquidated      : true,
            result_code     : 0,
            flash_raw       : arg9,
            repay_raw       : v9,
            collateral_raw  : 0x2::balance::value<T3>(&v10),
            profit_raw      : 0x2::balance::value<T1>(&v4),
            route_hops      : 2,
        };
        0x2::event::emit<AtomicDeepbookFlashResult>(v16);
        true
    }

    // decompiled from Move bytecode v7
}

