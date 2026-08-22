module 0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_jit {
    struct AtomicJitFundingResult has copy, drop {
        vault_id: 0x2::object::ID,
        obligation: 0x2::object::ID,
        funded: bool,
        result_code: u8,
        debt_funded_raw: u64,
        reserve_spent_raw: u64,
    }

    struct AtomicJitExecutionResult has copy, drop {
        vault_id: 0x2::object::ID,
        obligation: 0x2::object::ID,
        liquidated: bool,
        result_code: u8,
        requested_max_repay_raw: u64,
        authoritative_max_repay_raw: u64,
        repay_raw: u64,
        collateral_raw: u64,
        debt_funded_raw: u64,
        reserve_spent_raw: u64,
        collateral_value_usd_e18: u256,
        funding_cost_usd_e18: u256,
        gas_ceiling_usd_e18: u256,
        unwind_haircut_usd_e18: u256,
        guarded_profit_usd_e18: u256,
    }

    fun authoritative_max_repay_raw<T0>(arg0: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64) : u64 {
        let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation<T0>(arg0, arg1);
        if (!0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::is_liquidatable<T0>(v0) || arg4 == 0) {
            return 0
        };
        let v1 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserves<T0>(arg0);
        if (arg2 >= 0x1::vector::length<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::Reserve<T0>>(v1) || arg3 >= 0x1::vector::length<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::Reserve<T0>>(v1)) {
            return 0
        };
        let v2 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::borrows<T0>(v0);
        let v3 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(0);
        let v4 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(0);
        let v5 = false;
        let v6 = 0;
        while (v6 < 0x1::vector::length<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::Borrow>(v2)) {
            let v7 = 0x1::vector::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::Borrow>(v2, v6);
            if (0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::borrow_reserve_array_index(v7) == arg2) {
                v3 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::borrow_borrowed_amount(v7);
                v4 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::borrow_market_value(v7);
                v5 = true;
            };
            v6 = v6 + 1;
        };
        let v8 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::deposits<T0>(v0);
        let v9 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(0);
        let v10 = false;
        let v11 = 0;
        while (v11 < 0x1::vector::length<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::Deposit>(v8)) {
            let v12 = 0x1::vector::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::Deposit>(v8, v11);
            if (0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::deposit_reserve_array_index(v12) == arg3) {
                v9 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::deposit_market_value(v12);
                v10 = true;
            };
            v11 = v11 + 1;
        };
        let v13 = if (!v5) {
            true
        } else if (!v10) {
            true
        } else {
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::eq(v4, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(0))
        };
        if (v13) {
            return 0
        };
        let v14 = 0x1::vector::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::Reserve<T0>>(v1, arg3);
        let v15 = 0;
        while (v15 < 0x1::vector::length<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::Deposit>(v8)) {
            if (0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::gt(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve_config::borrow_weight(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::config<T0>(0x1::vector::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::Reserve<T0>>(v1, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::deposit_reserve_array_index(0x1::vector::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::Deposit>(v8, v15))))), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve_config::borrow_weight(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::config<T0>(v14)))) {
                return 0
            };
            v15 = v15 + 1;
        };
        let v16 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::add(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve_config::liquidation_bonus(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::config<T0>(v14)), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve_config::protocol_liquidation_fee(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::config<T0>(v14)));
        let v17 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::unweighted_borrowed_value_usd<T0>(v0);
        let v18 = if (0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::gt(v17, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(0))) {
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::min(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::div(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::saturating_sub(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::deposited_value_usd<T0>(v0), v17), v17), v16)
        } else {
            v16
        };
        let v19 = if (0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::le(v4, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(100)) || 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::lt(v18, v16)) {
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::min(v3, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(arg4))
        } else {
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::min(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::mul(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::div(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::min(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::mul(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::weighted_borrowed_value_usd<T0>(v0), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from_percent(20)), v4), v4), v3), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(arg4))
        };
        let v20 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::mul(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::market_value<T0>(0x1::vector::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::Reserve<T0>>(v1, arg2), v19), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::add(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(1), v18));
        let v21 = if (0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::lt(v9, v20)) {
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::mul(v19, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::div(v9, v20))
        } else {
            v19
        };
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::floor(v21)
    }

    fun emit_execution(arg0: &0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_vault::LiquidationVault, arg1: 0x2::object::ID, arg2: bool, arg3: u8, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u256, arg11: u256, arg12: u256, arg13: u256, arg14: u256) {
        let v0 = AtomicJitExecutionResult{
            vault_id                    : 0x2::object::id<0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_vault::LiquidationVault>(arg0),
            obligation                  : arg1,
            liquidated                  : arg2,
            result_code                 : arg3,
            requested_max_repay_raw     : arg4,
            authoritative_max_repay_raw : arg5,
            repay_raw                   : arg6,
            collateral_raw              : arg7,
            debt_funded_raw             : arg8,
            reserve_spent_raw           : arg9,
            collateral_value_usd_e18    : arg10,
            funding_cost_usd_e18        : arg11,
            gas_ceiling_usd_e18         : arg12,
            unwind_haircut_usd_e18      : arg13,
            guarded_profit_usd_e18      : arg14,
        };
        0x2::event::emit<AtomicJitExecutionResult>(v0);
    }

    fun emit_funding(arg0: &0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_vault::LiquidationVault, arg1: 0x2::object::ID, arg2: bool, arg3: u8, arg4: u64, arg5: u64) {
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

    fun finish<T0, T1, T2, T3>(arg0: &mut 0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_vault::LiquidationVault, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u256, arg11: u64, arg12: u64, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) : bool {
        let (v0, v1, v2, _) = 0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic::try_liquidate_authorized_with_result<T0, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg6, arg7, arg13, arg14);
        if (!v0) {
            emit_execution(arg0, arg2, false, 2, arg5, arg6, 0, 0, arg8, arg9, 0, 0, 0, 0, 0);
            return false
        };
        let v4 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::add(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::market_value<T0>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve<T0, T1>(arg1), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(arg9)), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::market_value<T0>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve<T0, T2>(arg1), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(v1 - 0x1::u64::min(arg8, v1))));
        let v5 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::market_value<T0>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve<T0, T3>(arg1), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(v2));
        let v6 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::market_value<T0>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve<T0, 0x2::sui::SUI>(arg1), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(arg11));
        let v7 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::mul(v5, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from_bps(arg12));
        let v8 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::saturating_sub(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::saturating_sub(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::saturating_sub(v5, v4), v6), v7);
        assert!(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::ge(v8, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from_scaled_val(arg10)), 2);
        emit_execution(arg0, arg2, true, 0, arg5, arg6, v1, v2, arg8, arg9, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::to_scaled_val(v5), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::to_scaled_val(v4), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::to_scaled_val(v6), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::to_scaled_val(v7), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::to_scaled_val(v8));
        true
    }

    public fun try_direct_a_to_b<T0, T1, T2, T3>(arg0: &mut 0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_vault::LiquidationVault, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg4: 0x2::object::ID, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u128, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : bool {
        try_direct_a_to_b_guarded<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, 0, 0, 0, arg11, arg12)
    }

    public fun try_direct_a_to_b_guarded<T0, T1, T2, T3>(arg0: &mut 0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_vault::LiquidationVault, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg4: 0x2::object::ID, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u128, arg11: u256, arg12: u64, arg13: u64, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) : bool {
        0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_vault::assert_authorized(arg0, arg15);
        assert!(arg10 > 0, 0);
        assert!(arg13 <= 10000, 3);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_obligation<T0>(arg1, arg4, arg14);
        let v0 = authoritative_max_repay_raw<T0>(arg1, arg4, arg5, arg6, arg7);
        if (v0 < arg8) {
            emit_funding(arg0, arg4, false, 2, 0, 0);
            emit_execution(arg0, arg4, false, 2, arg7, v0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
            return false
        };
        let v1 = 0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_vault::balance<T2>(arg0);
        let v2 = 0;
        let v3 = 0;
        if (v1 < v0) {
            let v4 = v0 - v1;
            v2 = v4;
            let (v5, v6, v7) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T2>(arg2, arg3, true, false, v4, arg10, arg14);
            let v8 = v7;
            let v9 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T2>(&v8);
            v3 = v9;
            assert!(v9 <= arg9, 1);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T2>(arg2, arg3, 0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_vault::withdraw_for_liquidation<T1>(arg0, v9), 0x2::balance::zero<T2>(), v8);
            0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_vault::deposit_balance<T1>(arg0, v5);
            0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_vault::deposit_balance<T2>(arg0, v6);
        };
        emit_funding(arg0, arg4, v2 > 0, 0, v2, v3);
        finish<T0, T1, T2, T3>(arg0, arg1, arg4, arg5, arg6, arg7, v0, arg8, v2, v3, arg11, arg12, arg13, arg14, arg15)
    }

    public fun try_direct_b_to_a<T0, T1, T2, T3>(arg0: &mut 0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_vault::LiquidationVault, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg4: 0x2::object::ID, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u128, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : bool {
        try_direct_b_to_a_guarded<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, 0, 0, 0, arg11, arg12)
    }

    public fun try_direct_b_to_a_guarded<T0, T1, T2, T3>(arg0: &mut 0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_vault::LiquidationVault, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg4: 0x2::object::ID, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u128, arg11: u256, arg12: u64, arg13: u64, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) : bool {
        0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_vault::assert_authorized(arg0, arg15);
        assert!(arg10 > 0, 0);
        assert!(arg13 <= 10000, 3);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_obligation<T0>(arg1, arg4, arg14);
        let v0 = authoritative_max_repay_raw<T0>(arg1, arg4, arg5, arg6, arg7);
        if (v0 < arg8) {
            emit_funding(arg0, arg4, false, 2, 0, 0);
            emit_execution(arg0, arg4, false, 2, arg7, v0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
            return false
        };
        let v1 = 0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_vault::balance<T1>(arg0);
        let v2 = 0;
        let v3 = 0;
        if (v1 < v0) {
            let v4 = v0 - v1;
            v2 = v4;
            let (v5, v6, v7) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T2>(arg2, arg3, false, false, v4, arg10, arg14);
            let v8 = v7;
            let v9 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T2>(&v8);
            v3 = v9;
            assert!(v9 <= arg9, 1);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T2>(arg2, arg3, 0x2::balance::zero<T1>(), 0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_vault::withdraw_for_liquidation<T2>(arg0, v9), v8);
            0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_vault::deposit_balance<T1>(arg0, v5);
            0xc48667e60b29c84063d55e53cf3c25d1e161de0c72fdc537cacda835340d58a3::atomic_vault::deposit_balance<T2>(arg0, v6);
        };
        emit_funding(arg0, arg4, v2 > 0, 0, v2, v3);
        finish<T0, T2, T1, T3>(arg0, arg1, arg4, arg5, arg6, arg7, v0, arg8, v2, v3, arg11, arg12, arg13, arg14, arg15)
    }

    // decompiled from Move bytecode v7
}

