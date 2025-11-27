module 0x8c1f8b6ef6c172bf621b72d7e8641dae1d0e2fffceee8c762b7e3ed8a1fbe438::collateral_value {
    public fun collaterals_value_usd_for_borrow(arg0: &0x8c1f8b6ef6c172bf621b72d7e8641dae1d0e2fffceee8c762b7e3ed8a1fbe438::obligation::Obligation, arg1: &0x8c1f8b6ef6c172bf621b72d7e8641dae1d0e2fffceee8c762b7e3ed8a1fbe438::market::Market, arg2: &0xc06e61fa92a4cf89151c4bf1be7db533419f6b14a1c4a155a6b700d0fc9524e7::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x75d76cf4afd63e98f35c94aa28ae78ec4ddf13f4a878c6ef4aeb98e9b580b3d5::x_oracle::XOracle, arg4: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0x8c1f8b6ef6c172bf621b72d7e8641dae1d0e2fffceee8c762b7e3ed8a1fbe438::obligation::collateral_types(arg0);
        let v1 = 0x65b7b808b75dbbe391abe0188e973975192f678cfdb97056ed3d33b033a8a342::fixed_point32_empower::zero();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&v0)) {
            let v3 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v0, v2);
            v1 = 0x65b7b808b75dbbe391abe0188e973975192f678cfdb97056ed3d33b033a8a342::fixed_point32_empower::add(v1, 0x65b7b808b75dbbe391abe0188e973975192f678cfdb97056ed3d33b033a8a342::fixed_point32_empower::mul(0x8c1f8b6ef6c172bf621b72d7e8641dae1d0e2fffceee8c762b7e3ed8a1fbe438::value_calculator::usd_value(0x8c1f8b6ef6c172bf621b72d7e8641dae1d0e2fffceee8c762b7e3ed8a1fbe438::price::get_price(arg3, v3, arg4), 0x8c1f8b6ef6c172bf621b72d7e8641dae1d0e2fffceee8c762b7e3ed8a1fbe438::obligation::collateral(arg0, v3), 0xc06e61fa92a4cf89151c4bf1be7db533419f6b14a1c4a155a6b700d0fc9524e7::coin_decimals_registry::decimals(arg2, v3)), 0x8c1f8b6ef6c172bf621b72d7e8641dae1d0e2fffceee8c762b7e3ed8a1fbe438::risk_model::collateral_factor(0x8c1f8b6ef6c172bf621b72d7e8641dae1d0e2fffceee8c762b7e3ed8a1fbe438::market::risk_model(arg1, v3))));
            v2 = v2 + 1;
        };
        v1
    }

    public fun collaterals_value_usd_for_liquidation(arg0: &0x8c1f8b6ef6c172bf621b72d7e8641dae1d0e2fffceee8c762b7e3ed8a1fbe438::obligation::Obligation, arg1: &0x8c1f8b6ef6c172bf621b72d7e8641dae1d0e2fffceee8c762b7e3ed8a1fbe438::market::Market, arg2: &0xc06e61fa92a4cf89151c4bf1be7db533419f6b14a1c4a155a6b700d0fc9524e7::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x75d76cf4afd63e98f35c94aa28ae78ec4ddf13f4a878c6ef4aeb98e9b580b3d5::x_oracle::XOracle, arg4: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0x8c1f8b6ef6c172bf621b72d7e8641dae1d0e2fffceee8c762b7e3ed8a1fbe438::obligation::collateral_types(arg0);
        let v1 = 0x65b7b808b75dbbe391abe0188e973975192f678cfdb97056ed3d33b033a8a342::fixed_point32_empower::zero();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&v0)) {
            let v3 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v0, v2);
            v1 = 0x65b7b808b75dbbe391abe0188e973975192f678cfdb97056ed3d33b033a8a342::fixed_point32_empower::add(v1, 0x65b7b808b75dbbe391abe0188e973975192f678cfdb97056ed3d33b033a8a342::fixed_point32_empower::mul(0x8c1f8b6ef6c172bf621b72d7e8641dae1d0e2fffceee8c762b7e3ed8a1fbe438::value_calculator::usd_value(0x8c1f8b6ef6c172bf621b72d7e8641dae1d0e2fffceee8c762b7e3ed8a1fbe438::price::get_price(arg3, v3, arg4), 0x8c1f8b6ef6c172bf621b72d7e8641dae1d0e2fffceee8c762b7e3ed8a1fbe438::obligation::collateral(arg0, v3), 0xc06e61fa92a4cf89151c4bf1be7db533419f6b14a1c4a155a6b700d0fc9524e7::coin_decimals_registry::decimals(arg2, v3)), 0x8c1f8b6ef6c172bf621b72d7e8641dae1d0e2fffceee8c762b7e3ed8a1fbe438::risk_model::liq_factor(0x8c1f8b6ef6c172bf621b72d7e8641dae1d0e2fffceee8c762b7e3ed8a1fbe438::market::risk_model(arg1, v3))));
            v2 = v2 + 1;
        };
        v1
    }

    // decompiled from Move bytecode v6
}

