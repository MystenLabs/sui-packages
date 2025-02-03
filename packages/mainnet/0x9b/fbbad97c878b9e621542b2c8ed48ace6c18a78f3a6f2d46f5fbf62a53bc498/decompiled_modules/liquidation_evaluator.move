module 0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::liquidation_evaluator {
    fun calc_liq_exchange_rate<T0, T1>(arg0: &0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::market::Market, arg1: &0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::coin_decimals_registry::CoinDecimalsRegistry, arg2: &0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::x_oracle::XOracle, arg3: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0x1::type_name::get<T1>();
        let v1 = 0x1::type_name::get<T0>();
        0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::fixed_point32_empower::div(0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::fixed_point32_empower::mul(0x1::fixed_point32::create_from_rational(0x2::math::pow(10, 0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::coin_decimals_registry::decimals(arg1, v0)), 0x2::math::pow(10, 0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::coin_decimals_registry::decimals(arg1, v1))), 0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::fixed_point32_empower::div(0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::price::get_price(arg2, v1, arg3), 0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::price::get_price(arg2, v0, arg3))), 0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::fixed_point32_empower::sub(0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::fixed_point32_empower::from_u64(1), 0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::risk_model::liq_discount(0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::market::risk_model(arg0, v0))))
    }

    public fun liquidation_amounts<T0, T1>(arg0: &0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::obligation::Obligation, arg1: &0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::market::Market, arg2: &0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::coin_decimals_registry::CoinDecimalsRegistry, arg3: u64, arg4: &0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::x_oracle::XOracle, arg5: &0x2::clock::Clock) : (u64, u64, u64) {
        let (v0, v1) = max_liquidation_amounts<T0, T1>(arg0, arg1, arg2, arg4, arg5);
        if (v1 == 0) {
            return (0, 0, 0)
        };
        let (v2, v3) = if (arg3 >= v0) {
            (v0, v1)
        } else {
            (arg3, 0x1::fixed_point32::multiply_u64(arg3, calc_liq_exchange_rate<T0, T1>(arg1, arg2, arg4, arg5)))
        };
        let v4 = 0x1::fixed_point32::multiply_u64(v2, 0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::risk_model::liq_revenue_factor(0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::market::risk_model(arg1, 0x1::type_name::get<T1>())));
        (v2 - v4, v4, v3)
    }

    public fun max_liquidation_amounts<T0, T1>(arg0: &0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::obligation::Obligation, arg1: &0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::market::Market, arg2: &0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::x_oracle::XOracle, arg4: &0x2::clock::Clock) : (u64, u64) {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::type_name::get<T1>();
        let v2 = 0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::market::risk_model(arg1, v1);
        let v3 = 0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::risk_model::liq_factor(v2);
        let v4 = 0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::collateral_value::collaterals_value_usd_for_liquidation(arg0, arg1, arg2, arg3, arg4);
        let v5 = 0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::debt_value::debts_value_usd_with_weight(arg0, arg2, arg1, arg3, arg4);
        if (!0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::fixed_point32_empower::gt(v5, v4)) {
            return (0, 0)
        };
        let v6 = 0x2::math::min(0x1::fixed_point32::multiply_u64(0x2::math::pow(10, 0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::coin_decimals_registry::decimals(arg2, v1)), 0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::fixed_point32_empower::div(0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::fixed_point32_empower::div(0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::fixed_point32_empower::sub(v5, v4), 0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::fixed_point32_empower::sub(0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::fixed_point32_empower::mul(0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::interest_model::borrow_weight(0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::market::interest_model(arg1, v0)), 0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::fixed_point32_empower::sub(0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::fixed_point32_empower::from_u64(1), 0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::risk_model::liq_penalty(v2))), v3)), 0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::price::get_price(arg3, v1, arg4))), 0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::obligation::collateral(arg0, v1));
        let v7 = calc_liq_exchange_rate<T0, T1>(arg1, arg2, arg3, arg4);
        let v8 = 0x1::fixed_point32::divide_u64(v6, v7);
        let (v9, _) = 0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::obligation::debt(arg0, v0);
        if (v8 <= v9) {
            (v8, v6)
        } else {
            (v9, 0x1::fixed_point32::multiply_u64(v9, v7))
        }
    }

    // decompiled from Move bytecode v6
}

