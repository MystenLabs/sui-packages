module 0x922e5b66fa3740c05827c6d6e140b60ace8e891085f75f59421560c1141d1c::borrow_withdraw_evaluator {
    public fun available_borrow_amount_in_usd(arg0: &0x922e5b66fa3740c05827c6d6e140b60ace8e891085f75f59421560c1141d1c::obligation::Obligation, arg1: &0x922e5b66fa3740c05827c6d6e140b60ace8e891085f75f59421560c1141d1c::market::Market, arg2: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg4: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0x922e5b66fa3740c05827c6d6e140b60ace8e891085f75f59421560c1141d1c::collateral_value::collaterals_value_usd_for_borrow(arg0, arg1, arg2, arg3, arg4);
        let v1 = 0x922e5b66fa3740c05827c6d6e140b60ace8e891085f75f59421560c1141d1c::debt_value::debts_value_usd_with_weight(arg0, arg2, arg1, arg3, arg4);
        if (0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::gt(v0, v1)) {
            0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::sub(v0, v1)
        } else {
            0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::zero()
        }
    }

    public fun max_borrow_amount<T0>(arg0: &0x922e5b66fa3740c05827c6d6e140b60ace8e891085f75f59421560c1141d1c::obligation::Obligation, arg1: &0x922e5b66fa3740c05827c6d6e140b60ace8e891085f75f59421560c1141d1c::market::Market, arg2: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg4: &0x2::clock::Clock) : u64 {
        let v0 = available_borrow_amount_in_usd(arg0, arg1, arg2, arg3, arg4);
        if (0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::gt(v0, 0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::zero())) {
            let v2 = 0x1::type_name::get<T0>();
            0x1::fixed_point32::multiply_u64(0x2::math::pow(10, 0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::decimals(arg2, v2)), 0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::div(v0, 0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::mul(0x922e5b66fa3740c05827c6d6e140b60ace8e891085f75f59421560c1141d1c::price::get_price(arg3, v2, arg4), 0x922e5b66fa3740c05827c6d6e140b60ace8e891085f75f59421560c1141d1c::interest_model::borrow_weight(0x922e5b66fa3740c05827c6d6e140b60ace8e891085f75f59421560c1141d1c::market::interest_model(arg1, v2)))))
        } else {
            0
        }
    }

    public fun max_withdraw_amount<T0>(arg0: &0x922e5b66fa3740c05827c6d6e140b60ace8e891085f75f59421560c1141d1c::obligation::Obligation, arg1: &0x922e5b66fa3740c05827c6d6e140b60ace8e891085f75f59421560c1141d1c::market::Market, arg2: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg4: &0x2::clock::Clock) : u64 {
        let v0 = 0x1::type_name::get<T0>();
        if (0x1::fixed_point32::is_zero(0x922e5b66fa3740c05827c6d6e140b60ace8e891085f75f59421560c1141d1c::debt_value::debts_value_usd_with_weight(arg0, arg2, arg1, arg3, arg4))) {
            return 0x922e5b66fa3740c05827c6d6e140b60ace8e891085f75f59421560c1141d1c::obligation::collateral(arg0, v0)
        };
        0x2::math::min(0x1::fixed_point32::divide_u64(0x1::fixed_point32::multiply_u64(0x2::math::pow(10, 0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::decimals(arg2, v0)), 0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::div(available_borrow_amount_in_usd(arg0, arg1, arg2, arg3, arg4), 0x922e5b66fa3740c05827c6d6e140b60ace8e891085f75f59421560c1141d1c::price::get_price(arg3, v0, arg4))), 0x922e5b66fa3740c05827c6d6e140b60ace8e891085f75f59421560c1141d1c::risk_model::collateral_factor(0x922e5b66fa3740c05827c6d6e140b60ace8e891085f75f59421560c1141d1c::market::risk_model(arg1, v0))), 0x922e5b66fa3740c05827c6d6e140b60ace8e891085f75f59421560c1141d1c::obligation::collateral(arg0, v0))
    }

    // decompiled from Move bytecode v6
}

