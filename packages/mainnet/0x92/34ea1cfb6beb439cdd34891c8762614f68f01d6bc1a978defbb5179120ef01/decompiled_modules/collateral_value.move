module 0x9234ea1cfb6beb439cdd34891c8762614f68f01d6bc1a978defbb5179120ef01::collateral_value {
    public fun collaterals_value_usd_for_borrow(arg0: &0x9234ea1cfb6beb439cdd34891c8762614f68f01d6bc1a978defbb5179120ef01::obligation::Obligation, arg1: &0x9234ea1cfb6beb439cdd34891c8762614f68f01d6bc1a978defbb5179120ef01::market::Market, arg2: &0x9234ea1cfb6beb439cdd34891c8762614f68f01d6bc1a978defbb5179120ef01::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x9234ea1cfb6beb439cdd34891c8762614f68f01d6bc1a978defbb5179120ef01::x_oracle::XOracle, arg4: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0x9234ea1cfb6beb439cdd34891c8762614f68f01d6bc1a978defbb5179120ef01::obligation::collateral_types(arg0);
        let v1 = 0x9234ea1cfb6beb439cdd34891c8762614f68f01d6bc1a978defbb5179120ef01::fixed_point32_empower::zero();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&v0)) {
            let v3 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v0, v2);
            v1 = 0x9234ea1cfb6beb439cdd34891c8762614f68f01d6bc1a978defbb5179120ef01::fixed_point32_empower::add(v1, 0x9234ea1cfb6beb439cdd34891c8762614f68f01d6bc1a978defbb5179120ef01::fixed_point32_empower::mul(0x9234ea1cfb6beb439cdd34891c8762614f68f01d6bc1a978defbb5179120ef01::value_calculator::usd_value(0x9234ea1cfb6beb439cdd34891c8762614f68f01d6bc1a978defbb5179120ef01::price::get_price(arg3, v3, arg4), 0x9234ea1cfb6beb439cdd34891c8762614f68f01d6bc1a978defbb5179120ef01::obligation::collateral(arg0, v3), 0x9234ea1cfb6beb439cdd34891c8762614f68f01d6bc1a978defbb5179120ef01::coin_decimals_registry::decimals(arg2, v3)), 0x9234ea1cfb6beb439cdd34891c8762614f68f01d6bc1a978defbb5179120ef01::risk_model::collateral_factor(0x9234ea1cfb6beb439cdd34891c8762614f68f01d6bc1a978defbb5179120ef01::market::risk_model(arg1, v3))));
            v2 = v2 + 1;
        };
        v1
    }

    public fun collaterals_value_usd_for_liquidation(arg0: &0x9234ea1cfb6beb439cdd34891c8762614f68f01d6bc1a978defbb5179120ef01::obligation::Obligation, arg1: &0x9234ea1cfb6beb439cdd34891c8762614f68f01d6bc1a978defbb5179120ef01::market::Market, arg2: &0x9234ea1cfb6beb439cdd34891c8762614f68f01d6bc1a978defbb5179120ef01::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x9234ea1cfb6beb439cdd34891c8762614f68f01d6bc1a978defbb5179120ef01::x_oracle::XOracle, arg4: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0x9234ea1cfb6beb439cdd34891c8762614f68f01d6bc1a978defbb5179120ef01::obligation::collateral_types(arg0);
        let v1 = 0x9234ea1cfb6beb439cdd34891c8762614f68f01d6bc1a978defbb5179120ef01::fixed_point32_empower::zero();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&v0)) {
            let v3 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v0, v2);
            v1 = 0x9234ea1cfb6beb439cdd34891c8762614f68f01d6bc1a978defbb5179120ef01::fixed_point32_empower::add(v1, 0x9234ea1cfb6beb439cdd34891c8762614f68f01d6bc1a978defbb5179120ef01::fixed_point32_empower::mul(0x9234ea1cfb6beb439cdd34891c8762614f68f01d6bc1a978defbb5179120ef01::value_calculator::usd_value(0x9234ea1cfb6beb439cdd34891c8762614f68f01d6bc1a978defbb5179120ef01::price::get_price(arg3, v3, arg4), 0x9234ea1cfb6beb439cdd34891c8762614f68f01d6bc1a978defbb5179120ef01::obligation::collateral(arg0, v3), 0x9234ea1cfb6beb439cdd34891c8762614f68f01d6bc1a978defbb5179120ef01::coin_decimals_registry::decimals(arg2, v3)), 0x9234ea1cfb6beb439cdd34891c8762614f68f01d6bc1a978defbb5179120ef01::risk_model::liq_factor(0x9234ea1cfb6beb439cdd34891c8762614f68f01d6bc1a978defbb5179120ef01::market::risk_model(arg1, v3))));
            v2 = v2 + 1;
        };
        v1
    }

    // decompiled from Move bytecode v6
}

