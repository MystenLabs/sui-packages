module 0xc7f7c2720fff9454db35fda838e432afb640c33a0c4b9ac1ea2cc36f1a293876::atomic_flash {
    struct AtomicFlashResult has copy, drop {
        vault_id: 0x2::object::ID,
        obligation: 0x2::object::ID,
        debt_type: 0x1::type_name::TypeName,
        collateral_type: 0x1::type_name::TypeName,
        liquidated: bool,
        result_code: u8,
        repay_raw: u64,
        collateral_raw: u64,
        protocol_collateral_raw: u64,
        collateral_paid_raw: u64,
        collateral_profit_raw: u64,
        debt_remainder_raw: u64,
        route_hops: u8,
    }

    fun emit_noop<T0, T1>(arg0: &0xc7f7c2720fff9454db35fda838e432afb640c33a0c4b9ac1ea2cc36f1a293876::atomic_vault::LiquidationVault, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg2: u8) {
        let v0 = AtomicFlashResult{
            vault_id                : 0x2::object::id<0xc7f7c2720fff9454db35fda838e432afb640c33a0c4b9ac1ea2cc36f1a293876::atomic_vault::LiquidationVault>(arg0),
            obligation              : 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation>(arg1),
            debt_type               : 0x1::type_name::get<T0>(),
            collateral_type         : 0x1::type_name::get<T1>(),
            liquidated              : false,
            result_code             : arg2,
            repay_raw               : 0,
            collateral_raw          : 0,
            protocol_collateral_raw : 0,
            collateral_paid_raw     : 0,
            collateral_profit_raw   : 0,
            debt_remainder_raw      : 0,
            route_hops              : 0,
        };
        0x2::event::emit<AtomicFlashResult>(v0);
    }

    fun finish<T0, T1>(arg0: &mut 0xc7f7c2720fff9454db35fda838e432afb640c33a0c4b9ac1ea2cc36f1a293876::atomic_vault::LiquidationVault, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg2: 0x2::balance::Balance<T1>, arg3: 0x2::balance::Balance<T0>, arg4: u64, arg5: u64, arg6: u64, arg7: u8) {
        let v0 = 0x2::balance::value<T0>(&arg3);
        0xc7f7c2720fff9454db35fda838e432afb640c33a0c4b9ac1ea2cc36f1a293876::atomic_vault::deposit_balance<T1>(arg0, arg2);
        0xc7f7c2720fff9454db35fda838e432afb640c33a0c4b9ac1ea2cc36f1a293876::atomic_vault::deposit_balance<T0>(arg0, arg3);
        let v1 = AtomicFlashResult{
            vault_id                : 0x2::object::id<0xc7f7c2720fff9454db35fda838e432afb640c33a0c4b9ac1ea2cc36f1a293876::atomic_vault::LiquidationVault>(arg0),
            obligation              : 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation>(arg1),
            debt_type               : 0x1::type_name::get<T0>(),
            collateral_type         : 0x1::type_name::get<T1>(),
            liquidated              : true,
            result_code             : 0,
            repay_raw               : arg4 - v0,
            collateral_raw          : 0x2::balance::value<T1>(&arg2) + arg6,
            protocol_collateral_raw : arg5,
            collateral_paid_raw     : arg6,
            collateral_profit_raw   : 0x2::balance::value<T1>(&arg2),
            debt_remainder_raw      : v0,
            route_hops              : arg7,
        };
        0x2::event::emit<AtomicFlashResult>(v1);
    }

    fun live_repay<T0, T1>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg4: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg5: u64, arg6: &0x2::clock::Clock) : (u64, u64, bool) {
        if (arg5 == 0) {
            return (0, 0, false)
        };
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::accrue_interest::accrue_interest_for_market_and_obligation(arg0, arg2, arg1, arg6);
        let (v0, v1, v2) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidation_evaluator::calculate_liquidation_amounts<T0, T1>(arg1, arg2, arg3, arg4, arg6, arg5);
        let v3 = v0 > 0 && v1 > 0;
        (v0, v2, v3)
    }

    fun require_profit<T0>(arg0: &0x2::balance::Balance<T0>, arg1: u64, arg2: u64) {
        assert!(arg1 <= 18446744073709551615 - arg2, 1);
        assert!(0x2::balance::value<T0>(arg0) >= arg1 + arg2, 1);
    }

    public fun try_direct_a_to_b<T0, T1>(arg0: &mut 0xc7f7c2720fff9454db35fda838e432afb640c33a0c4b9ac1ea2cc36f1a293876::atomic_vault::LiquidationVault, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg5: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg6: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg8: u64, arg9: u128, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : bool {
        0xc7f7c2720fff9454db35fda838e432afb640c33a0c4b9ac1ea2cc36f1a293876::atomic_vault::assert_authorized(arg0, arg12);
        assert!(arg9 > 0, 0);
        if (0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::liquidate_locked(arg2)) {
            emit_noop<T1, T0>(arg0, arg2, 1);
            return false
        };
        let (v0, v1, v2) = live_repay<T1, T0>(arg1, arg2, arg3, arg4, arg5, arg8, arg11);
        if (!v2) {
            emit_noop<T1, T0>(arg0, arg2, 3);
            return false
        };
        let (v3, v4, v5) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg6, arg7, true, false, v0, arg9, arg11);
        let v6 = v5;
        let v7 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v6);
        let (v8, v9) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T1, T0>(arg1, arg2, arg3, 0x2::coin::from_balance<T1>(v4, arg12), arg4, arg5, arg11, arg12);
        let v10 = 0x2::coin::into_balance<T0>(v9);
        0x2::balance::join<T0>(&mut v10, v3);
        require_profit<T0>(&v10, v7, arg10);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg6, arg7, 0x2::balance::split<T0>(&mut v10, v7), 0x2::balance::zero<T1>(), v6);
        finish<T1, T0>(arg0, arg2, v10, 0x2::coin::into_balance<T1>(v8), v0, v1, v7, 1);
        true
    }

    public fun try_direct_b_to_a<T0, T1>(arg0: &mut 0xc7f7c2720fff9454db35fda838e432afb640c33a0c4b9ac1ea2cc36f1a293876::atomic_vault::LiquidationVault, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg5: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg6: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg8: u64, arg9: u128, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : bool {
        0xc7f7c2720fff9454db35fda838e432afb640c33a0c4b9ac1ea2cc36f1a293876::atomic_vault::assert_authorized(arg0, arg12);
        assert!(arg9 > 0, 0);
        if (0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::liquidate_locked(arg2)) {
            emit_noop<T0, T1>(arg0, arg2, 1);
            return false
        };
        let (v0, v1, v2) = live_repay<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg8, arg11);
        if (!v2) {
            emit_noop<T0, T1>(arg0, arg2, 3);
            return false
        };
        let (v3, v4, v5) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg6, arg7, false, false, v0, arg9, arg11);
        let v6 = v5;
        let v7 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v6);
        let (v8, v9) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T0, T1>(arg1, arg2, arg3, 0x2::coin::from_balance<T0>(v3, arg12), arg4, arg5, arg11, arg12);
        let v10 = 0x2::coin::into_balance<T1>(v9);
        0x2::balance::join<T1>(&mut v10, v4);
        require_profit<T1>(&v10, v7, arg10);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg6, arg7, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v10, v7), v6);
        finish<T0, T1>(arg0, arg2, v10, 0x2::coin::into_balance<T0>(v8), v0, v1, v7, 1);
        true
    }

    public fun try_two_ab_ba<T0, T1, T2>(arg0: &mut 0xc7f7c2720fff9454db35fda838e432afb640c33a0c4b9ac1ea2cc36f1a293876::atomic_vault::LiquidationVault, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg5: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg6: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg8: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg9: u64, arg10: u128, arg11: u128, arg12: u64, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) : bool {
        0xc7f7c2720fff9454db35fda838e432afb640c33a0c4b9ac1ea2cc36f1a293876::atomic_vault::assert_authorized(arg0, arg14);
        assert!(arg10 > 0 && arg11 > 0, 0);
        if (0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::liquidate_locked(arg2)) {
            emit_noop<T2, T0>(arg0, arg2, 1);
            return false
        };
        let (v0, v1, v2) = live_repay<T2, T0>(arg1, arg2, arg3, arg4, arg5, arg9, arg13);
        if (!v2) {
            emit_noop<T2, T0>(arg0, arg2, 3);
            return false
        };
        let (v3, v4, v5) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T1>(arg6, arg8, false, false, v0, arg11, arg13);
        let v6 = v5;
        let (v7, v8, v9) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg6, arg7, true, false, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, T1>(&v6), arg10, arg13);
        let v10 = v9;
        let v11 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v10);
        let (v12, v13) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T2, T0>(arg1, arg2, arg3, 0x2::coin::from_balance<T2>(v3, arg14), arg4, arg5, arg13, arg14);
        let v14 = 0x2::coin::into_balance<T0>(v13);
        0x2::balance::join<T0>(&mut v14, v7);
        require_profit<T0>(&v14, v11, arg12);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg6, arg7, 0x2::balance::split<T0>(&mut v14, v11), 0x2::balance::zero<T1>(), v10);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T1>(arg6, arg8, 0x2::balance::zero<T2>(), v8, v6);
        0x2::balance::destroy_zero<T1>(v4);
        finish<T2, T0>(arg0, arg2, v14, 0x2::coin::into_balance<T2>(v12), v0, v1, v11, 2);
        true
    }

    public fun try_two_ba_ab<T0, T1, T2>(arg0: &mut 0xc7f7c2720fff9454db35fda838e432afb640c33a0c4b9ac1ea2cc36f1a293876::atomic_vault::LiquidationVault, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg5: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg6: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg8: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg9: u64, arg10: u128, arg11: u128, arg12: u64, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) : bool {
        0xc7f7c2720fff9454db35fda838e432afb640c33a0c4b9ac1ea2cc36f1a293876::atomic_vault::assert_authorized(arg0, arg14);
        assert!(arg10 > 0 && arg11 > 0, 0);
        if (0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::liquidate_locked(arg2)) {
            emit_noop<T2, T1>(arg0, arg2, 1);
            return false
        };
        let (v0, v1, v2) = live_repay<T2, T1>(arg1, arg2, arg3, arg4, arg5, arg9, arg13);
        if (!v2) {
            emit_noop<T2, T1>(arg0, arg2, 3);
            return false
        };
        let (v3, v4, v5) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T2>(arg6, arg8, true, false, v0, arg11, arg13);
        let v6 = v5;
        let (v7, v8, v9) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg6, arg7, false, false, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T2>(&v6), arg10, arg13);
        let v10 = v9;
        let v11 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v10);
        let (v12, v13) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T2, T1>(arg1, arg2, arg3, 0x2::coin::from_balance<T2>(v4, arg14), arg4, arg5, arg13, arg14);
        let v14 = 0x2::coin::into_balance<T1>(v13);
        0x2::balance::join<T1>(&mut v14, v8);
        require_profit<T1>(&v14, v11, arg12);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg6, arg7, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v14, v11), v10);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T2>(arg6, arg8, v7, 0x2::balance::zero<T2>(), v6);
        0x2::balance::destroy_zero<T0>(v3);
        finish<T2, T1>(arg0, arg2, v14, 0x2::coin::into_balance<T2>(v12), v0, v1, v11, 2);
        true
    }

    // decompiled from Move bytecode v7
}

