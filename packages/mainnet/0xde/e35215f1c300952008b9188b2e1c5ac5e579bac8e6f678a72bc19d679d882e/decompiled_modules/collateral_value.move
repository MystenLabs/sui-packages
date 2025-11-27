module 0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::collateral_value {
    public fun collaterals_value_usd_for_borrow(arg0: &0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::obligation::Obligation, arg1: &0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::market::Market, arg2: &0xed4cd0afbc14d8961499a2523961e371d72b6a12abdd4a0da2d39cd1ca441472::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x58908fcf6fe6711a482ab9dc4000d5c9f2ab753c34298843c2a96a534f7fae1d::x_oracle::XOracle, arg4: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::obligation::collateral_types(arg0);
        let v1 = 0x8a0d9d6a55c999c37f153a7e282ca4438d00e411bd5b92ef0fad87391c78c08d::fixed_point32_empower::zero();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&v0)) {
            let v3 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v0, v2);
            v1 = 0x8a0d9d6a55c999c37f153a7e282ca4438d00e411bd5b92ef0fad87391c78c08d::fixed_point32_empower::add(v1, 0x8a0d9d6a55c999c37f153a7e282ca4438d00e411bd5b92ef0fad87391c78c08d::fixed_point32_empower::mul(0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::value_calculator::usd_value(0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::price::get_price(arg3, v3, arg4), 0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::obligation::collateral(arg0, v3), 0xed4cd0afbc14d8961499a2523961e371d72b6a12abdd4a0da2d39cd1ca441472::coin_decimals_registry::decimals(arg2, v3)), 0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::risk_model::collateral_factor(0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::market::risk_model(arg1, v3))));
            v2 = v2 + 1;
        };
        v1
    }

    public fun collaterals_value_usd_for_liquidation(arg0: &0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::obligation::Obligation, arg1: &0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::market::Market, arg2: &0xed4cd0afbc14d8961499a2523961e371d72b6a12abdd4a0da2d39cd1ca441472::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x58908fcf6fe6711a482ab9dc4000d5c9f2ab753c34298843c2a96a534f7fae1d::x_oracle::XOracle, arg4: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::obligation::collateral_types(arg0);
        let v1 = 0x8a0d9d6a55c999c37f153a7e282ca4438d00e411bd5b92ef0fad87391c78c08d::fixed_point32_empower::zero();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&v0)) {
            let v3 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v0, v2);
            v1 = 0x8a0d9d6a55c999c37f153a7e282ca4438d00e411bd5b92ef0fad87391c78c08d::fixed_point32_empower::add(v1, 0x8a0d9d6a55c999c37f153a7e282ca4438d00e411bd5b92ef0fad87391c78c08d::fixed_point32_empower::mul(0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::value_calculator::usd_value(0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::price::get_price(arg3, v3, arg4), 0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::obligation::collateral(arg0, v3), 0xed4cd0afbc14d8961499a2523961e371d72b6a12abdd4a0da2d39cd1ca441472::coin_decimals_registry::decimals(arg2, v3)), 0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::risk_model::liq_factor(0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::market::risk_model(arg1, v3))));
            v2 = v2 + 1;
        };
        v1
    }

    // decompiled from Move bytecode v6
}

