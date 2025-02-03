module 0xedc00c6e65eb3d4fa369b3b1de6ccbcd11185e027ebb5cc49c8c66c7ce903bd::liquidation_evaluator {
    public fun liquidation_amounts<T0, T1>(arg0: &0xedc00c6e65eb3d4fa369b3b1de6ccbcd11185e027ebb5cc49c8c66c7ce903bd::obligation::Obligation, arg1: &0xedc00c6e65eb3d4fa369b3b1de6ccbcd11185e027ebb5cc49c8c66c7ce903bd::market::Market, arg2: &0xd68eb3aafa85228a532500ca1ca45af097cb3b941dbdf297e68b1f01e0cdd95e::coin_decimals_registry::CoinDecimalsRegistry, arg3: u64, arg4: &0xcd9bf99ee89711edd5084fbd67aee0865b866f0bb3262701ec487cd45b0d3041::x_oracle::XOracle, arg5: &0x2::clock::Clock) : (u64, u64, u64) {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::type_name::get<T1>();
        let v2 = 0x2::math::pow(10, 0xd68eb3aafa85228a532500ca1ca45af097cb3b941dbdf297e68b1f01e0cdd95e::coin_decimals_registry::decimals(arg2, v1));
        let v3 = 0xedc00c6e65eb3d4fa369b3b1de6ccbcd11185e027ebb5cc49c8c66c7ce903bd::market::risk_model(arg1, v1);
        let v4 = 0xedc00c6e65eb3d4fa369b3b1de6ccbcd11185e027ebb5cc49c8c66c7ce903bd::risk_model::liq_discount(v3);
        let v5 = 0xedc00c6e65eb3d4fa369b3b1de6ccbcd11185e027ebb5cc49c8c66c7ce903bd::risk_model::liq_factor(v3);
        let v6 = 0xedc00c6e65eb3d4fa369b3b1de6ccbcd11185e027ebb5cc49c8c66c7ce903bd::risk_model::liq_revenue_factor(v3);
        let v7 = 0xedc00c6e65eb3d4fa369b3b1de6ccbcd11185e027ebb5cc49c8c66c7ce903bd::price::get_price(arg4, v1, arg5);
        let v8 = 0xedc00c6e65eb3d4fa369b3b1de6ccbcd11185e027ebb5cc49c8c66c7ce903bd::collateral_value::collaterals_value_usd_for_liquidation(arg0, arg1, arg2, arg4, arg5);
        let v9 = 0xedc00c6e65eb3d4fa369b3b1de6ccbcd11185e027ebb5cc49c8c66c7ce903bd::debt_value::debts_value_usd_with_weight(arg0, arg2, arg1, arg4, arg5);
        assert!(0x9c564002970ce40370b0c1a8328d2e91924dab43ca2cb483af67aaf0f7cbe44e::fixed_point32_empower::gt(v9, v8), 0xedc00c6e65eb3d4fa369b3b1de6ccbcd11185e027ebb5cc49c8c66c7ce903bd::error::unable_to_liquidate_error());
        let v10 = 0x2::math::min(0x1::fixed_point32::multiply_u64(v2, 0x9c564002970ce40370b0c1a8328d2e91924dab43ca2cb483af67aaf0f7cbe44e::fixed_point32_empower::div(0x9c564002970ce40370b0c1a8328d2e91924dab43ca2cb483af67aaf0f7cbe44e::fixed_point32_empower::div(0x9c564002970ce40370b0c1a8328d2e91924dab43ca2cb483af67aaf0f7cbe44e::fixed_point32_empower::sub(v9, v8), 0x9c564002970ce40370b0c1a8328d2e91924dab43ca2cb483af67aaf0f7cbe44e::fixed_point32_empower::sub(0x9c564002970ce40370b0c1a8328d2e91924dab43ca2cb483af67aaf0f7cbe44e::fixed_point32_empower::mul(0xedc00c6e65eb3d4fa369b3b1de6ccbcd11185e027ebb5cc49c8c66c7ce903bd::interest_model::borrow_weight(0xedc00c6e65eb3d4fa369b3b1de6ccbcd11185e027ebb5cc49c8c66c7ce903bd::market::interest_model(arg1, v0)), 0x9c564002970ce40370b0c1a8328d2e91924dab43ca2cb483af67aaf0f7cbe44e::fixed_point32_empower::sub(0x9c564002970ce40370b0c1a8328d2e91924dab43ca2cb483af67aaf0f7cbe44e::fixed_point32_empower::from_u64(1), 0xedc00c6e65eb3d4fa369b3b1de6ccbcd11185e027ebb5cc49c8c66c7ce903bd::risk_model::liq_penalty(v3))), v5)), v7)), 0xedc00c6e65eb3d4fa369b3b1de6ccbcd11185e027ebb5cc49c8c66c7ce903bd::obligation::collateral(arg0, v1));
        let v11 = 0x9c564002970ce40370b0c1a8328d2e91924dab43ca2cb483af67aaf0f7cbe44e::fixed_point32_empower::div(0x9c564002970ce40370b0c1a8328d2e91924dab43ca2cb483af67aaf0f7cbe44e::fixed_point32_empower::mul(0x1::fixed_point32::create_from_rational(v2, 0x2::math::pow(10, 0xd68eb3aafa85228a532500ca1ca45af097cb3b941dbdf297e68b1f01e0cdd95e::coin_decimals_registry::decimals(arg2, v0))), 0x9c564002970ce40370b0c1a8328d2e91924dab43ca2cb483af67aaf0f7cbe44e::fixed_point32_empower::div(0xedc00c6e65eb3d4fa369b3b1de6ccbcd11185e027ebb5cc49c8c66c7ce903bd::price::get_price(arg4, v0, arg5), v7)), 0x9c564002970ce40370b0c1a8328d2e91924dab43ca2cb483af67aaf0f7cbe44e::fixed_point32_empower::sub(0x9c564002970ce40370b0c1a8328d2e91924dab43ca2cb483af67aaf0f7cbe44e::fixed_point32_empower::from_u64(1), v4));
        let v12 = 0x1::fixed_point32::multiply_u64(arg3, v11);
        let v13 = arg3;
        let v14 = v12;
        if (v12 > v10) {
            v14 = v10;
            v13 = 0x1::fixed_point32::divide_u64(v10, v11);
        };
        let v15 = 0x1::fixed_point32::multiply_u64(v13, v6);
        (v13 - v15, v15, v14)
    }

    // decompiled from Move bytecode v6
}

