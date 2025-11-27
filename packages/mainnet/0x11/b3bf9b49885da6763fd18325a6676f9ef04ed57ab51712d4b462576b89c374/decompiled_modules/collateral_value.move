module 0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::collateral_value {
    public fun collaterals_value_usd_for_borrow(arg0: &0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::obligation::Obligation, arg1: &0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::market::Market, arg2: &0x7796b84742df90f7f700f10cb0d333aa95572b05c6daa556ee10597333069189::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0xe46a4a7ba1cdb785de2ebac5fa36a336bb560230fbccc023b26f0469dd4392c::x_oracle::XOracle, arg4: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::obligation::collateral_types(arg0);
        let v1 = 0x7a2b7bd2ae94b09560fb22b9ff4137c66ebce098e8c76660c6635027f3c6a34f::fixed_point32_empower::zero();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&v0)) {
            let v3 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v0, v2);
            v1 = 0x7a2b7bd2ae94b09560fb22b9ff4137c66ebce098e8c76660c6635027f3c6a34f::fixed_point32_empower::add(v1, 0x7a2b7bd2ae94b09560fb22b9ff4137c66ebce098e8c76660c6635027f3c6a34f::fixed_point32_empower::mul(0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::value_calculator::usd_value(0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::price::get_price(arg3, v3, arg4), 0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::obligation::collateral(arg0, v3), 0x7796b84742df90f7f700f10cb0d333aa95572b05c6daa556ee10597333069189::coin_decimals_registry::decimals(arg2, v3)), 0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::risk_model::collateral_factor(0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::market::risk_model(arg1, v3))));
            v2 = v2 + 1;
        };
        v1
    }

    public fun collaterals_value_usd_for_liquidation(arg0: &0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::obligation::Obligation, arg1: &0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::market::Market, arg2: &0x7796b84742df90f7f700f10cb0d333aa95572b05c6daa556ee10597333069189::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0xe46a4a7ba1cdb785de2ebac5fa36a336bb560230fbccc023b26f0469dd4392c::x_oracle::XOracle, arg4: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::obligation::collateral_types(arg0);
        let v1 = 0x7a2b7bd2ae94b09560fb22b9ff4137c66ebce098e8c76660c6635027f3c6a34f::fixed_point32_empower::zero();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&v0)) {
            let v3 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v0, v2);
            v1 = 0x7a2b7bd2ae94b09560fb22b9ff4137c66ebce098e8c76660c6635027f3c6a34f::fixed_point32_empower::add(v1, 0x7a2b7bd2ae94b09560fb22b9ff4137c66ebce098e8c76660c6635027f3c6a34f::fixed_point32_empower::mul(0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::value_calculator::usd_value(0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::price::get_price(arg3, v3, arg4), 0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::obligation::collateral(arg0, v3), 0x7796b84742df90f7f700f10cb0d333aa95572b05c6daa556ee10597333069189::coin_decimals_registry::decimals(arg2, v3)), 0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::risk_model::liq_factor(0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::market::risk_model(arg1, v3))));
            v2 = v2 + 1;
        };
        v1
    }

    // decompiled from Move bytecode v6
}

