module 0xa0816d57df47db94f0022b4862bed94c0bc57b269f598fccc06ac2bbfe26cf67::liquidation_evaluator {
    fun calc_liq_exchange_rate<T0, T1>(arg0: &0xa0816d57df47db94f0022b4862bed94c0bc57b269f598fccc06ac2bbfe26cf67::market::Market, arg1: &0x2ad4f61ec97424692591625a5ce2c982241ea405e06f4052fc2ab2528dfc6306::coin_decimals_registry::CoinDecimalsRegistry, arg2: &0xc591cdee730dde36263a49ccbfa624d2c031aa81e2b2af1e84dc7488b3f374a5::x_oracle::XOracle, arg3: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0x1::type_name::get<T1>();
        let v1 = 0x1::type_name::get<T0>();
        0xfc009f0a14a67124d5a4fb2f6a7f29d9de8d90eabbce7bf3540125d0a3975ed::fixed_point32_empower::div(0xfc009f0a14a67124d5a4fb2f6a7f29d9de8d90eabbce7bf3540125d0a3975ed::fixed_point32_empower::mul(0x1::fixed_point32::create_from_rational(0x2::math::pow(10, 0x2ad4f61ec97424692591625a5ce2c982241ea405e06f4052fc2ab2528dfc6306::coin_decimals_registry::decimals(arg1, v0)), 0x2::math::pow(10, 0x2ad4f61ec97424692591625a5ce2c982241ea405e06f4052fc2ab2528dfc6306::coin_decimals_registry::decimals(arg1, v1))), 0xfc009f0a14a67124d5a4fb2f6a7f29d9de8d90eabbce7bf3540125d0a3975ed::fixed_point32_empower::div(0xa0816d57df47db94f0022b4862bed94c0bc57b269f598fccc06ac2bbfe26cf67::price::get_price(arg2, v1, arg3), 0xa0816d57df47db94f0022b4862bed94c0bc57b269f598fccc06ac2bbfe26cf67::price::get_price(arg2, v0, arg3))), 0xfc009f0a14a67124d5a4fb2f6a7f29d9de8d90eabbce7bf3540125d0a3975ed::fixed_point32_empower::sub(0xfc009f0a14a67124d5a4fb2f6a7f29d9de8d90eabbce7bf3540125d0a3975ed::fixed_point32_empower::from_u64(1), 0xa0816d57df47db94f0022b4862bed94c0bc57b269f598fccc06ac2bbfe26cf67::risk_model::liq_discount(0xa0816d57df47db94f0022b4862bed94c0bc57b269f598fccc06ac2bbfe26cf67::market::risk_model(arg0, v0))))
    }

    public fun liquidation_amounts<T0, T1>(arg0: &0xa0816d57df47db94f0022b4862bed94c0bc57b269f598fccc06ac2bbfe26cf67::obligation::Obligation, arg1: &0xa0816d57df47db94f0022b4862bed94c0bc57b269f598fccc06ac2bbfe26cf67::market::Market, arg2: &0x2ad4f61ec97424692591625a5ce2c982241ea405e06f4052fc2ab2528dfc6306::coin_decimals_registry::CoinDecimalsRegistry, arg3: u64, arg4: &0xc591cdee730dde36263a49ccbfa624d2c031aa81e2b2af1e84dc7488b3f374a5::x_oracle::XOracle, arg5: &0x2::clock::Clock) : (u64, u64, u64) {
        let (v0, v1) = max_liquidation_amounts<T0, T1>(arg0, arg1, arg2, arg4, arg5);
        if (v1 == 0) {
            return (0, 0, 0)
        };
        let (v2, v3) = if (arg3 >= v0) {
            (v0, v1)
        } else {
            (arg3, 0x1::fixed_point32::multiply_u64(arg3, calc_liq_exchange_rate<T0, T1>(arg1, arg2, arg4, arg5)))
        };
        let v4 = 0x1::fixed_point32::multiply_u64(v2, 0xa0816d57df47db94f0022b4862bed94c0bc57b269f598fccc06ac2bbfe26cf67::risk_model::liq_revenue_factor(0xa0816d57df47db94f0022b4862bed94c0bc57b269f598fccc06ac2bbfe26cf67::market::risk_model(arg1, 0x1::type_name::get<T1>())));
        (v2 - v4, v4, v3)
    }

    public fun max_liquidation_amounts<T0, T1>(arg0: &0xa0816d57df47db94f0022b4862bed94c0bc57b269f598fccc06ac2bbfe26cf67::obligation::Obligation, arg1: &0xa0816d57df47db94f0022b4862bed94c0bc57b269f598fccc06ac2bbfe26cf67::market::Market, arg2: &0x2ad4f61ec97424692591625a5ce2c982241ea405e06f4052fc2ab2528dfc6306::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0xc591cdee730dde36263a49ccbfa624d2c031aa81e2b2af1e84dc7488b3f374a5::x_oracle::XOracle, arg4: &0x2::clock::Clock) : (u64, u64) {
        let v0 = 0x1::type_name::get<T1>();
        let v1 = 0xa0816d57df47db94f0022b4862bed94c0bc57b269f598fccc06ac2bbfe26cf67::market::risk_model(arg1, v0);
        let v2 = 0xa0816d57df47db94f0022b4862bed94c0bc57b269f598fccc06ac2bbfe26cf67::risk_model::liq_factor(v1);
        let v3 = 0xa0816d57df47db94f0022b4862bed94c0bc57b269f598fccc06ac2bbfe26cf67::collateral_value::collaterals_value_usd_for_liquidation(arg0, arg1, arg2, arg3, arg4);
        let v4 = 0xa0816d57df47db94f0022b4862bed94c0bc57b269f598fccc06ac2bbfe26cf67::debt_value::debts_value_usd(arg0, arg2, arg3, arg4);
        if (!0xfc009f0a14a67124d5a4fb2f6a7f29d9de8d90eabbce7bf3540125d0a3975ed::fixed_point32_empower::gt(v4, v3)) {
            return (0, 0)
        };
        let v5 = 0x2::math::min(0x1::fixed_point32::multiply_u64(0x2::math::pow(10, 0x2ad4f61ec97424692591625a5ce2c982241ea405e06f4052fc2ab2528dfc6306::coin_decimals_registry::decimals(arg2, v0)), 0xfc009f0a14a67124d5a4fb2f6a7f29d9de8d90eabbce7bf3540125d0a3975ed::fixed_point32_empower::div(0xfc009f0a14a67124d5a4fb2f6a7f29d9de8d90eabbce7bf3540125d0a3975ed::fixed_point32_empower::div(0xfc009f0a14a67124d5a4fb2f6a7f29d9de8d90eabbce7bf3540125d0a3975ed::fixed_point32_empower::sub(v4, v3), 0xfc009f0a14a67124d5a4fb2f6a7f29d9de8d90eabbce7bf3540125d0a3975ed::fixed_point32_empower::sub(0xfc009f0a14a67124d5a4fb2f6a7f29d9de8d90eabbce7bf3540125d0a3975ed::fixed_point32_empower::sub(0xfc009f0a14a67124d5a4fb2f6a7f29d9de8d90eabbce7bf3540125d0a3975ed::fixed_point32_empower::from_u64(1), 0xa0816d57df47db94f0022b4862bed94c0bc57b269f598fccc06ac2bbfe26cf67::risk_model::liq_penalty(v1)), v2)), 0xa0816d57df47db94f0022b4862bed94c0bc57b269f598fccc06ac2bbfe26cf67::price::get_price(arg3, v0, arg4))), 0xa0816d57df47db94f0022b4862bed94c0bc57b269f598fccc06ac2bbfe26cf67::obligation::collateral(arg0, v0));
        let v6 = calc_liq_exchange_rate<T0, T1>(arg1, arg2, arg3, arg4);
        let v7 = 0x1::fixed_point32::divide_u64(v5, v6);
        let (v8, _, _) = 0xa0816d57df47db94f0022b4862bed94c0bc57b269f598fccc06ac2bbfe26cf67::obligation::debt(arg0, 0x1::type_name::get<T0>());
        if (v7 <= v8) {
            (v7, v5)
        } else {
            (v8, 0x1::fixed_point32::multiply_u64(v8, v6))
        }
    }

    // decompiled from Move bytecode v6
}

