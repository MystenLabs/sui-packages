module 0x7dcc19ef54dc4866df5921dacc872cd341f403a0f6053a35ef834ebc67ab3092::liquidation_evaluator {
    fun calc_liq_exchange_rate<T0, T1>(arg0: &0x7dcc19ef54dc4866df5921dacc872cd341f403a0f6053a35ef834ebc67ab3092::market::Market, arg1: &0x596e3f4cbfceafa0cca766cad1bd9a42ef720732c3fe786f75cc8c70575e31e::coin_decimals_registry::CoinDecimalsRegistry, arg2: &0x66895f6e3a45637db4bf50868d6b522f18f8ab35687517d3bacea4f1a3bae218::x_oracle::XOracle, arg3: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0x1::type_name::get<T1>();
        let v1 = 0x1::type_name::get<T0>();
        0xfff634b447243fd77f2cb87de5a84dfdce199ae70cb6f40e87a17e9fd24f6dac::fixed_point32_empower::div(0xfff634b447243fd77f2cb87de5a84dfdce199ae70cb6f40e87a17e9fd24f6dac::fixed_point32_empower::mul(0x1::fixed_point32::create_from_rational(0x2::math::pow(10, 0x596e3f4cbfceafa0cca766cad1bd9a42ef720732c3fe786f75cc8c70575e31e::coin_decimals_registry::decimals(arg1, v0)), 0x2::math::pow(10, 0x596e3f4cbfceafa0cca766cad1bd9a42ef720732c3fe786f75cc8c70575e31e::coin_decimals_registry::decimals(arg1, v1))), 0xfff634b447243fd77f2cb87de5a84dfdce199ae70cb6f40e87a17e9fd24f6dac::fixed_point32_empower::div(0x7dcc19ef54dc4866df5921dacc872cd341f403a0f6053a35ef834ebc67ab3092::price::get_price(arg2, v1, arg3), 0x7dcc19ef54dc4866df5921dacc872cd341f403a0f6053a35ef834ebc67ab3092::price::get_price(arg2, v0, arg3))), 0xfff634b447243fd77f2cb87de5a84dfdce199ae70cb6f40e87a17e9fd24f6dac::fixed_point32_empower::sub(0xfff634b447243fd77f2cb87de5a84dfdce199ae70cb6f40e87a17e9fd24f6dac::fixed_point32_empower::from_u64(1), 0x7dcc19ef54dc4866df5921dacc872cd341f403a0f6053a35ef834ebc67ab3092::risk_model::liq_discount(0x7dcc19ef54dc4866df5921dacc872cd341f403a0f6053a35ef834ebc67ab3092::market::risk_model(arg0, v0))))
    }

    public fun liquidation_amounts<T0, T1>(arg0: &0x7dcc19ef54dc4866df5921dacc872cd341f403a0f6053a35ef834ebc67ab3092::obligation::Obligation, arg1: &0x7dcc19ef54dc4866df5921dacc872cd341f403a0f6053a35ef834ebc67ab3092::market::Market, arg2: &0x596e3f4cbfceafa0cca766cad1bd9a42ef720732c3fe786f75cc8c70575e31e::coin_decimals_registry::CoinDecimalsRegistry, arg3: u64, arg4: &0x66895f6e3a45637db4bf50868d6b522f18f8ab35687517d3bacea4f1a3bae218::x_oracle::XOracle, arg5: &0x2::clock::Clock) : (u64, u64, u64) {
        let (v0, v1) = max_liquidation_amounts<T0, T1>(arg0, arg1, arg2, arg4, arg5);
        if (v1 == 0) {
            return (0, 0, 0)
        };
        let (v2, v3) = if (arg3 >= v0) {
            (v0, v1)
        } else {
            (arg3, 0x1::fixed_point32::multiply_u64(arg3, calc_liq_exchange_rate<T0, T1>(arg1, arg2, arg4, arg5)))
        };
        let v4 = 0x1::fixed_point32::multiply_u64(v2, 0x7dcc19ef54dc4866df5921dacc872cd341f403a0f6053a35ef834ebc67ab3092::risk_model::liq_revenue_factor(0x7dcc19ef54dc4866df5921dacc872cd341f403a0f6053a35ef834ebc67ab3092::market::risk_model(arg1, 0x1::type_name::get<T1>())));
        (v2 - v4, v4, v3)
    }

    public fun max_liquidation_amounts<T0, T1>(arg0: &0x7dcc19ef54dc4866df5921dacc872cd341f403a0f6053a35ef834ebc67ab3092::obligation::Obligation, arg1: &0x7dcc19ef54dc4866df5921dacc872cd341f403a0f6053a35ef834ebc67ab3092::market::Market, arg2: &0x596e3f4cbfceafa0cca766cad1bd9a42ef720732c3fe786f75cc8c70575e31e::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x66895f6e3a45637db4bf50868d6b522f18f8ab35687517d3bacea4f1a3bae218::x_oracle::XOracle, arg4: &0x2::clock::Clock) : (u64, u64) {
        let v0 = 0x1::type_name::get<T1>();
        let v1 = 0x7dcc19ef54dc4866df5921dacc872cd341f403a0f6053a35ef834ebc67ab3092::market::risk_model(arg1, v0);
        let v2 = 0x7dcc19ef54dc4866df5921dacc872cd341f403a0f6053a35ef834ebc67ab3092::risk_model::liq_factor(v1);
        let v3 = 0x7dcc19ef54dc4866df5921dacc872cd341f403a0f6053a35ef834ebc67ab3092::collateral_value::collaterals_value_usd_for_liquidation(arg0, arg1, arg2, arg3, arg4);
        let v4 = 0x7dcc19ef54dc4866df5921dacc872cd341f403a0f6053a35ef834ebc67ab3092::debt_value::debts_value_usd(arg0, arg2, arg3, arg4);
        if (!0xfff634b447243fd77f2cb87de5a84dfdce199ae70cb6f40e87a17e9fd24f6dac::fixed_point32_empower::gt(v4, v3)) {
            return (0, 0)
        };
        let v5 = 0x2::math::min(0x1::fixed_point32::multiply_u64(0x2::math::pow(10, 0x596e3f4cbfceafa0cca766cad1bd9a42ef720732c3fe786f75cc8c70575e31e::coin_decimals_registry::decimals(arg2, v0)), 0xfff634b447243fd77f2cb87de5a84dfdce199ae70cb6f40e87a17e9fd24f6dac::fixed_point32_empower::div(0xfff634b447243fd77f2cb87de5a84dfdce199ae70cb6f40e87a17e9fd24f6dac::fixed_point32_empower::div(0xfff634b447243fd77f2cb87de5a84dfdce199ae70cb6f40e87a17e9fd24f6dac::fixed_point32_empower::sub(v4, v3), 0xfff634b447243fd77f2cb87de5a84dfdce199ae70cb6f40e87a17e9fd24f6dac::fixed_point32_empower::sub(0xfff634b447243fd77f2cb87de5a84dfdce199ae70cb6f40e87a17e9fd24f6dac::fixed_point32_empower::sub(0xfff634b447243fd77f2cb87de5a84dfdce199ae70cb6f40e87a17e9fd24f6dac::fixed_point32_empower::from_u64(1), 0x7dcc19ef54dc4866df5921dacc872cd341f403a0f6053a35ef834ebc67ab3092::risk_model::liq_penalty(v1)), v2)), 0x7dcc19ef54dc4866df5921dacc872cd341f403a0f6053a35ef834ebc67ab3092::price::get_price(arg3, v0, arg4))), 0x7dcc19ef54dc4866df5921dacc872cd341f403a0f6053a35ef834ebc67ab3092::obligation::collateral(arg0, v0));
        let v6 = calc_liq_exchange_rate<T0, T1>(arg1, arg2, arg3, arg4);
        let v7 = 0x1::fixed_point32::divide_u64(v5, v6);
        let (v8, _) = 0x7dcc19ef54dc4866df5921dacc872cd341f403a0f6053a35ef834ebc67ab3092::obligation::debt(arg0, 0x1::type_name::get<T0>());
        if (v7 <= v8) {
            (v7, v5)
        } else {
            (v8, 0x1::fixed_point32::multiply_u64(v8, v6))
        }
    }

    // decompiled from Move bytecode v6
}

