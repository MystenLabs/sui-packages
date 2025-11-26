module 0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::collateral_value {
    public fun collaterals_value_usd_for_borrow(arg0: &0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::obligation::Obligation, arg1: &0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::market::Market, arg2: &0xf02732656b4dc135a20a52ff5495425541d4280c54aa93ef5f8bceecf49b9f9::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x901a0eda69c69f5ed9ccd6e94b01e2a4d3e36c88f0b5c0da90978a2a92979007::x_oracle::XOracle, arg4: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::obligation::collateral_types(arg0);
        let v1 = 0x724ff007e3cb5e2464e94283edecd0c610567d475a980beaa8f404d9c15d3ba7::fixed_point32_empower::zero();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&v0)) {
            let v3 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v0, v2);
            v1 = 0x724ff007e3cb5e2464e94283edecd0c610567d475a980beaa8f404d9c15d3ba7::fixed_point32_empower::add(v1, 0x724ff007e3cb5e2464e94283edecd0c610567d475a980beaa8f404d9c15d3ba7::fixed_point32_empower::mul(0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::value_calculator::usd_value(0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::price::get_price(arg3, v3, arg4), 0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::obligation::collateral(arg0, v3), 0xf02732656b4dc135a20a52ff5495425541d4280c54aa93ef5f8bceecf49b9f9::coin_decimals_registry::decimals(arg2, v3)), 0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::risk_model::collateral_factor(0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::market::risk_model(arg1, v3))));
            v2 = v2 + 1;
        };
        v1
    }

    public fun collaterals_value_usd_for_liquidation(arg0: &0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::obligation::Obligation, arg1: &0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::market::Market, arg2: &0xf02732656b4dc135a20a52ff5495425541d4280c54aa93ef5f8bceecf49b9f9::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x901a0eda69c69f5ed9ccd6e94b01e2a4d3e36c88f0b5c0da90978a2a92979007::x_oracle::XOracle, arg4: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::obligation::collateral_types(arg0);
        let v1 = 0x724ff007e3cb5e2464e94283edecd0c610567d475a980beaa8f404d9c15d3ba7::fixed_point32_empower::zero();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&v0)) {
            let v3 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v0, v2);
            v1 = 0x724ff007e3cb5e2464e94283edecd0c610567d475a980beaa8f404d9c15d3ba7::fixed_point32_empower::add(v1, 0x724ff007e3cb5e2464e94283edecd0c610567d475a980beaa8f404d9c15d3ba7::fixed_point32_empower::mul(0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::value_calculator::usd_value(0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::price::get_price(arg3, v3, arg4), 0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::obligation::collateral(arg0, v3), 0xf02732656b4dc135a20a52ff5495425541d4280c54aa93ef5f8bceecf49b9f9::coin_decimals_registry::decimals(arg2, v3)), 0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::risk_model::liq_factor(0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::market::risk_model(arg1, v3))));
            v2 = v2 + 1;
        };
        v1
    }

    // decompiled from Move bytecode v6
}

