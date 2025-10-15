module 0x58a4fdbdb45486de7309ebf27659a7547cc6b2cf797cbbf3a4c9fc92c518c356::collateral_value {
    public fun collaterals_value_usd_for_borrow(arg0: &0x58a4fdbdb45486de7309ebf27659a7547cc6b2cf797cbbf3a4c9fc92c518c356::obligation::Obligation, arg1: &0x58a4fdbdb45486de7309ebf27659a7547cc6b2cf797cbbf3a4c9fc92c518c356::market::Market, arg2: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0xbece74970dc5b30686a3297b1c3ff1c8fb66c49d1b5a03ab9ce5614a42737f0a::x_oracle::XOracle, arg4: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0x58a4fdbdb45486de7309ebf27659a7547cc6b2cf797cbbf3a4c9fc92c518c356::obligation::collateral_types(arg0);
        let v1 = 0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::zero();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&v0)) {
            let v3 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v0, v2);
            v1 = 0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::add(v1, 0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::mul(0x58a4fdbdb45486de7309ebf27659a7547cc6b2cf797cbbf3a4c9fc92c518c356::value_calculator::usd_value(0x58a4fdbdb45486de7309ebf27659a7547cc6b2cf797cbbf3a4c9fc92c518c356::price::get_price(arg3, v3, arg4), 0x58a4fdbdb45486de7309ebf27659a7547cc6b2cf797cbbf3a4c9fc92c518c356::obligation::collateral(arg0, v3), 0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::decimals(arg2, v3)), 0x58a4fdbdb45486de7309ebf27659a7547cc6b2cf797cbbf3a4c9fc92c518c356::risk_model::collateral_factor(0x58a4fdbdb45486de7309ebf27659a7547cc6b2cf797cbbf3a4c9fc92c518c356::market::risk_model(arg1, v3))));
            v2 = v2 + 1;
        };
        v1
    }

    public fun collaterals_value_usd_for_liquidation(arg0: &0x58a4fdbdb45486de7309ebf27659a7547cc6b2cf797cbbf3a4c9fc92c518c356::obligation::Obligation, arg1: &0x58a4fdbdb45486de7309ebf27659a7547cc6b2cf797cbbf3a4c9fc92c518c356::market::Market, arg2: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0xbece74970dc5b30686a3297b1c3ff1c8fb66c49d1b5a03ab9ce5614a42737f0a::x_oracle::XOracle, arg4: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0x58a4fdbdb45486de7309ebf27659a7547cc6b2cf797cbbf3a4c9fc92c518c356::obligation::collateral_types(arg0);
        let v1 = 0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::zero();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&v0)) {
            let v3 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v0, v2);
            v1 = 0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::add(v1, 0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::mul(0x58a4fdbdb45486de7309ebf27659a7547cc6b2cf797cbbf3a4c9fc92c518c356::value_calculator::usd_value(0x58a4fdbdb45486de7309ebf27659a7547cc6b2cf797cbbf3a4c9fc92c518c356::price::get_price(arg3, v3, arg4), 0x58a4fdbdb45486de7309ebf27659a7547cc6b2cf797cbbf3a4c9fc92c518c356::obligation::collateral(arg0, v3), 0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::decimals(arg2, v3)), 0x58a4fdbdb45486de7309ebf27659a7547cc6b2cf797cbbf3a4c9fc92c518c356::risk_model::liq_factor(0x58a4fdbdb45486de7309ebf27659a7547cc6b2cf797cbbf3a4c9fc92c518c356::market::risk_model(arg1, v3))));
            v2 = v2 + 1;
        };
        v1
    }

    // decompiled from Move bytecode v6
}

