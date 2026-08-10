module 0xc7f7c2720fff9454db35fda838e432afb640c33a0c4b9ac1ea2cc36f1a293876::preview {
    struct PreparedHealth has copy, drop, store {
        obligation: 0x2::object::ID,
        liquidation_collateral_value_raw: u64,
        weighted_debt_value_raw: u64,
        liquidatable: bool,
        liquidate_locked: bool,
    }

    struct LiquidationPreview has copy, drop, store {
        obligation: 0x2::object::ID,
        debt_type: 0x1::type_name::TypeName,
        collateral_type: 0x1::type_name::TypeName,
        liquidatable: bool,
        liquidate_locked: bool,
        actual_repay_amount: u64,
        liquidator_collateral_amount: u64,
        protocol_collateral_amount: u64,
        repay_value_usd_raw: u64,
        liquidator_collateral_value_usd_raw: u64,
        protocol_collateral_value_usd_raw: u64,
    }

    fun health(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg2: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg4: &0x2::clock::Clock) : PreparedHealth {
        let v0 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::collateral_value::collaterals_value_usd_for_liquidation(arg0, arg1, arg2, arg3, arg4);
        let v1 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::debt_value::debts_value_usd_with_weight(arg0, arg2, arg1, arg3, arg4);
        PreparedHealth{
            obligation                       : 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation>(arg0),
            liquidation_collateral_value_raw : 0x1::fixed_point32::get_raw_value(v0),
            weighted_debt_value_raw          : 0x1::fixed_point32::get_raw_value(v1),
            liquidatable                     : 0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::gt(v1, v0),
            liquidate_locked                 : 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::liquidate_locked(arg0),
        }
    }

    public fun prepare(arg0: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg4: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg5: &0x2::clock::Clock) : PreparedHealth {
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::accrue_interest::accrue_interest_for_market_and_obligation(arg2, arg0, arg1, arg5);
        let v0 = health(arg1, arg0, arg3, arg4, arg5);
        0x2::event::emit<PreparedHealth>(v0);
        v0
    }

    public fun prepare_and_preview_max<T0, T1>(arg0: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg4: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg5: &0x2::clock::Clock) : LiquidationPreview {
        let v0 = prepare(arg0, arg1, arg2, arg3, arg4, arg5);
        preview_max_prepared<T0, T1>(arg0, arg1, &v0, arg3, arg4, arg5)
    }

    public fun preview_max_prepared<T0, T1>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg2: &PreparedHealth, arg3: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg4: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg5: &0x2::clock::Clock) : LiquidationPreview {
        assert!(arg2.obligation == 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation>(arg1), 1);
        let (v0, v1, v2, v3, v4, v5) = if (!arg2.liquidatable) {
            (0, 0, 0, 0, 0, 0)
        } else {
            let (v6, v7, v8) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidation_evaluator::calculate_liquidation_amounts<T0, T1>(arg1, arg0, arg3, arg4, arg5, 18446744073709551615);
            let v9 = 0x1::type_name::get<T0>();
            let v10 = 0x1::type_name::get<T1>();
            let v11 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::price::get_price(arg4, v10, arg5);
            (v6, v7, v8, 0x1::fixed_point32::get_raw_value(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::value_calculator::usd_value(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::price::get_price(arg4, v9, arg5), v6, 0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::decimals(arg3, v9))), 0x1::fixed_point32::get_raw_value(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::value_calculator::usd_value(v11, v7, 0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::decimals(arg3, v10))), 0x1::fixed_point32::get_raw_value(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::value_calculator::usd_value(v11, v8, 0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::decimals(arg3, v10))))
        };
        let v12 = LiquidationPreview{
            obligation                          : 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation>(arg1),
            debt_type                           : 0x1::type_name::get<T0>(),
            collateral_type                     : 0x1::type_name::get<T1>(),
            liquidatable                        : arg2.liquidatable,
            liquidate_locked                    : 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::liquidate_locked(arg1),
            actual_repay_amount                 : v0,
            liquidator_collateral_amount        : v1,
            protocol_collateral_amount          : v2,
            repay_value_usd_raw                 : v3,
            liquidator_collateral_value_usd_raw : v4,
            protocol_collateral_value_usd_raw   : v5,
        };
        0x2::event::emit<LiquidationPreview>(v12);
        v12
    }

    // decompiled from Move bytecode v7
}

