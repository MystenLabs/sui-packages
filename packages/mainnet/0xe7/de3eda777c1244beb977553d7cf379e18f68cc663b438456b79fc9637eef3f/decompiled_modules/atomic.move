module 0xc7f7c2720fff9454db35fda838e432afb640c33a0c4b9ac1ea2cc36f1a293876::atomic {
    struct AtomicResult has copy, drop {
        vault_id: 0x2::object::ID,
        obligation: 0x2::object::ID,
        debt_type: 0x1::type_name::TypeName,
        collateral_type: 0x1::type_name::TypeName,
        liquidated: bool,
        result_code: u8,
        repay_raw: u64,
        collateral_raw: u64,
        protocol_collateral_raw: u64,
        debt_remainder_raw: u64,
    }

    fun emit_result(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x1::type_name::TypeName, arg3: 0x1::type_name::TypeName, arg4: bool, arg5: u8, arg6: u64, arg7: u64, arg8: u64, arg9: u64) {
        let v0 = AtomicResult{
            vault_id                : arg0,
            obligation              : arg1,
            debt_type               : arg2,
            collateral_type         : arg3,
            liquidated              : arg4,
            result_code             : arg5,
            repay_raw               : arg6,
            collateral_raw          : arg7,
            protocol_collateral_raw : arg8,
            debt_remainder_raw      : arg9,
        };
        0x2::event::emit<AtomicResult>(v0);
    }

    public fun try_liquidate_authorized<T0, T1>(arg0: &mut 0xc7f7c2720fff9454db35fda838e432afb640c33a0c4b9ac1ea2cc36f1a293876::atomic_vault::LiquidationVault, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg5: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : bool {
        0xc7f7c2720fff9454db35fda838e432afb640c33a0c4b9ac1ea2cc36f1a293876::atomic_vault::assert_authorized(arg0, arg7);
        if (0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::liquidate_locked(arg2)) {
            emit_result(0x2::object::id<0xc7f7c2720fff9454db35fda838e432afb640c33a0c4b9ac1ea2cc36f1a293876::atomic_vault::LiquidationVault>(arg0), 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation>(arg2), 0x1::type_name::get<T0>(), 0x1::type_name::get<T1>(), false, 1, 0, 0, 0, 0);
            return false
        };
        let v0 = 0xc7f7c2720fff9454db35fda838e432afb640c33a0c4b9ac1ea2cc36f1a293876::atomic_vault::balance<T0>(arg0);
        if (v0 == 0) {
            emit_result(0x2::object::id<0xc7f7c2720fff9454db35fda838e432afb640c33a0c4b9ac1ea2cc36f1a293876::atomic_vault::LiquidationVault>(arg0), 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation>(arg2), 0x1::type_name::get<T0>(), 0x1::type_name::get<T1>(), false, 2, 0, 0, 0, 0);
            return false
        };
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::accrue_interest::accrue_interest_for_market_and_obligation(arg1, arg3, arg2, arg6);
        let (v1, v2, v3) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidation_evaluator::calculate_liquidation_amounts<T0, T1>(arg2, arg3, arg4, arg5, arg6, v0);
        if (v1 == 0 || v2 == 0) {
            emit_result(0x2::object::id<0xc7f7c2720fff9454db35fda838e432afb640c33a0c4b9ac1ea2cc36f1a293876::atomic_vault::LiquidationVault>(arg0), 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation>(arg2), 0x1::type_name::get<T0>(), 0x1::type_name::get<T1>(), false, 3, 0, 0, 0, 0);
            return false
        };
        let (v4, v5) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T0, T1>(arg1, arg2, arg3, 0x2::coin::from_balance<T0>(0xc7f7c2720fff9454db35fda838e432afb640c33a0c4b9ac1ea2cc36f1a293876::atomic_vault::withdraw_for_liquidation<T0>(arg0, v1), arg7), arg4, arg5, arg6, arg7);
        let v6 = v5;
        let v7 = v4;
        let v8 = 0x2::coin::value<T0>(&v7);
        0xc7f7c2720fff9454db35fda838e432afb640c33a0c4b9ac1ea2cc36f1a293876::atomic_vault::deposit_balance<T0>(arg0, 0x2::coin::into_balance<T0>(v7));
        0xc7f7c2720fff9454db35fda838e432afb640c33a0c4b9ac1ea2cc36f1a293876::atomic_vault::deposit_balance<T1>(arg0, 0x2::coin::into_balance<T1>(v6));
        emit_result(0x2::object::id<0xc7f7c2720fff9454db35fda838e432afb640c33a0c4b9ac1ea2cc36f1a293876::atomic_vault::LiquidationVault>(arg0), 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation>(arg2), 0x1::type_name::get<T0>(), 0x1::type_name::get<T1>(), true, 0, v1 - v8, 0x2::coin::value<T1>(&v6), v3, v8);
        true
    }

    // decompiled from Move bytecode v7
}

