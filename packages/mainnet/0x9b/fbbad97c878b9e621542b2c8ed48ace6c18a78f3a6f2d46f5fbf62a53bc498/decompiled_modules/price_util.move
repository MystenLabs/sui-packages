module 0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::price_util {
    public fun evaluate_usd_value<T0>(arg0: &0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::x_oracle::XOracle, arg1: &0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::coin_decimals_registry::CoinDecimalsRegistry, arg2: u64, arg3: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0x1::type_name::get<T0>();
        0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::fixed_point32_empower::mul(0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::price::get_price(arg0, v0, arg3), 0x1::fixed_point32::create_from_rational(arg2, 0x2::math::pow(10, 0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::coin_decimals_registry::decimals(arg1, v0))))
    }

    public fun is_liquidation_profitable<T0>(arg0: &0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::x_oracle::XOracle, arg1: &0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::market::Market, arg2: &0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::coin_decimals_registry::CoinDecimalsRegistry, arg3: u64, arg4: &0x2::clock::Clock) : bool {
        0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::fixed_point32_empower::gt(0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::fixed_point32_empower::mul(evaluate_usd_value<T0>(arg0, arg2, arg3, arg4), 0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::fixed_point32_empower::sub(0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::risk_model::liq_discount(0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::market::risk_model(arg1, 0x1::type_name::get<T0>())), 0x1::fixed_point32::create_from_rational(225, 10000))), 0x1::fixed_point32::create_from_rational(1, 10))
    }

    // decompiled from Move bytecode v6
}

