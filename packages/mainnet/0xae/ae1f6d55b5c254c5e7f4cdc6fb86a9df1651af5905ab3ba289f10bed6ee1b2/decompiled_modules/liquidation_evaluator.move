module 0xaeae1f6d55b5c254c5e7f4cdc6fb86a9df1651af5905ab3ba289f10bed6ee1b2::liquidation_evaluator {
    fun calc_liq_exchange_rate<T0, T1>(arg0: &0xaeae1f6d55b5c254c5e7f4cdc6fb86a9df1651af5905ab3ba289f10bed6ee1b2::market::Market, arg1: &0x8ceeeb2bca5b5eb310b9436b0d7ce7d81b27ce0fb58370cbc200e2f9365730d1::coin_decimals_registry::CoinDecimalsRegistry, arg2: &0xba8ce54a8b72c404990eafcee688689fe90a76657a14d1b7b528f419808833c8::x_oracle::XOracle, arg3: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0x1::type_name::get<T1>();
        let v1 = 0x1::type_name::get<T0>();
        0xa49e119af5217a0c160aa89e9b36194541e2bc9e0b00fb7be6ca4fb1062ea3dd::fixed_point32_empower::div(0xa49e119af5217a0c160aa89e9b36194541e2bc9e0b00fb7be6ca4fb1062ea3dd::fixed_point32_empower::mul(0x1::fixed_point32::create_from_rational(0x2::math::pow(10, 0x8ceeeb2bca5b5eb310b9436b0d7ce7d81b27ce0fb58370cbc200e2f9365730d1::coin_decimals_registry::decimals(arg1, v0)), 0x2::math::pow(10, 0x8ceeeb2bca5b5eb310b9436b0d7ce7d81b27ce0fb58370cbc200e2f9365730d1::coin_decimals_registry::decimals(arg1, v1))), 0xa49e119af5217a0c160aa89e9b36194541e2bc9e0b00fb7be6ca4fb1062ea3dd::fixed_point32_empower::div(0xaeae1f6d55b5c254c5e7f4cdc6fb86a9df1651af5905ab3ba289f10bed6ee1b2::price::get_price(arg2, v1, arg3), 0xaeae1f6d55b5c254c5e7f4cdc6fb86a9df1651af5905ab3ba289f10bed6ee1b2::price::get_price(arg2, v0, arg3))), 0xa49e119af5217a0c160aa89e9b36194541e2bc9e0b00fb7be6ca4fb1062ea3dd::fixed_point32_empower::sub(0xa49e119af5217a0c160aa89e9b36194541e2bc9e0b00fb7be6ca4fb1062ea3dd::fixed_point32_empower::from_u64(1), 0xaeae1f6d55b5c254c5e7f4cdc6fb86a9df1651af5905ab3ba289f10bed6ee1b2::risk_model::liq_discount(0xaeae1f6d55b5c254c5e7f4cdc6fb86a9df1651af5905ab3ba289f10bed6ee1b2::market::risk_model(arg0, v0))))
    }

    public fun liquidation_amounts<T0, T1>(arg0: &0xaeae1f6d55b5c254c5e7f4cdc6fb86a9df1651af5905ab3ba289f10bed6ee1b2::obligation::Obligation, arg1: &0xaeae1f6d55b5c254c5e7f4cdc6fb86a9df1651af5905ab3ba289f10bed6ee1b2::market::Market, arg2: &0x8ceeeb2bca5b5eb310b9436b0d7ce7d81b27ce0fb58370cbc200e2f9365730d1::coin_decimals_registry::CoinDecimalsRegistry, arg3: u64, arg4: &0xba8ce54a8b72c404990eafcee688689fe90a76657a14d1b7b528f419808833c8::x_oracle::XOracle, arg5: &0x2::clock::Clock) : (u64, u64, u64) {
        let (v0, v1) = max_liquidation_amounts<T0, T1>(arg0, arg1, arg2, arg4, arg5);
        if (v1 == 0) {
            return (0, 0, 0)
        };
        let (v2, v3) = if (arg3 >= v0) {
            (v0, v1)
        } else {
            (arg3, 0x1::fixed_point32::multiply_u64(arg3, calc_liq_exchange_rate<T0, T1>(arg1, arg2, arg4, arg5)))
        };
        let v4 = 0x1::fixed_point32::multiply_u64(v2, 0xaeae1f6d55b5c254c5e7f4cdc6fb86a9df1651af5905ab3ba289f10bed6ee1b2::risk_model::liq_revenue_factor(0xaeae1f6d55b5c254c5e7f4cdc6fb86a9df1651af5905ab3ba289f10bed6ee1b2::market::risk_model(arg1, 0x1::type_name::get<T1>())));
        (v2 - v4, v4, v3)
    }

    public fun max_liquidation_amounts<T0, T1>(arg0: &0xaeae1f6d55b5c254c5e7f4cdc6fb86a9df1651af5905ab3ba289f10bed6ee1b2::obligation::Obligation, arg1: &0xaeae1f6d55b5c254c5e7f4cdc6fb86a9df1651af5905ab3ba289f10bed6ee1b2::market::Market, arg2: &0x8ceeeb2bca5b5eb310b9436b0d7ce7d81b27ce0fb58370cbc200e2f9365730d1::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0xba8ce54a8b72c404990eafcee688689fe90a76657a14d1b7b528f419808833c8::x_oracle::XOracle, arg4: &0x2::clock::Clock) : (u64, u64) {
        let v0 = 0x1::type_name::get<T1>();
        let v1 = 0xaeae1f6d55b5c254c5e7f4cdc6fb86a9df1651af5905ab3ba289f10bed6ee1b2::market::risk_model(arg1, v0);
        let v2 = 0xaeae1f6d55b5c254c5e7f4cdc6fb86a9df1651af5905ab3ba289f10bed6ee1b2::risk_model::liq_factor(v1);
        let v3 = 0xaeae1f6d55b5c254c5e7f4cdc6fb86a9df1651af5905ab3ba289f10bed6ee1b2::collateral_value::collaterals_value_usd_for_liquidation(arg0, arg1, arg2, arg3, arg4);
        let v4 = 0xaeae1f6d55b5c254c5e7f4cdc6fb86a9df1651af5905ab3ba289f10bed6ee1b2::debt_value::debts_value_usd(arg0, arg2, arg3, arg4);
        if (!0xa49e119af5217a0c160aa89e9b36194541e2bc9e0b00fb7be6ca4fb1062ea3dd::fixed_point32_empower::gt(v4, v3)) {
            return (0, 0)
        };
        let v5 = 0x2::math::min(0x1::fixed_point32::multiply_u64(0x2::math::pow(10, 0x8ceeeb2bca5b5eb310b9436b0d7ce7d81b27ce0fb58370cbc200e2f9365730d1::coin_decimals_registry::decimals(arg2, v0)), 0xa49e119af5217a0c160aa89e9b36194541e2bc9e0b00fb7be6ca4fb1062ea3dd::fixed_point32_empower::div(0xa49e119af5217a0c160aa89e9b36194541e2bc9e0b00fb7be6ca4fb1062ea3dd::fixed_point32_empower::div(0xa49e119af5217a0c160aa89e9b36194541e2bc9e0b00fb7be6ca4fb1062ea3dd::fixed_point32_empower::sub(v4, v3), 0xa49e119af5217a0c160aa89e9b36194541e2bc9e0b00fb7be6ca4fb1062ea3dd::fixed_point32_empower::sub(0xa49e119af5217a0c160aa89e9b36194541e2bc9e0b00fb7be6ca4fb1062ea3dd::fixed_point32_empower::sub(0xa49e119af5217a0c160aa89e9b36194541e2bc9e0b00fb7be6ca4fb1062ea3dd::fixed_point32_empower::from_u64(1), 0xaeae1f6d55b5c254c5e7f4cdc6fb86a9df1651af5905ab3ba289f10bed6ee1b2::risk_model::liq_penalty(v1)), v2)), 0xaeae1f6d55b5c254c5e7f4cdc6fb86a9df1651af5905ab3ba289f10bed6ee1b2::price::get_price(arg3, v0, arg4))), 0xaeae1f6d55b5c254c5e7f4cdc6fb86a9df1651af5905ab3ba289f10bed6ee1b2::obligation::collateral(arg0, v0));
        let v6 = calc_liq_exchange_rate<T0, T1>(arg1, arg2, arg3, arg4);
        let v7 = 0x1::fixed_point32::divide_u64(v5, v6);
        let (v8, _, _) = 0xaeae1f6d55b5c254c5e7f4cdc6fb86a9df1651af5905ab3ba289f10bed6ee1b2::obligation::debt(arg0, 0x1::type_name::get<T0>());
        if (v7 <= v8) {
            (v7, v5)
        } else {
            (v8, 0x1::fixed_point32::multiply_u64(v8, v6))
        }
    }

    // decompiled from Move bytecode v6
}

