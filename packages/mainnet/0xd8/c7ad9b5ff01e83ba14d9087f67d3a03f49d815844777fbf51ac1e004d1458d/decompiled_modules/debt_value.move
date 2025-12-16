module 0xd8c7ad9b5ff01e83ba14d9087f67d3a03f49d815844777fbf51ac1e004d1458d::debt_value {
    public fun debts_value_usd(arg0: &0xd8c7ad9b5ff01e83ba14d9087f67d3a03f49d815844777fbf51ac1e004d1458d::obligation::Obligation, arg1: &0xe418d2f1bf2bfae8a624e642a56e84d396fe58684be2a84b721fc157ccad6020::coin_decimals_registry::CoinDecimalsRegistry, arg2: &0xa672673d45ce659ff4e5fbca19d2e757a4822d95bbb064e5c98c05e04880b70f::x_oracle::XOracle, arg3: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0xd8c7ad9b5ff01e83ba14d9087f67d3a03f49d815844777fbf51ac1e004d1458d::obligation::debt_types(arg0);
        let v1 = 0xfdf81885becfaa2f617bb179da217a833dae1be112733c36d17e7213668478ba::fixed_point32_empower::zero();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&v0)) {
            let v3 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v0, v2);
            let (v4, _, _) = 0xd8c7ad9b5ff01e83ba14d9087f67d3a03f49d815844777fbf51ac1e004d1458d::obligation::debt(arg0, v3);
            v1 = 0xfdf81885becfaa2f617bb179da217a833dae1be112733c36d17e7213668478ba::fixed_point32_empower::add(v1, 0xd8c7ad9b5ff01e83ba14d9087f67d3a03f49d815844777fbf51ac1e004d1458d::value_calculator::usd_value(0xd8c7ad9b5ff01e83ba14d9087f67d3a03f49d815844777fbf51ac1e004d1458d::price::get_price(arg2, v3, arg3), v4, 0xe418d2f1bf2bfae8a624e642a56e84d396fe58684be2a84b721fc157ccad6020::coin_decimals_registry::decimals(arg1, v3)));
            v2 = v2 + 1;
        };
        v1
    }

    // decompiled from Move bytecode v6
}

