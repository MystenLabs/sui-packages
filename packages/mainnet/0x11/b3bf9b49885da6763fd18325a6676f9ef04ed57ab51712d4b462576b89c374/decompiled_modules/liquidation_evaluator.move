module 0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::liquidation_evaluator {
    fun calc_liq_exchange_rate<T0, T1>(arg0: &0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::market::Market, arg1: &0x7796b84742df90f7f700f10cb0d333aa95572b05c6daa556ee10597333069189::coin_decimals_registry::CoinDecimalsRegistry, arg2: &0xe46a4a7ba1cdb785de2ebac5fa36a336bb560230fbccc023b26f0469dd4392c::x_oracle::XOracle, arg3: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0x1::type_name::get<T1>();
        let v1 = 0x1::type_name::get<T0>();
        0x7a2b7bd2ae94b09560fb22b9ff4137c66ebce098e8c76660c6635027f3c6a34f::fixed_point32_empower::div(0x7a2b7bd2ae94b09560fb22b9ff4137c66ebce098e8c76660c6635027f3c6a34f::fixed_point32_empower::mul(0x1::fixed_point32::create_from_rational(0x2::math::pow(10, 0x7796b84742df90f7f700f10cb0d333aa95572b05c6daa556ee10597333069189::coin_decimals_registry::decimals(arg1, v0)), 0x2::math::pow(10, 0x7796b84742df90f7f700f10cb0d333aa95572b05c6daa556ee10597333069189::coin_decimals_registry::decimals(arg1, v1))), 0x7a2b7bd2ae94b09560fb22b9ff4137c66ebce098e8c76660c6635027f3c6a34f::fixed_point32_empower::div(0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::price::get_price(arg2, v1, arg3), 0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::price::get_price(arg2, v0, arg3))), 0x7a2b7bd2ae94b09560fb22b9ff4137c66ebce098e8c76660c6635027f3c6a34f::fixed_point32_empower::sub(0x7a2b7bd2ae94b09560fb22b9ff4137c66ebce098e8c76660c6635027f3c6a34f::fixed_point32_empower::from_u64(1), 0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::risk_model::liq_discount(0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::market::risk_model(arg0, v0))))
    }

    public fun liquidation_amounts<T0, T1>(arg0: &0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::obligation::Obligation, arg1: &0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::market::Market, arg2: &0x7796b84742df90f7f700f10cb0d333aa95572b05c6daa556ee10597333069189::coin_decimals_registry::CoinDecimalsRegistry, arg3: u64, arg4: &0xe46a4a7ba1cdb785de2ebac5fa36a336bb560230fbccc023b26f0469dd4392c::x_oracle::XOracle, arg5: &0x2::clock::Clock) : (u64, u64, u64) {
        let (v0, v1) = max_liquidation_amounts<T0, T1>(arg0, arg1, arg2, arg4, arg5);
        if (v1 == 0) {
            return (0, 0, 0)
        };
        let (v2, v3) = if (arg3 >= v0) {
            (v0, v1)
        } else {
            (arg3, 0x1::fixed_point32::multiply_u64(arg3, calc_liq_exchange_rate<T0, T1>(arg1, arg2, arg4, arg5)))
        };
        let v4 = 0x1::fixed_point32::multiply_u64(v2, 0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::risk_model::liq_revenue_factor(0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::market::risk_model(arg1, 0x1::type_name::get<T1>())));
        (v2 - v4, v4, v3)
    }

    public fun max_liquidation_amounts<T0, T1>(arg0: &0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::obligation::Obligation, arg1: &0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::market::Market, arg2: &0x7796b84742df90f7f700f10cb0d333aa95572b05c6daa556ee10597333069189::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0xe46a4a7ba1cdb785de2ebac5fa36a336bb560230fbccc023b26f0469dd4392c::x_oracle::XOracle, arg4: &0x2::clock::Clock) : (u64, u64) {
        let v0 = 0x1::type_name::get<T1>();
        let v1 = 0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::market::risk_model(arg1, v0);
        let v2 = 0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::risk_model::liq_factor(v1);
        let v3 = 0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::collateral_value::collaterals_value_usd_for_liquidation(arg0, arg1, arg2, arg3, arg4);
        let v4 = 0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::debt_value::debts_value_usd(arg0, arg2, arg3, arg4);
        if (!0x7a2b7bd2ae94b09560fb22b9ff4137c66ebce098e8c76660c6635027f3c6a34f::fixed_point32_empower::gt(v4, v3)) {
            return (0, 0)
        };
        let v5 = 0x2::math::min(0x1::fixed_point32::multiply_u64(0x2::math::pow(10, 0x7796b84742df90f7f700f10cb0d333aa95572b05c6daa556ee10597333069189::coin_decimals_registry::decimals(arg2, v0)), 0x7a2b7bd2ae94b09560fb22b9ff4137c66ebce098e8c76660c6635027f3c6a34f::fixed_point32_empower::div(0x7a2b7bd2ae94b09560fb22b9ff4137c66ebce098e8c76660c6635027f3c6a34f::fixed_point32_empower::div(0x7a2b7bd2ae94b09560fb22b9ff4137c66ebce098e8c76660c6635027f3c6a34f::fixed_point32_empower::sub(v4, v3), 0x7a2b7bd2ae94b09560fb22b9ff4137c66ebce098e8c76660c6635027f3c6a34f::fixed_point32_empower::sub(0x7a2b7bd2ae94b09560fb22b9ff4137c66ebce098e8c76660c6635027f3c6a34f::fixed_point32_empower::sub(0x7a2b7bd2ae94b09560fb22b9ff4137c66ebce098e8c76660c6635027f3c6a34f::fixed_point32_empower::from_u64(1), 0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::risk_model::liq_penalty(v1)), v2)), 0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::price::get_price(arg3, v0, arg4))), 0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::obligation::collateral(arg0, v0));
        let v6 = calc_liq_exchange_rate<T0, T1>(arg1, arg2, arg3, arg4);
        let v7 = 0x1::fixed_point32::divide_u64(v5, v6);
        let (v8, _, _) = 0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::obligation::debt(arg0, 0x1::type_name::get<T0>());
        if (v7 <= v8) {
            (v7, v5)
        } else {
            (v8, 0x1::fixed_point32::multiply_u64(v8, v6))
        }
    }

    // decompiled from Move bytecode v6
}

