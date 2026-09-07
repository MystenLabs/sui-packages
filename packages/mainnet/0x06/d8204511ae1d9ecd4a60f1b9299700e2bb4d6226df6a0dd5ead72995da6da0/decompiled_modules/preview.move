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

    struct LiquidationPlan has copy, drop, store {
        obligation: 0x2::object::ID,
        liquidation_collateral_value_raw: u64,
        weighted_debt_value_raw: u64,
        liquidatable: bool,
        liquidate_locked: bool,
        debt_type: vector<0x1::type_name::TypeName>,
        collateral_type: vector<0x1::type_name::TypeName>,
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

    fun is_legacy_gusd(arg0: &0x1::type_name::TypeName) : bool {
        let v0 = b"8d8b4b5bcfca1e497b4aff33100a521ac4e253d9a96ac44bb3bfe1bde7038ccd::coin_gusd::coin_gusd";
        0x1::ascii::as_bytes(0x1::type_name::as_string(arg0)) == &v0
    }

    fun liquidation_amounts(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg2: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg4: &0x2::clock::Clock, arg5: 0x1::type_name::TypeName, arg6: 0x1::type_name::TypeName, arg7: u64) : (u64, u64, u64) {
        if (arg7 == 0) {
            return (0, 0, 0)
        };
        let v0 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::risk_model(arg1, arg6);
        let v1 = 0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::mul(0x1::fixed_point32::create_from_rational(0x2::math::pow(10, 0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::decimals(arg2, arg6)), 0x2::math::pow(10, 0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::decimals(arg2, arg5))), 0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::div(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::price::get_price(arg3, arg5, arg4), 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::price::get_price(arg3, arg6, arg4)));
        let v2 = 0x1::fixed_point32::multiply_u64(arg7, 0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::mul(v1, 0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::add(0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::from_u64(1), 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::risk_model::liq_discount(v0))));
        let v3 = 0x1::fixed_point32::multiply_u64(arg7, 0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::mul(v1, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::risk_model::liq_revenue_factor(v0)));
        let v4 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::collateral(arg0, arg6);
        let v5 = v2 + v3;
        if (v5 > v4) {
            let v9 = 0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::u64::mul_div(arg7, v4, v5);
            let v10 = 0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::u64::mul_div(v4, v2, v5);
            if (v9 == 0 || v10 == 0) {
                return (0, 0, 0)
            };
            (v9, v10, v4 - v10)
        } else {
            (arg7, v2, v3)
        }
    }

    public fun liquidation_plan(arg0: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg4: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg5: &0x2::clock::Clock) : LiquidationPlan {
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::accrue_interest::accrue_interest_for_market_and_obligation(arg2, arg0, arg1, arg5);
        let v0 = health(arg1, arg0, arg3, arg4, arg5);
        let v1 = 0x1::vector::empty<0x1::type_name::TypeName>();
        let v2 = 0x1::vector::empty<0x1::type_name::TypeName>();
        let v3 = 0;
        let v4 = 0;
        let v5 = 0;
        let v6 = 0;
        let v7 = v6;
        let v8 = 0;
        let v9 = 0;
        let v10 = 0;
        if (v0.liquidatable) {
            let v11 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::debt_types(arg1);
            let v12 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::collateral_types(arg1);
            let v13 = 0;
            while (v13 < 0x1::vector::length<0x1::type_name::TypeName>(&v11)) {
                let v14 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v11, v13);
                if (!is_legacy_gusd(&v14)) {
                    let v15 = 0;
                    while (v15 < 0x1::vector::length<0x1::type_name::TypeName>(&v12)) {
                        let v16 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v12, v15);
                        if (!is_legacy_gusd(&v16)) {
                            let (v17, v18, v19) = liquidation_amounts(arg1, arg0, arg3, arg4, arg5, v14, v16, max_repay_amount(arg1, arg3, arg4, arg5, v14, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::debt_value::debts_value_usd(arg1, arg3, arg4, arg5)));
                            if (v17 > 0 && v18 > 0) {
                                let v20 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::price::get_price(arg4, v16, arg5);
                                let v21 = 0x1::fixed_point32::get_raw_value(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::value_calculator::usd_value(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::price::get_price(arg4, v14, arg5), v17, 0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::decimals(arg3, v14)));
                                let v22 = 0x1::fixed_point32::get_raw_value(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::value_calculator::usd_value(v20, v18, 0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::decimals(arg3, v16)));
                                let v23 = if (v22 > v21) {
                                    v22 - v21
                                } else {
                                    0
                                };
                                let v24 = if (0x1::vector::is_empty<0x1::type_name::TypeName>(&v1)) {
                                    true
                                } else if (v23 > v10) {
                                    true
                                } else {
                                    v23 == v10 && v21 > v6
                                };
                                if (v24) {
                                    while (!0x1::vector::is_empty<0x1::type_name::TypeName>(&v1)) {
                                        0x1::vector::pop_back<0x1::type_name::TypeName>(&mut v1);
                                    };
                                    while (!0x1::vector::is_empty<0x1::type_name::TypeName>(&v2)) {
                                        0x1::vector::pop_back<0x1::type_name::TypeName>(&mut v2);
                                    };
                                    0x1::vector::push_back<0x1::type_name::TypeName>(&mut v1, v14);
                                    0x1::vector::push_back<0x1::type_name::TypeName>(&mut v2, v16);
                                    v3 = v17;
                                    v4 = v18;
                                    v5 = v19;
                                    v7 = v21;
                                    v8 = v22;
                                    v9 = 0x1::fixed_point32::get_raw_value(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::value_calculator::usd_value(v20, v19, 0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::decimals(arg3, v16)));
                                };
                            };
                        };
                        v15 = v15 + 1;
                    };
                };
                v13 = v13 + 1;
            };
        };
        let v25 = LiquidationPlan{
            obligation                          : 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation>(arg1),
            liquidation_collateral_value_raw    : v0.liquidation_collateral_value_raw,
            weighted_debt_value_raw             : v0.weighted_debt_value_raw,
            liquidatable                        : v0.liquidatable,
            liquidate_locked                    : v0.liquidate_locked,
            debt_type                           : v1,
            collateral_type                     : v2,
            actual_repay_amount                 : v3,
            liquidator_collateral_amount        : v4,
            protocol_collateral_amount          : v5,
            repay_value_usd_raw                 : v7,
            liquidator_collateral_value_usd_raw : v8,
            protocol_collateral_value_usd_raw   : v9,
        };
        0x2::event::emit<LiquidationPlan>(v25);
        v25
    }

    fun max_repay_amount(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg1: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg2: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg3: &0x2::clock::Clock, arg4: 0x1::type_name::TypeName, arg5: 0x1::fixed_point32::FixedPoint32) : u64 {
        let (v0, _) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::debt(arg0, arg4);
        if (!0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::gt(arg5, 0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::from_u64(10))) {
            return v0
        };
        0x2::math::min(0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::u64::mul_div(0x1::fixed_point32::get_raw_value(arg5), 0x2::math::pow(10, 0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::decimals(arg1, arg4)), 5 * 0x1::fixed_point32::get_raw_value(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::price::get_price(arg2, arg4, arg3))), v0)
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

