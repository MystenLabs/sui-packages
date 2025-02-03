module 0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::collateral_value {
    public fun collaterals_value_usd_for_borrow(arg0: &0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::obligation::Obligation, arg1: &0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::market::Market, arg2: &0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::x_oracle::XOracle, arg4: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::obligation::collateral_types(arg0);
        let v1 = 0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::fixed_point32_empower::zero();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&v0)) {
            let v3 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v0, v2);
            v1 = 0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::fixed_point32_empower::add(v1, 0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::fixed_point32_empower::mul(0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::value_calculator::usd_value(0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::price::get_price(arg3, v3, arg4), 0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::obligation::collateral(arg0, v3), 0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::coin_decimals_registry::decimals(arg2, v3)), 0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::risk_model::collateral_factor(0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::market::risk_model(arg1, v3))));
            v2 = v2 + 1;
        };
        v1
    }

    public fun collaterals_value_usd_for_liquidation(arg0: &0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::obligation::Obligation, arg1: &0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::market::Market, arg2: &0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::x_oracle::XOracle, arg4: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::obligation::collateral_types(arg0);
        let v1 = 0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::fixed_point32_empower::zero();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&v0)) {
            let v3 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v0, v2);
            v1 = 0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::fixed_point32_empower::add(v1, 0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::fixed_point32_empower::mul(0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::value_calculator::usd_value(0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::price::get_price(arg3, v3, arg4), 0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::obligation::collateral(arg0, v3), 0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::coin_decimals_registry::decimals(arg2, v3)), 0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::risk_model::liq_factor(0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::market::risk_model(arg1, v3))));
            v2 = v2 + 1;
        };
        v1
    }

    // decompiled from Move bytecode v6
}

