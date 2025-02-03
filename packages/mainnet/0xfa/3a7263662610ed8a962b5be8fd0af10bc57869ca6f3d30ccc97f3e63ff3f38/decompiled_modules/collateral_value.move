module 0xfa3a7263662610ed8a962b5be8fd0af10bc57869ca6f3d30ccc97f3e63ff3f38::collateral_value {
    public fun collaterals_value_usd_for_borrow(arg0: &0xfa3a7263662610ed8a962b5be8fd0af10bc57869ca6f3d30ccc97f3e63ff3f38::obligation::Obligation, arg1: &0xfa3a7263662610ed8a962b5be8fd0af10bc57869ca6f3d30ccc97f3e63ff3f38::market::Market, arg2: &0xfa3a7263662610ed8a962b5be8fd0af10bc57869ca6f3d30ccc97f3e63ff3f38::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0xfa3a7263662610ed8a962b5be8fd0af10bc57869ca6f3d30ccc97f3e63ff3f38::x_oracle::XOracle, arg4: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0xfa3a7263662610ed8a962b5be8fd0af10bc57869ca6f3d30ccc97f3e63ff3f38::obligation::collateral_types(arg0);
        let v1 = 0xfa3a7263662610ed8a962b5be8fd0af10bc57869ca6f3d30ccc97f3e63ff3f38::fixed_point32_empower::zero();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&v0)) {
            let v3 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v0, v2);
            v1 = 0xfa3a7263662610ed8a962b5be8fd0af10bc57869ca6f3d30ccc97f3e63ff3f38::fixed_point32_empower::add(v1, 0xfa3a7263662610ed8a962b5be8fd0af10bc57869ca6f3d30ccc97f3e63ff3f38::fixed_point32_empower::mul(0xfa3a7263662610ed8a962b5be8fd0af10bc57869ca6f3d30ccc97f3e63ff3f38::value_calculator::usd_value(0xfa3a7263662610ed8a962b5be8fd0af10bc57869ca6f3d30ccc97f3e63ff3f38::price::get_price(arg3, v3, arg4), 0xfa3a7263662610ed8a962b5be8fd0af10bc57869ca6f3d30ccc97f3e63ff3f38::obligation::collateral(arg0, v3), 0xfa3a7263662610ed8a962b5be8fd0af10bc57869ca6f3d30ccc97f3e63ff3f38::coin_decimals_registry::decimals(arg2, v3)), 0xfa3a7263662610ed8a962b5be8fd0af10bc57869ca6f3d30ccc97f3e63ff3f38::risk_model::collateral_factor(0xfa3a7263662610ed8a962b5be8fd0af10bc57869ca6f3d30ccc97f3e63ff3f38::market::risk_model(arg1, v3))));
            v2 = v2 + 1;
        };
        v1
    }

    public fun collaterals_value_usd_for_liquidation(arg0: &0xfa3a7263662610ed8a962b5be8fd0af10bc57869ca6f3d30ccc97f3e63ff3f38::obligation::Obligation, arg1: &0xfa3a7263662610ed8a962b5be8fd0af10bc57869ca6f3d30ccc97f3e63ff3f38::market::Market, arg2: &0xfa3a7263662610ed8a962b5be8fd0af10bc57869ca6f3d30ccc97f3e63ff3f38::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0xfa3a7263662610ed8a962b5be8fd0af10bc57869ca6f3d30ccc97f3e63ff3f38::x_oracle::XOracle, arg4: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0xfa3a7263662610ed8a962b5be8fd0af10bc57869ca6f3d30ccc97f3e63ff3f38::obligation::collateral_types(arg0);
        let v1 = 0xfa3a7263662610ed8a962b5be8fd0af10bc57869ca6f3d30ccc97f3e63ff3f38::fixed_point32_empower::zero();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&v0)) {
            let v3 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v0, v2);
            v1 = 0xfa3a7263662610ed8a962b5be8fd0af10bc57869ca6f3d30ccc97f3e63ff3f38::fixed_point32_empower::add(v1, 0xfa3a7263662610ed8a962b5be8fd0af10bc57869ca6f3d30ccc97f3e63ff3f38::fixed_point32_empower::mul(0xfa3a7263662610ed8a962b5be8fd0af10bc57869ca6f3d30ccc97f3e63ff3f38::value_calculator::usd_value(0xfa3a7263662610ed8a962b5be8fd0af10bc57869ca6f3d30ccc97f3e63ff3f38::price::get_price(arg3, v3, arg4), 0xfa3a7263662610ed8a962b5be8fd0af10bc57869ca6f3d30ccc97f3e63ff3f38::obligation::collateral(arg0, v3), 0xfa3a7263662610ed8a962b5be8fd0af10bc57869ca6f3d30ccc97f3e63ff3f38::coin_decimals_registry::decimals(arg2, v3)), 0xfa3a7263662610ed8a962b5be8fd0af10bc57869ca6f3d30ccc97f3e63ff3f38::risk_model::liq_factor(0xfa3a7263662610ed8a962b5be8fd0af10bc57869ca6f3d30ccc97f3e63ff3f38::market::risk_model(arg1, v3))));
            v2 = v2 + 1;
        };
        v1
    }

    // decompiled from Move bytecode v6
}

