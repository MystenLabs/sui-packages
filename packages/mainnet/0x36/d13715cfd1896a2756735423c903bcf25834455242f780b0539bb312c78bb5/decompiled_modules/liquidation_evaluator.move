module 0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::liquidation_evaluator {
    fun calc_liq_exchange_rate<T0, T1>(arg0: &0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::market::Market, arg1: &0x5eca23353c3cd5e3a57d5d9e7c90358a770d14c2e1ce831731eb8934bb9c571d::coin_decimals_registry::CoinDecimalsRegistry, arg2: &0x8e226848f7984ca4eb396f3bbcf361ba761e82e50e0b42efeff842d6ed4ac013::x_oracle::XOracle, arg3: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0x1::type_name::get<T1>();
        let v1 = 0x1::type_name::get<T0>();
        0x77431d018d2682972dc7e198b08643848774a7007df97aa227704f87f127d74c::fixed_point32_empower::div(0x77431d018d2682972dc7e198b08643848774a7007df97aa227704f87f127d74c::fixed_point32_empower::mul(0x1::fixed_point32::create_from_rational(0x2::math::pow(10, 0x5eca23353c3cd5e3a57d5d9e7c90358a770d14c2e1ce831731eb8934bb9c571d::coin_decimals_registry::decimals(arg1, v0)), 0x2::math::pow(10, 0x5eca23353c3cd5e3a57d5d9e7c90358a770d14c2e1ce831731eb8934bb9c571d::coin_decimals_registry::decimals(arg1, v1))), 0x77431d018d2682972dc7e198b08643848774a7007df97aa227704f87f127d74c::fixed_point32_empower::div(0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::price::get_price(arg2, v1, arg3), 0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::price::get_price(arg2, v0, arg3))), 0x77431d018d2682972dc7e198b08643848774a7007df97aa227704f87f127d74c::fixed_point32_empower::sub(0x77431d018d2682972dc7e198b08643848774a7007df97aa227704f87f127d74c::fixed_point32_empower::from_u64(1), 0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::risk_model::liq_discount(0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::market::risk_model(arg0, v0))))
    }

    public fun liquidation_amounts<T0, T1>(arg0: &0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::obligation::Obligation, arg1: &0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::market::Market, arg2: &0x5eca23353c3cd5e3a57d5d9e7c90358a770d14c2e1ce831731eb8934bb9c571d::coin_decimals_registry::CoinDecimalsRegistry, arg3: u64, arg4: &0x8e226848f7984ca4eb396f3bbcf361ba761e82e50e0b42efeff842d6ed4ac013::x_oracle::XOracle, arg5: &0x2::clock::Clock) : (u64, u64, u64) {
        let (v0, v1) = max_liquidation_amounts<T0, T1>(arg0, arg1, arg2, arg4, arg5);
        if (v1 == 0) {
            return (0, 0, 0)
        };
        let (v2, v3) = if (arg3 >= v0) {
            (v0, v1)
        } else {
            (arg3, 0x1::fixed_point32::multiply_u64(arg3, calc_liq_exchange_rate<T0, T1>(arg1, arg2, arg4, arg5)))
        };
        let v4 = 0x1::fixed_point32::multiply_u64(v2, 0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::risk_model::liq_revenue_factor(0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::market::risk_model(arg1, 0x1::type_name::get<T1>())));
        (v2 - v4, v4, v3)
    }

    public fun max_liquidation_amounts<T0, T1>(arg0: &0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::obligation::Obligation, arg1: &0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::market::Market, arg2: &0x5eca23353c3cd5e3a57d5d9e7c90358a770d14c2e1ce831731eb8934bb9c571d::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x8e226848f7984ca4eb396f3bbcf361ba761e82e50e0b42efeff842d6ed4ac013::x_oracle::XOracle, arg4: &0x2::clock::Clock) : (u64, u64) {
        let v0 = 0x1::type_name::get<T1>();
        let v1 = 0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::market::risk_model(arg1, v0);
        let v2 = 0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::risk_model::liq_factor(v1);
        let v3 = 0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::collateral_value::collaterals_value_usd_for_liquidation(arg0, arg1, arg2, arg3, arg4);
        let v4 = 0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::debt_value::debts_value_usd(arg0, arg2, arg3, arg4);
        if (!0x77431d018d2682972dc7e198b08643848774a7007df97aa227704f87f127d74c::fixed_point32_empower::gt(v4, v3)) {
            return (0, 0)
        };
        let v5 = 0x2::math::min(0x1::fixed_point32::multiply_u64(0x2::math::pow(10, 0x5eca23353c3cd5e3a57d5d9e7c90358a770d14c2e1ce831731eb8934bb9c571d::coin_decimals_registry::decimals(arg2, v0)), 0x77431d018d2682972dc7e198b08643848774a7007df97aa227704f87f127d74c::fixed_point32_empower::div(0x77431d018d2682972dc7e198b08643848774a7007df97aa227704f87f127d74c::fixed_point32_empower::div(0x77431d018d2682972dc7e198b08643848774a7007df97aa227704f87f127d74c::fixed_point32_empower::sub(v4, v3), 0x77431d018d2682972dc7e198b08643848774a7007df97aa227704f87f127d74c::fixed_point32_empower::sub(0x77431d018d2682972dc7e198b08643848774a7007df97aa227704f87f127d74c::fixed_point32_empower::sub(0x77431d018d2682972dc7e198b08643848774a7007df97aa227704f87f127d74c::fixed_point32_empower::from_u64(1), 0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::risk_model::liq_penalty(v1)), v2)), 0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::price::get_price(arg3, v0, arg4))), 0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::obligation::collateral(arg0, v0));
        let v6 = calc_liq_exchange_rate<T0, T1>(arg1, arg2, arg3, arg4);
        let v7 = 0x1::fixed_point32::divide_u64(v5, v6);
        let (v8, _, _) = 0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::obligation::debt(arg0, 0x1::type_name::get<T0>());
        if (v7 <= v8) {
            (v7, v5)
        } else {
            (v8, 0x1::fixed_point32::multiply_u64(v8, v6))
        }
    }

    // decompiled from Move bytecode v6
}

