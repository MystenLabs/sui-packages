module 0xfa1b83a863a897c84040764305f9a87e8633d69f31ef5b034ce6f26d87cdc7b2::collateral_value {
    public fun collaterals_value_usd_for_borrow(arg0: &0xfa1b83a863a897c84040764305f9a87e8633d69f31ef5b034ce6f26d87cdc7b2::obligation::Obligation, arg1: &0xfa1b83a863a897c84040764305f9a87e8633d69f31ef5b034ce6f26d87cdc7b2::market::Market, arg2: &0xfa1b83a863a897c84040764305f9a87e8633d69f31ef5b034ce6f26d87cdc7b2::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0xfa1b83a863a897c84040764305f9a87e8633d69f31ef5b034ce6f26d87cdc7b2::x_oracle::XOracle, arg4: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0xfa1b83a863a897c84040764305f9a87e8633d69f31ef5b034ce6f26d87cdc7b2::obligation::collateral_types(arg0);
        let v1 = 0xfa1b83a863a897c84040764305f9a87e8633d69f31ef5b034ce6f26d87cdc7b2::fixed_point32_empower::zero();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&v0)) {
            let v3 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v0, v2);
            v1 = 0xfa1b83a863a897c84040764305f9a87e8633d69f31ef5b034ce6f26d87cdc7b2::fixed_point32_empower::add(v1, 0xfa1b83a863a897c84040764305f9a87e8633d69f31ef5b034ce6f26d87cdc7b2::fixed_point32_empower::mul(0xfa1b83a863a897c84040764305f9a87e8633d69f31ef5b034ce6f26d87cdc7b2::value_calculator::usd_value(0xfa1b83a863a897c84040764305f9a87e8633d69f31ef5b034ce6f26d87cdc7b2::price::get_price(arg3, v3, arg4), 0xfa1b83a863a897c84040764305f9a87e8633d69f31ef5b034ce6f26d87cdc7b2::obligation::collateral(arg0, v3), 0xfa1b83a863a897c84040764305f9a87e8633d69f31ef5b034ce6f26d87cdc7b2::coin_decimals_registry::decimals(arg2, v3)), 0xfa1b83a863a897c84040764305f9a87e8633d69f31ef5b034ce6f26d87cdc7b2::risk_model::collateral_factor(0xfa1b83a863a897c84040764305f9a87e8633d69f31ef5b034ce6f26d87cdc7b2::market::risk_model(arg1, v3))));
            v2 = v2 + 1;
        };
        v1
    }

    public fun collaterals_value_usd_for_liquidation(arg0: &0xfa1b83a863a897c84040764305f9a87e8633d69f31ef5b034ce6f26d87cdc7b2::obligation::Obligation, arg1: &0xfa1b83a863a897c84040764305f9a87e8633d69f31ef5b034ce6f26d87cdc7b2::market::Market, arg2: &0xfa1b83a863a897c84040764305f9a87e8633d69f31ef5b034ce6f26d87cdc7b2::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0xfa1b83a863a897c84040764305f9a87e8633d69f31ef5b034ce6f26d87cdc7b2::x_oracle::XOracle, arg4: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0xfa1b83a863a897c84040764305f9a87e8633d69f31ef5b034ce6f26d87cdc7b2::obligation::collateral_types(arg0);
        let v1 = 0xfa1b83a863a897c84040764305f9a87e8633d69f31ef5b034ce6f26d87cdc7b2::fixed_point32_empower::zero();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&v0)) {
            let v3 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v0, v2);
            v1 = 0xfa1b83a863a897c84040764305f9a87e8633d69f31ef5b034ce6f26d87cdc7b2::fixed_point32_empower::add(v1, 0xfa1b83a863a897c84040764305f9a87e8633d69f31ef5b034ce6f26d87cdc7b2::fixed_point32_empower::mul(0xfa1b83a863a897c84040764305f9a87e8633d69f31ef5b034ce6f26d87cdc7b2::value_calculator::usd_value(0xfa1b83a863a897c84040764305f9a87e8633d69f31ef5b034ce6f26d87cdc7b2::price::get_price(arg3, v3, arg4), 0xfa1b83a863a897c84040764305f9a87e8633d69f31ef5b034ce6f26d87cdc7b2::obligation::collateral(arg0, v3), 0xfa1b83a863a897c84040764305f9a87e8633d69f31ef5b034ce6f26d87cdc7b2::coin_decimals_registry::decimals(arg2, v3)), 0xfa1b83a863a897c84040764305f9a87e8633d69f31ef5b034ce6f26d87cdc7b2::risk_model::liq_factor(0xfa1b83a863a897c84040764305f9a87e8633d69f31ef5b034ce6f26d87cdc7b2::market::risk_model(arg1, v3))));
            v2 = v2 + 1;
        };
        v1
    }

    // decompiled from Move bytecode v6
}

