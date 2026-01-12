module 0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::liquidation_evaluator {
    fun calc_liq_exchange_rate<T0, T1>(arg0: &0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::market::Market, arg1: &0x413d4cf3221e98f4096aabcab4edc84b9e66f60f2239e5cdbf6e49ee2916c7e0::coin_decimals_registry::CoinDecimalsRegistry, arg2: &0x4f0be0e70afb81670fd135b4201270997f9a32a2dccddaa3925825fe5a8b4c2a::x_oracle::XOracle, arg3: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0x1::type_name::get<T1>();
        let v1 = 0x1::type_name::get<T0>();
        0xbf0ff2c916bccc759793a14cbd121f495f53f6121d8b5fd41c836a8ad8253d7c::fixed_point32_empower::div(0xbf0ff2c916bccc759793a14cbd121f495f53f6121d8b5fd41c836a8ad8253d7c::fixed_point32_empower::mul(0x1::fixed_point32::create_from_rational(0x2::math::pow(10, 0x413d4cf3221e98f4096aabcab4edc84b9e66f60f2239e5cdbf6e49ee2916c7e0::coin_decimals_registry::decimals(arg1, v0)), 0x2::math::pow(10, 0x413d4cf3221e98f4096aabcab4edc84b9e66f60f2239e5cdbf6e49ee2916c7e0::coin_decimals_registry::decimals(arg1, v1))), 0xbf0ff2c916bccc759793a14cbd121f495f53f6121d8b5fd41c836a8ad8253d7c::fixed_point32_empower::div(0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::price::get_price(arg2, v1, arg3), 0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::price::get_price(arg2, v0, arg3))), 0xbf0ff2c916bccc759793a14cbd121f495f53f6121d8b5fd41c836a8ad8253d7c::fixed_point32_empower::sub(0xbf0ff2c916bccc759793a14cbd121f495f53f6121d8b5fd41c836a8ad8253d7c::fixed_point32_empower::from_u64(1), 0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::risk_model::liq_discount(0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::market::risk_model(arg0, v0))))
    }

    public fun liquidation_amounts<T0, T1>(arg0: &0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::obligation::Obligation, arg1: &0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::market::Market, arg2: &0x413d4cf3221e98f4096aabcab4edc84b9e66f60f2239e5cdbf6e49ee2916c7e0::coin_decimals_registry::CoinDecimalsRegistry, arg3: u64, arg4: &0x4f0be0e70afb81670fd135b4201270997f9a32a2dccddaa3925825fe5a8b4c2a::x_oracle::XOracle, arg5: &0x2::clock::Clock) : (u64, u64, u64) {
        let (v0, v1) = max_liquidation_amounts<T0, T1>(arg0, arg1, arg2, arg4, arg5);
        if (v1 == 0) {
            return (0, 0, 0)
        };
        let (v2, v3) = if (arg3 >= v0) {
            (v0, v1)
        } else {
            (arg3, 0x1::fixed_point32::multiply_u64(arg3, calc_liq_exchange_rate<T0, T1>(arg1, arg2, arg4, arg5)))
        };
        let v4 = 0x1::fixed_point32::multiply_u64(v2, 0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::risk_model::liq_revenue_factor(0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::market::risk_model(arg1, 0x1::type_name::get<T1>())));
        (v2 - v4, v4, v3)
    }

    public fun max_liquidation_amounts<T0, T1>(arg0: &0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::obligation::Obligation, arg1: &0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::market::Market, arg2: &0x413d4cf3221e98f4096aabcab4edc84b9e66f60f2239e5cdbf6e49ee2916c7e0::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x4f0be0e70afb81670fd135b4201270997f9a32a2dccddaa3925825fe5a8b4c2a::x_oracle::XOracle, arg4: &0x2::clock::Clock) : (u64, u64) {
        let v0 = 0x1::type_name::get<T1>();
        let v1 = 0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::market::risk_model(arg1, v0);
        let v2 = 0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::risk_model::liq_factor(v1);
        let v3 = 0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::collateral_value::collaterals_value_usd_for_liquidation(arg0, arg1, arg2, arg3, arg4);
        let v4 = 0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::debt_value::debts_value_usd(arg0, arg2, arg3, arg4);
        if (!0xbf0ff2c916bccc759793a14cbd121f495f53f6121d8b5fd41c836a8ad8253d7c::fixed_point32_empower::gt(v4, v3)) {
            return (0, 0)
        };
        let v5 = 0x2::math::min(0x1::fixed_point32::multiply_u64(0x2::math::pow(10, 0x413d4cf3221e98f4096aabcab4edc84b9e66f60f2239e5cdbf6e49ee2916c7e0::coin_decimals_registry::decimals(arg2, v0)), 0xbf0ff2c916bccc759793a14cbd121f495f53f6121d8b5fd41c836a8ad8253d7c::fixed_point32_empower::div(0xbf0ff2c916bccc759793a14cbd121f495f53f6121d8b5fd41c836a8ad8253d7c::fixed_point32_empower::div(0xbf0ff2c916bccc759793a14cbd121f495f53f6121d8b5fd41c836a8ad8253d7c::fixed_point32_empower::sub(v4, v3), 0xbf0ff2c916bccc759793a14cbd121f495f53f6121d8b5fd41c836a8ad8253d7c::fixed_point32_empower::sub(0xbf0ff2c916bccc759793a14cbd121f495f53f6121d8b5fd41c836a8ad8253d7c::fixed_point32_empower::sub(0xbf0ff2c916bccc759793a14cbd121f495f53f6121d8b5fd41c836a8ad8253d7c::fixed_point32_empower::from_u64(1), 0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::risk_model::liq_penalty(v1)), v2)), 0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::price::get_price(arg3, v0, arg4))), 0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::obligation::collateral(arg0, v0));
        let v6 = calc_liq_exchange_rate<T0, T1>(arg1, arg2, arg3, arg4);
        let v7 = 0x1::fixed_point32::divide_u64(v5, v6);
        let (v8, _, _) = 0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::obligation::debt(arg0, 0x1::type_name::get<T0>());
        if (v7 <= v8) {
            (v7, v5)
        } else {
            (v8, 0x1::fixed_point32::multiply_u64(v8, v6))
        }
    }

    // decompiled from Move bytecode v6
}

