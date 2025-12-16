module 0xd8c7ad9b5ff01e83ba14d9087f67d3a03f49d815844777fbf51ac1e004d1458d::collateral_value {
    public fun collaterals_value_usd_for_borrow(arg0: &0xd8c7ad9b5ff01e83ba14d9087f67d3a03f49d815844777fbf51ac1e004d1458d::obligation::Obligation, arg1: &0xd8c7ad9b5ff01e83ba14d9087f67d3a03f49d815844777fbf51ac1e004d1458d::market::Market, arg2: &0xe418d2f1bf2bfae8a624e642a56e84d396fe58684be2a84b721fc157ccad6020::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0xa672673d45ce659ff4e5fbca19d2e757a4822d95bbb064e5c98c05e04880b70f::x_oracle::XOracle, arg4: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0xd8c7ad9b5ff01e83ba14d9087f67d3a03f49d815844777fbf51ac1e004d1458d::obligation::collateral_types(arg0);
        let v1 = 0xfdf81885becfaa2f617bb179da217a833dae1be112733c36d17e7213668478ba::fixed_point32_empower::zero();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&v0)) {
            let v3 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v0, v2);
            v1 = 0xfdf81885becfaa2f617bb179da217a833dae1be112733c36d17e7213668478ba::fixed_point32_empower::add(v1, 0xfdf81885becfaa2f617bb179da217a833dae1be112733c36d17e7213668478ba::fixed_point32_empower::mul(0xd8c7ad9b5ff01e83ba14d9087f67d3a03f49d815844777fbf51ac1e004d1458d::value_calculator::usd_value(0xd8c7ad9b5ff01e83ba14d9087f67d3a03f49d815844777fbf51ac1e004d1458d::price::get_price(arg3, v3, arg4), 0xd8c7ad9b5ff01e83ba14d9087f67d3a03f49d815844777fbf51ac1e004d1458d::obligation::collateral(arg0, v3), 0xe418d2f1bf2bfae8a624e642a56e84d396fe58684be2a84b721fc157ccad6020::coin_decimals_registry::decimals(arg2, v3)), 0xd8c7ad9b5ff01e83ba14d9087f67d3a03f49d815844777fbf51ac1e004d1458d::risk_model::collateral_factor(0xd8c7ad9b5ff01e83ba14d9087f67d3a03f49d815844777fbf51ac1e004d1458d::market::risk_model(arg1, v3))));
            v2 = v2 + 1;
        };
        v1
    }

    public fun collaterals_value_usd_for_liquidation(arg0: &0xd8c7ad9b5ff01e83ba14d9087f67d3a03f49d815844777fbf51ac1e004d1458d::obligation::Obligation, arg1: &0xd8c7ad9b5ff01e83ba14d9087f67d3a03f49d815844777fbf51ac1e004d1458d::market::Market, arg2: &0xe418d2f1bf2bfae8a624e642a56e84d396fe58684be2a84b721fc157ccad6020::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0xa672673d45ce659ff4e5fbca19d2e757a4822d95bbb064e5c98c05e04880b70f::x_oracle::XOracle, arg4: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0xd8c7ad9b5ff01e83ba14d9087f67d3a03f49d815844777fbf51ac1e004d1458d::obligation::collateral_types(arg0);
        let v1 = 0xfdf81885becfaa2f617bb179da217a833dae1be112733c36d17e7213668478ba::fixed_point32_empower::zero();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&v0)) {
            let v3 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v0, v2);
            v1 = 0xfdf81885becfaa2f617bb179da217a833dae1be112733c36d17e7213668478ba::fixed_point32_empower::add(v1, 0xfdf81885becfaa2f617bb179da217a833dae1be112733c36d17e7213668478ba::fixed_point32_empower::mul(0xd8c7ad9b5ff01e83ba14d9087f67d3a03f49d815844777fbf51ac1e004d1458d::value_calculator::usd_value(0xd8c7ad9b5ff01e83ba14d9087f67d3a03f49d815844777fbf51ac1e004d1458d::price::get_price(arg3, v3, arg4), 0xd8c7ad9b5ff01e83ba14d9087f67d3a03f49d815844777fbf51ac1e004d1458d::obligation::collateral(arg0, v3), 0xe418d2f1bf2bfae8a624e642a56e84d396fe58684be2a84b721fc157ccad6020::coin_decimals_registry::decimals(arg2, v3)), 0xd8c7ad9b5ff01e83ba14d9087f67d3a03f49d815844777fbf51ac1e004d1458d::risk_model::liq_factor(0xd8c7ad9b5ff01e83ba14d9087f67d3a03f49d815844777fbf51ac1e004d1458d::market::risk_model(arg1, v3))));
            v2 = v2 + 1;
        };
        v1
    }

    // decompiled from Move bytecode v6
}

