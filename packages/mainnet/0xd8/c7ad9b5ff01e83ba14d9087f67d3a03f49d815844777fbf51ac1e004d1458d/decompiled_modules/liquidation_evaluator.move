module 0xd8c7ad9b5ff01e83ba14d9087f67d3a03f49d815844777fbf51ac1e004d1458d::liquidation_evaluator {
    fun calc_liq_exchange_rate<T0, T1>(arg0: &0xd8c7ad9b5ff01e83ba14d9087f67d3a03f49d815844777fbf51ac1e004d1458d::market::Market, arg1: &0xe418d2f1bf2bfae8a624e642a56e84d396fe58684be2a84b721fc157ccad6020::coin_decimals_registry::CoinDecimalsRegistry, arg2: &0xa672673d45ce659ff4e5fbca19d2e757a4822d95bbb064e5c98c05e04880b70f::x_oracle::XOracle, arg3: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0x1::type_name::get<T1>();
        let v1 = 0x1::type_name::get<T0>();
        0xfdf81885becfaa2f617bb179da217a833dae1be112733c36d17e7213668478ba::fixed_point32_empower::div(0xfdf81885becfaa2f617bb179da217a833dae1be112733c36d17e7213668478ba::fixed_point32_empower::mul(0x1::fixed_point32::create_from_rational(0x2::math::pow(10, 0xe418d2f1bf2bfae8a624e642a56e84d396fe58684be2a84b721fc157ccad6020::coin_decimals_registry::decimals(arg1, v0)), 0x2::math::pow(10, 0xe418d2f1bf2bfae8a624e642a56e84d396fe58684be2a84b721fc157ccad6020::coin_decimals_registry::decimals(arg1, v1))), 0xfdf81885becfaa2f617bb179da217a833dae1be112733c36d17e7213668478ba::fixed_point32_empower::div(0xd8c7ad9b5ff01e83ba14d9087f67d3a03f49d815844777fbf51ac1e004d1458d::price::get_price(arg2, v1, arg3), 0xd8c7ad9b5ff01e83ba14d9087f67d3a03f49d815844777fbf51ac1e004d1458d::price::get_price(arg2, v0, arg3))), 0xfdf81885becfaa2f617bb179da217a833dae1be112733c36d17e7213668478ba::fixed_point32_empower::sub(0xfdf81885becfaa2f617bb179da217a833dae1be112733c36d17e7213668478ba::fixed_point32_empower::from_u64(1), 0xd8c7ad9b5ff01e83ba14d9087f67d3a03f49d815844777fbf51ac1e004d1458d::risk_model::liq_discount(0xd8c7ad9b5ff01e83ba14d9087f67d3a03f49d815844777fbf51ac1e004d1458d::market::risk_model(arg0, v0))))
    }

    public fun liquidation_amounts<T0, T1>(arg0: &0xd8c7ad9b5ff01e83ba14d9087f67d3a03f49d815844777fbf51ac1e004d1458d::obligation::Obligation, arg1: &0xd8c7ad9b5ff01e83ba14d9087f67d3a03f49d815844777fbf51ac1e004d1458d::market::Market, arg2: &0xe418d2f1bf2bfae8a624e642a56e84d396fe58684be2a84b721fc157ccad6020::coin_decimals_registry::CoinDecimalsRegistry, arg3: u64, arg4: &0xa672673d45ce659ff4e5fbca19d2e757a4822d95bbb064e5c98c05e04880b70f::x_oracle::XOracle, arg5: &0x2::clock::Clock) : (u64, u64, u64) {
        let (v0, v1) = max_liquidation_amounts<T0, T1>(arg0, arg1, arg2, arg4, arg5);
        if (v1 == 0) {
            return (0, 0, 0)
        };
        let (v2, v3) = if (arg3 >= v0) {
            (v0, v1)
        } else {
            (arg3, 0x1::fixed_point32::multiply_u64(arg3, calc_liq_exchange_rate<T0, T1>(arg1, arg2, arg4, arg5)))
        };
        let v4 = 0x1::fixed_point32::multiply_u64(v2, 0xd8c7ad9b5ff01e83ba14d9087f67d3a03f49d815844777fbf51ac1e004d1458d::risk_model::liq_revenue_factor(0xd8c7ad9b5ff01e83ba14d9087f67d3a03f49d815844777fbf51ac1e004d1458d::market::risk_model(arg1, 0x1::type_name::get<T1>())));
        (v2 - v4, v4, v3)
    }

    public fun max_liquidation_amounts<T0, T1>(arg0: &0xd8c7ad9b5ff01e83ba14d9087f67d3a03f49d815844777fbf51ac1e004d1458d::obligation::Obligation, arg1: &0xd8c7ad9b5ff01e83ba14d9087f67d3a03f49d815844777fbf51ac1e004d1458d::market::Market, arg2: &0xe418d2f1bf2bfae8a624e642a56e84d396fe58684be2a84b721fc157ccad6020::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0xa672673d45ce659ff4e5fbca19d2e757a4822d95bbb064e5c98c05e04880b70f::x_oracle::XOracle, arg4: &0x2::clock::Clock) : (u64, u64) {
        let v0 = 0x1::type_name::get<T1>();
        let v1 = 0xd8c7ad9b5ff01e83ba14d9087f67d3a03f49d815844777fbf51ac1e004d1458d::market::risk_model(arg1, v0);
        let v2 = 0xd8c7ad9b5ff01e83ba14d9087f67d3a03f49d815844777fbf51ac1e004d1458d::risk_model::liq_factor(v1);
        let v3 = 0xd8c7ad9b5ff01e83ba14d9087f67d3a03f49d815844777fbf51ac1e004d1458d::collateral_value::collaterals_value_usd_for_liquidation(arg0, arg1, arg2, arg3, arg4);
        let v4 = 0xd8c7ad9b5ff01e83ba14d9087f67d3a03f49d815844777fbf51ac1e004d1458d::debt_value::debts_value_usd(arg0, arg2, arg3, arg4);
        if (!0xfdf81885becfaa2f617bb179da217a833dae1be112733c36d17e7213668478ba::fixed_point32_empower::gt(v4, v3)) {
            return (0, 0)
        };
        let v5 = 0x2::math::min(0x1::fixed_point32::multiply_u64(0x2::math::pow(10, 0xe418d2f1bf2bfae8a624e642a56e84d396fe58684be2a84b721fc157ccad6020::coin_decimals_registry::decimals(arg2, v0)), 0xfdf81885becfaa2f617bb179da217a833dae1be112733c36d17e7213668478ba::fixed_point32_empower::div(0xfdf81885becfaa2f617bb179da217a833dae1be112733c36d17e7213668478ba::fixed_point32_empower::div(0xfdf81885becfaa2f617bb179da217a833dae1be112733c36d17e7213668478ba::fixed_point32_empower::sub(v4, v3), 0xfdf81885becfaa2f617bb179da217a833dae1be112733c36d17e7213668478ba::fixed_point32_empower::sub(0xfdf81885becfaa2f617bb179da217a833dae1be112733c36d17e7213668478ba::fixed_point32_empower::sub(0xfdf81885becfaa2f617bb179da217a833dae1be112733c36d17e7213668478ba::fixed_point32_empower::from_u64(1), 0xd8c7ad9b5ff01e83ba14d9087f67d3a03f49d815844777fbf51ac1e004d1458d::risk_model::liq_penalty(v1)), v2)), 0xd8c7ad9b5ff01e83ba14d9087f67d3a03f49d815844777fbf51ac1e004d1458d::price::get_price(arg3, v0, arg4))), 0xd8c7ad9b5ff01e83ba14d9087f67d3a03f49d815844777fbf51ac1e004d1458d::obligation::collateral(arg0, v0));
        let v6 = calc_liq_exchange_rate<T0, T1>(arg1, arg2, arg3, arg4);
        let v7 = 0x1::fixed_point32::divide_u64(v5, v6);
        let (v8, _, _) = 0xd8c7ad9b5ff01e83ba14d9087f67d3a03f49d815844777fbf51ac1e004d1458d::obligation::debt(arg0, 0x1::type_name::get<T0>());
        if (v7 <= v8) {
            (v7, v5)
        } else {
            (v8, 0x1::fixed_point32::multiply_u64(v8, v6))
        }
    }

    // decompiled from Move bytecode v6
}

