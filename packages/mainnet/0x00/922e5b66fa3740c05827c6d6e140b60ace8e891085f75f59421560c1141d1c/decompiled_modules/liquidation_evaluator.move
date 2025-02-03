module 0x922e5b66fa3740c05827c6d6e140b60ace8e891085f75f59421560c1141d1c::liquidation_evaluator {
    fun calc_liq_exchange_rate<T0, T1>(arg0: &0x922e5b66fa3740c05827c6d6e140b60ace8e891085f75f59421560c1141d1c::market::Market, arg1: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg2: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg3: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0x1::type_name::get<T1>();
        let v1 = 0x1::type_name::get<T0>();
        0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::div(0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::mul(0x1::fixed_point32::create_from_rational(0x2::math::pow(10, 0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::decimals(arg1, v0)), 0x2::math::pow(10, 0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::decimals(arg1, v1))), 0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::div(0x922e5b66fa3740c05827c6d6e140b60ace8e891085f75f59421560c1141d1c::price::get_price(arg2, v1, arg3), 0x922e5b66fa3740c05827c6d6e140b60ace8e891085f75f59421560c1141d1c::price::get_price(arg2, v0, arg3))), 0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::sub(0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::from_u64(1), 0x922e5b66fa3740c05827c6d6e140b60ace8e891085f75f59421560c1141d1c::risk_model::liq_discount(0x922e5b66fa3740c05827c6d6e140b60ace8e891085f75f59421560c1141d1c::market::risk_model(arg0, v0))))
    }

    public fun liquidation_amounts<T0, T1>(arg0: &0x922e5b66fa3740c05827c6d6e140b60ace8e891085f75f59421560c1141d1c::obligation::Obligation, arg1: &0x922e5b66fa3740c05827c6d6e140b60ace8e891085f75f59421560c1141d1c::market::Market, arg2: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg3: u64, arg4: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg5: &0x2::clock::Clock) : (u64, u64, u64) {
        let (v0, v1) = max_liquidation_amounts<T0, T1>(arg0, arg1, arg2, arg4, arg5);
        let (v2, v3) = if (arg3 >= v0) {
            (v0, v1)
        } else {
            (arg3, 0x1::fixed_point32::multiply_u64(arg3, calc_liq_exchange_rate<T0, T1>(arg1, arg2, arg4, arg5)))
        };
        let v4 = 0x1::fixed_point32::multiply_u64(v2, 0x922e5b66fa3740c05827c6d6e140b60ace8e891085f75f59421560c1141d1c::risk_model::liq_revenue_factor(0x922e5b66fa3740c05827c6d6e140b60ace8e891085f75f59421560c1141d1c::market::risk_model(arg1, 0x1::type_name::get<T1>())));
        (v2 - v4, v4, v3)
    }

    public fun max_liquidation_amounts<T0, T1>(arg0: &0x922e5b66fa3740c05827c6d6e140b60ace8e891085f75f59421560c1141d1c::obligation::Obligation, arg1: &0x922e5b66fa3740c05827c6d6e140b60ace8e891085f75f59421560c1141d1c::market::Market, arg2: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg4: &0x2::clock::Clock) : (u64, u64) {
        let v0 = 0x1::type_name::get<T0>();
        let (_, _) = 0x922e5b66fa3740c05827c6d6e140b60ace8e891085f75f59421560c1141d1c::obligation::debt(arg0, v0);
        let v3 = 0x1::type_name::get<T1>();
        let v4 = 0x922e5b66fa3740c05827c6d6e140b60ace8e891085f75f59421560c1141d1c::market::risk_model(arg1, v3);
        let v5 = 0x922e5b66fa3740c05827c6d6e140b60ace8e891085f75f59421560c1141d1c::risk_model::liq_factor(v4);
        let v6 = 0x922e5b66fa3740c05827c6d6e140b60ace8e891085f75f59421560c1141d1c::collateral_value::collaterals_value_usd_for_liquidation(arg0, arg1, arg2, arg3, arg4);
        let v7 = 0x922e5b66fa3740c05827c6d6e140b60ace8e891085f75f59421560c1141d1c::debt_value::debts_value_usd_with_weight(arg0, arg2, arg1, arg3, arg4);
        assert!(0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::gt(v7, v6), 0x922e5b66fa3740c05827c6d6e140b60ace8e891085f75f59421560c1141d1c::error::unable_to_liquidate_error());
        let v8 = 0x2::math::min(0x1::fixed_point32::multiply_u64(0x2::math::pow(10, 0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::decimals(arg2, v3)), 0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::div(0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::div(0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::sub(v7, v6), 0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::sub(0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::mul(0x922e5b66fa3740c05827c6d6e140b60ace8e891085f75f59421560c1141d1c::interest_model::borrow_weight(0x922e5b66fa3740c05827c6d6e140b60ace8e891085f75f59421560c1141d1c::market::interest_model(arg1, v0)), 0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::sub(0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::from_u64(1), 0x922e5b66fa3740c05827c6d6e140b60ace8e891085f75f59421560c1141d1c::risk_model::liq_penalty(v4))), v5)), 0x922e5b66fa3740c05827c6d6e140b60ace8e891085f75f59421560c1141d1c::price::get_price(arg3, v3, arg4))), 0x922e5b66fa3740c05827c6d6e140b60ace8e891085f75f59421560c1141d1c::obligation::collateral(arg0, v3));
        let v9 = calc_liq_exchange_rate<T0, T1>(arg1, arg2, arg3, arg4);
        let v10 = 0x1::fixed_point32::divide_u64(v8, v9);
        let (v11, _) = 0x922e5b66fa3740c05827c6d6e140b60ace8e891085f75f59421560c1141d1c::obligation::debt(arg0, v0);
        if (v10 <= v11) {
            (v10, v8)
        } else {
            (v11, 0x1::fixed_point32::multiply_u64(v11, v9))
        }
    }

    // decompiled from Move bytecode v6
}

