module 0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::liquidation_evaluator {
    fun calc_liq_exchange_rate<T0, T1>(arg0: &0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market::Market, arg1: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg2: &0xbece74970dc5b30686a3297b1c3ff1c8fb66c49d1b5a03ab9ce5614a42737f0a::x_oracle::XOracle, arg3: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0x1::type_name::get<T1>();
        let v1 = 0x1::type_name::get<T0>();
        0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::div(0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::mul(0x1::fixed_point32::create_from_rational(0x2::math::pow(10, 0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::decimals(arg1, v0)), 0x2::math::pow(10, 0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::decimals(arg1, v1))), 0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::div(0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::price::get_price(arg2, v1, arg3), 0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::price::get_price(arg2, v0, arg3))), 0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::sub(0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::from_u64(1), 0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::risk_model::liq_discount(0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market::risk_model(arg0, v0))))
    }

    public fun liquidation_amounts<T0, T1>(arg0: &0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::obligation::Obligation, arg1: &0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market::Market, arg2: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg3: u64, arg4: &0xbece74970dc5b30686a3297b1c3ff1c8fb66c49d1b5a03ab9ce5614a42737f0a::x_oracle::XOracle, arg5: &0x2::clock::Clock) : (u64, u64, u64) {
        let (v0, v1) = max_liquidation_amounts<T0, T1>(arg0, arg1, arg2, arg4, arg5);
        if (v1 == 0) {
            return (0, 0, 0)
        };
        let (v2, v3) = if (arg3 >= v0) {
            (v0, v1)
        } else {
            (arg3, 0x1::fixed_point32::multiply_u64(arg3, calc_liq_exchange_rate<T0, T1>(arg1, arg2, arg4, arg5)))
        };
        let v4 = 0x1::fixed_point32::multiply_u64(v2, 0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::risk_model::liq_revenue_factor(0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market::risk_model(arg1, 0x1::type_name::get<T1>())));
        (v2 - v4, v4, v3)
    }

    public fun max_liquidation_amounts<T0, T1>(arg0: &0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::obligation::Obligation, arg1: &0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market::Market, arg2: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0xbece74970dc5b30686a3297b1c3ff1c8fb66c49d1b5a03ab9ce5614a42737f0a::x_oracle::XOracle, arg4: &0x2::clock::Clock) : (u64, u64) {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::type_name::get<T1>();
        let v2 = 0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market::risk_model(arg1, v1);
        let v3 = 0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::risk_model::liq_factor(v2);
        let v4 = 0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::collateral_value::collaterals_value_usd_for_liquidation(arg0, arg1, arg2, arg3, arg4);
        let v5 = 0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::debt_value::debts_value_usd_with_weight(arg0, arg2, arg1, arg3, arg4);
        if (!0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::gt(v5, v4)) {
            return (0, 0)
        };
        let v6 = 0x2::math::min(0x1::fixed_point32::multiply_u64(0x2::math::pow(10, 0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::decimals(arg2, v1)), 0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::div(0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::div(0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::sub(v5, v4), 0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::sub(0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::mul(0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::interest_model::borrow_weight(0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market::interest_model(arg1, v0)), 0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::sub(0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::from_u64(1), 0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::risk_model::liq_penalty(v2))), v3)), 0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::price::get_price(arg3, v1, arg4))), 0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::obligation::collateral(arg0, v1));
        let v7 = calc_liq_exchange_rate<T0, T1>(arg1, arg2, arg3, arg4);
        let v8 = 0x1::fixed_point32::divide_u64(v6, v7);
        let (v9, _) = 0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::obligation::debt(arg0, v0);
        if (v8 <= v9) {
            (v8, v6)
        } else {
            (v9, 0x1::fixed_point32::multiply_u64(v9, v7))
        }
    }

    // decompiled from Move bytecode v6
}

