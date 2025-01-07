module 0xa9cdb9d8e80465c75dcdad061cf1d462a9cf662da071412ca178d579d8df2855::collateral_value {
    public fun collaterals_value_usd_for_borrow(arg0: &0xa9cdb9d8e80465c75dcdad061cf1d462a9cf662da071412ca178d579d8df2855::obligation::Obligation, arg1: &0xa9cdb9d8e80465c75dcdad061cf1d462a9cf662da071412ca178d579d8df2855::market::Market, arg2: &0x71ec9ebe7278265b5e556938f4ec2355244423796875ff6a1a5bc53df97f0ab9::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x3658f5650dd8943ee6de53465a6d1cdc58e015348e8650ff5e69ee8201350a45::x_oracle::XOracle, arg4: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0xa9cdb9d8e80465c75dcdad061cf1d462a9cf662da071412ca178d579d8df2855::obligation::collateral_types(arg0);
        let v1 = 0x9beb7cc33769103b080632ce0487b0906d58cfabbec06107221ecbf60a9f959d::fixed_point32_empower::zero();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&v0)) {
            let v3 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v0, v2);
            v1 = 0x9beb7cc33769103b080632ce0487b0906d58cfabbec06107221ecbf60a9f959d::fixed_point32_empower::add(v1, 0x9beb7cc33769103b080632ce0487b0906d58cfabbec06107221ecbf60a9f959d::fixed_point32_empower::mul(0xa9cdb9d8e80465c75dcdad061cf1d462a9cf662da071412ca178d579d8df2855::value_calculator::usd_value(0xa9cdb9d8e80465c75dcdad061cf1d462a9cf662da071412ca178d579d8df2855::price::get_price(arg3, v3, arg4), 0xa9cdb9d8e80465c75dcdad061cf1d462a9cf662da071412ca178d579d8df2855::obligation::collateral(arg0, v3), 0x71ec9ebe7278265b5e556938f4ec2355244423796875ff6a1a5bc53df97f0ab9::coin_decimals_registry::decimals(arg2, v3)), 0xa9cdb9d8e80465c75dcdad061cf1d462a9cf662da071412ca178d579d8df2855::risk_model::collateral_factor(0xa9cdb9d8e80465c75dcdad061cf1d462a9cf662da071412ca178d579d8df2855::market::risk_model(arg1, v3))));
            v2 = v2 + 1;
        };
        v1
    }

    public fun collaterals_value_usd_for_liquidation(arg0: &0xa9cdb9d8e80465c75dcdad061cf1d462a9cf662da071412ca178d579d8df2855::obligation::Obligation, arg1: &0xa9cdb9d8e80465c75dcdad061cf1d462a9cf662da071412ca178d579d8df2855::market::Market, arg2: &0x71ec9ebe7278265b5e556938f4ec2355244423796875ff6a1a5bc53df97f0ab9::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x3658f5650dd8943ee6de53465a6d1cdc58e015348e8650ff5e69ee8201350a45::x_oracle::XOracle, arg4: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0xa9cdb9d8e80465c75dcdad061cf1d462a9cf662da071412ca178d579d8df2855::obligation::collateral_types(arg0);
        let v1 = 0x9beb7cc33769103b080632ce0487b0906d58cfabbec06107221ecbf60a9f959d::fixed_point32_empower::zero();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&v0)) {
            let v3 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v0, v2);
            v1 = 0x9beb7cc33769103b080632ce0487b0906d58cfabbec06107221ecbf60a9f959d::fixed_point32_empower::add(v1, 0x9beb7cc33769103b080632ce0487b0906d58cfabbec06107221ecbf60a9f959d::fixed_point32_empower::mul(0xa9cdb9d8e80465c75dcdad061cf1d462a9cf662da071412ca178d579d8df2855::value_calculator::usd_value(0xa9cdb9d8e80465c75dcdad061cf1d462a9cf662da071412ca178d579d8df2855::price::get_price(arg3, v3, arg4), 0xa9cdb9d8e80465c75dcdad061cf1d462a9cf662da071412ca178d579d8df2855::obligation::collateral(arg0, v3), 0x71ec9ebe7278265b5e556938f4ec2355244423796875ff6a1a5bc53df97f0ab9::coin_decimals_registry::decimals(arg2, v3)), 0xa9cdb9d8e80465c75dcdad061cf1d462a9cf662da071412ca178d579d8df2855::risk_model::liq_factor(0xa9cdb9d8e80465c75dcdad061cf1d462a9cf662da071412ca178d579d8df2855::market::risk_model(arg1, v3))));
            v2 = v2 + 1;
        };
        v1
    }

    // decompiled from Move bytecode v6
}

