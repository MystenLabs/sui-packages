module 0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::collateral_value {
    public fun collaterals_value_usd_for_borrow(arg0: &0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::obligation::Obligation, arg1: &0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::market::Market, arg2: &0x413d4cf3221e98f4096aabcab4edc84b9e66f60f2239e5cdbf6e49ee2916c7e0::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x4f0be0e70afb81670fd135b4201270997f9a32a2dccddaa3925825fe5a8b4c2a::x_oracle::XOracle, arg4: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::obligation::collateral_types(arg0);
        let v1 = 0xbf0ff2c916bccc759793a14cbd121f495f53f6121d8b5fd41c836a8ad8253d7c::fixed_point32_empower::zero();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&v0)) {
            let v3 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v0, v2);
            v1 = 0xbf0ff2c916bccc759793a14cbd121f495f53f6121d8b5fd41c836a8ad8253d7c::fixed_point32_empower::add(v1, 0xbf0ff2c916bccc759793a14cbd121f495f53f6121d8b5fd41c836a8ad8253d7c::fixed_point32_empower::mul(0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::value_calculator::usd_value(0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::price::get_price(arg3, v3, arg4), 0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::obligation::collateral(arg0, v3), 0x413d4cf3221e98f4096aabcab4edc84b9e66f60f2239e5cdbf6e49ee2916c7e0::coin_decimals_registry::decimals(arg2, v3)), 0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::risk_model::collateral_factor(0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::market::risk_model(arg1, v3))));
            v2 = v2 + 1;
        };
        v1
    }

    public fun collaterals_value_usd_for_liquidation(arg0: &0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::obligation::Obligation, arg1: &0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::market::Market, arg2: &0x413d4cf3221e98f4096aabcab4edc84b9e66f60f2239e5cdbf6e49ee2916c7e0::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x4f0be0e70afb81670fd135b4201270997f9a32a2dccddaa3925825fe5a8b4c2a::x_oracle::XOracle, arg4: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::obligation::collateral_types(arg0);
        let v1 = 0xbf0ff2c916bccc759793a14cbd121f495f53f6121d8b5fd41c836a8ad8253d7c::fixed_point32_empower::zero();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&v0)) {
            let v3 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v0, v2);
            v1 = 0xbf0ff2c916bccc759793a14cbd121f495f53f6121d8b5fd41c836a8ad8253d7c::fixed_point32_empower::add(v1, 0xbf0ff2c916bccc759793a14cbd121f495f53f6121d8b5fd41c836a8ad8253d7c::fixed_point32_empower::mul(0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::value_calculator::usd_value(0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::price::get_price(arg3, v3, arg4), 0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::obligation::collateral(arg0, v3), 0x413d4cf3221e98f4096aabcab4edc84b9e66f60f2239e5cdbf6e49ee2916c7e0::coin_decimals_registry::decimals(arg2, v3)), 0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::risk_model::liq_factor(0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::market::risk_model(arg1, v3))));
            v2 = v2 + 1;
        };
        v1
    }

    // decompiled from Move bytecode v6
}

