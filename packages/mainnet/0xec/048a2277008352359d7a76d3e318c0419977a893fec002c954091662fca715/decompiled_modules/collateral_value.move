module 0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::collateral_value {
    public fun collaterals_value_usd_for_borrow(arg0: &0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::obligation::Obligation, arg1: &0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::market::Market, arg2: &0xd68eb3aafa85228a532500ca1ca45af097cb3b941dbdf297e68b1f01e0cdd95e::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0xcd9bf99ee89711edd5084fbd67aee0865b866f0bb3262701ec487cd45b0d3041::x_oracle::XOracle, arg4: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::obligation::collateral_types(arg0);
        let v1 = 0x9c564002970ce40370b0c1a8328d2e91924dab43ca2cb483af67aaf0f7cbe44e::fixed_point32_empower::zero();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&v0)) {
            let v3 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v0, v2);
            v1 = 0x9c564002970ce40370b0c1a8328d2e91924dab43ca2cb483af67aaf0f7cbe44e::fixed_point32_empower::add(v1, 0x9c564002970ce40370b0c1a8328d2e91924dab43ca2cb483af67aaf0f7cbe44e::fixed_point32_empower::mul(0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::value_calculator::usd_value(0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::price::get_price(arg3, v3, arg4), 0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::obligation::collateral(arg0, v3), 0xd68eb3aafa85228a532500ca1ca45af097cb3b941dbdf297e68b1f01e0cdd95e::coin_decimals_registry::decimals(arg2, v3)), 0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::risk_model::collateral_factor(0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::market::risk_model(arg1, v3))));
            v2 = v2 + 1;
        };
        v1
    }

    public fun collaterals_value_usd_for_liquidation(arg0: &0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::obligation::Obligation, arg1: &0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::market::Market, arg2: &0xd68eb3aafa85228a532500ca1ca45af097cb3b941dbdf297e68b1f01e0cdd95e::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0xcd9bf99ee89711edd5084fbd67aee0865b866f0bb3262701ec487cd45b0d3041::x_oracle::XOracle, arg4: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::obligation::collateral_types(arg0);
        let v1 = 0x9c564002970ce40370b0c1a8328d2e91924dab43ca2cb483af67aaf0f7cbe44e::fixed_point32_empower::zero();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&v0)) {
            let v3 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v0, v2);
            v1 = 0x9c564002970ce40370b0c1a8328d2e91924dab43ca2cb483af67aaf0f7cbe44e::fixed_point32_empower::add(v1, 0x9c564002970ce40370b0c1a8328d2e91924dab43ca2cb483af67aaf0f7cbe44e::fixed_point32_empower::mul(0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::value_calculator::usd_value(0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::price::get_price(arg3, v3, arg4), 0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::obligation::collateral(arg0, v3), 0xd68eb3aafa85228a532500ca1ca45af097cb3b941dbdf297e68b1f01e0cdd95e::coin_decimals_registry::decimals(arg2, v3)), 0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::risk_model::liq_factor(0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::market::risk_model(arg1, v3))));
            v2 = v2 + 1;
        };
        v1
    }

    // decompiled from Move bytecode v6
}

