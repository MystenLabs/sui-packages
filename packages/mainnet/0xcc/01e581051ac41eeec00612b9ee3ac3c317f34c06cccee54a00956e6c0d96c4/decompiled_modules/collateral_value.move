module 0xcc01e581051ac41eeec00612b9ee3ac3c317f34c06cccee54a00956e6c0d96c4::collateral_value {
    public fun collaterals_value_usd_for_borrow(arg0: &0xcc01e581051ac41eeec00612b9ee3ac3c317f34c06cccee54a00956e6c0d96c4::obligation::Obligation, arg1: &0xcc01e581051ac41eeec00612b9ee3ac3c317f34c06cccee54a00956e6c0d96c4::market::Market, arg2: &0x46f8c31ef54ad3678fae562c896eeb303dd4fd58509f2393c9e3bdc7b8987925::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x8e8dd2cd5338ffdd6a1c2315162aae1d3685fbf0c164e13bb59edfdcbf47f0ef::x_oracle::XOracle, arg4: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0xcc01e581051ac41eeec00612b9ee3ac3c317f34c06cccee54a00956e6c0d96c4::obligation::collateral_types(arg0);
        let v1 = 0xf8dff55846654f62d2e2f2e08a28367bb80c6f91902ed58aacc100ba54279c3c::fixed_point32_empower::zero();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&v0)) {
            let v3 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v0, v2);
            v1 = 0xf8dff55846654f62d2e2f2e08a28367bb80c6f91902ed58aacc100ba54279c3c::fixed_point32_empower::add(v1, 0xf8dff55846654f62d2e2f2e08a28367bb80c6f91902ed58aacc100ba54279c3c::fixed_point32_empower::mul(0xcc01e581051ac41eeec00612b9ee3ac3c317f34c06cccee54a00956e6c0d96c4::value_calculator::usd_value(0xcc01e581051ac41eeec00612b9ee3ac3c317f34c06cccee54a00956e6c0d96c4::price::get_price(arg3, v3, arg4), 0xcc01e581051ac41eeec00612b9ee3ac3c317f34c06cccee54a00956e6c0d96c4::obligation::collateral(arg0, v3), 0x46f8c31ef54ad3678fae562c896eeb303dd4fd58509f2393c9e3bdc7b8987925::coin_decimals_registry::decimals(arg2, v3)), 0xcc01e581051ac41eeec00612b9ee3ac3c317f34c06cccee54a00956e6c0d96c4::risk_model::collateral_factor(0xcc01e581051ac41eeec00612b9ee3ac3c317f34c06cccee54a00956e6c0d96c4::market::risk_model(arg1, v3))));
            v2 = v2 + 1;
        };
        v1
    }

    public fun collaterals_value_usd_for_liquidation(arg0: &0xcc01e581051ac41eeec00612b9ee3ac3c317f34c06cccee54a00956e6c0d96c4::obligation::Obligation, arg1: &0xcc01e581051ac41eeec00612b9ee3ac3c317f34c06cccee54a00956e6c0d96c4::market::Market, arg2: &0x46f8c31ef54ad3678fae562c896eeb303dd4fd58509f2393c9e3bdc7b8987925::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x8e8dd2cd5338ffdd6a1c2315162aae1d3685fbf0c164e13bb59edfdcbf47f0ef::x_oracle::XOracle, arg4: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0xcc01e581051ac41eeec00612b9ee3ac3c317f34c06cccee54a00956e6c0d96c4::obligation::collateral_types(arg0);
        let v1 = 0xf8dff55846654f62d2e2f2e08a28367bb80c6f91902ed58aacc100ba54279c3c::fixed_point32_empower::zero();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&v0)) {
            let v3 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v0, v2);
            v1 = 0xf8dff55846654f62d2e2f2e08a28367bb80c6f91902ed58aacc100ba54279c3c::fixed_point32_empower::add(v1, 0xf8dff55846654f62d2e2f2e08a28367bb80c6f91902ed58aacc100ba54279c3c::fixed_point32_empower::mul(0xcc01e581051ac41eeec00612b9ee3ac3c317f34c06cccee54a00956e6c0d96c4::value_calculator::usd_value(0xcc01e581051ac41eeec00612b9ee3ac3c317f34c06cccee54a00956e6c0d96c4::price::get_price(arg3, v3, arg4), 0xcc01e581051ac41eeec00612b9ee3ac3c317f34c06cccee54a00956e6c0d96c4::obligation::collateral(arg0, v3), 0x46f8c31ef54ad3678fae562c896eeb303dd4fd58509f2393c9e3bdc7b8987925::coin_decimals_registry::decimals(arg2, v3)), 0xcc01e581051ac41eeec00612b9ee3ac3c317f34c06cccee54a00956e6c0d96c4::risk_model::liq_factor(0xcc01e581051ac41eeec00612b9ee3ac3c317f34c06cccee54a00956e6c0d96c4::market::risk_model(arg1, v3))));
            v2 = v2 + 1;
        };
        v1
    }

    // decompiled from Move bytecode v6
}

