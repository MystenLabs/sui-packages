module 0xf698d3f5fb9051246fcdd7a8491578b545fff87dde9c07356604e8c99f396ccb::collateral_value {
    public fun collaterals_value_usd_for_borrow(arg0: &0xf698d3f5fb9051246fcdd7a8491578b545fff87dde9c07356604e8c99f396ccb::obligation::Obligation, arg1: &0xf698d3f5fb9051246fcdd7a8491578b545fff87dde9c07356604e8c99f396ccb::market::Market, arg2: &0xf698d3f5fb9051246fcdd7a8491578b545fff87dde9c07356604e8c99f396ccb::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0xf698d3f5fb9051246fcdd7a8491578b545fff87dde9c07356604e8c99f396ccb::x_oracle::XOracle, arg4: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0xf698d3f5fb9051246fcdd7a8491578b545fff87dde9c07356604e8c99f396ccb::obligation::collateral_types(arg0);
        let v1 = 0xf698d3f5fb9051246fcdd7a8491578b545fff87dde9c07356604e8c99f396ccb::fixed_point32_empower::zero();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&v0)) {
            let v3 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v0, v2);
            v1 = 0xf698d3f5fb9051246fcdd7a8491578b545fff87dde9c07356604e8c99f396ccb::fixed_point32_empower::add(v1, 0xf698d3f5fb9051246fcdd7a8491578b545fff87dde9c07356604e8c99f396ccb::fixed_point32_empower::mul(0xf698d3f5fb9051246fcdd7a8491578b545fff87dde9c07356604e8c99f396ccb::value_calculator::usd_value(0xf698d3f5fb9051246fcdd7a8491578b545fff87dde9c07356604e8c99f396ccb::price::get_price(arg3, v3, arg4), 0xf698d3f5fb9051246fcdd7a8491578b545fff87dde9c07356604e8c99f396ccb::obligation::collateral(arg0, v3), 0xf698d3f5fb9051246fcdd7a8491578b545fff87dde9c07356604e8c99f396ccb::coin_decimals_registry::decimals(arg2, v3)), 0xf698d3f5fb9051246fcdd7a8491578b545fff87dde9c07356604e8c99f396ccb::risk_model::collateral_factor(0xf698d3f5fb9051246fcdd7a8491578b545fff87dde9c07356604e8c99f396ccb::market::risk_model(arg1, v3))));
            v2 = v2 + 1;
        };
        v1
    }

    public fun collaterals_value_usd_for_liquidation(arg0: &0xf698d3f5fb9051246fcdd7a8491578b545fff87dde9c07356604e8c99f396ccb::obligation::Obligation, arg1: &0xf698d3f5fb9051246fcdd7a8491578b545fff87dde9c07356604e8c99f396ccb::market::Market, arg2: &0xf698d3f5fb9051246fcdd7a8491578b545fff87dde9c07356604e8c99f396ccb::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0xf698d3f5fb9051246fcdd7a8491578b545fff87dde9c07356604e8c99f396ccb::x_oracle::XOracle, arg4: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0xf698d3f5fb9051246fcdd7a8491578b545fff87dde9c07356604e8c99f396ccb::obligation::collateral_types(arg0);
        let v1 = 0xf698d3f5fb9051246fcdd7a8491578b545fff87dde9c07356604e8c99f396ccb::fixed_point32_empower::zero();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&v0)) {
            let v3 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v0, v2);
            v1 = 0xf698d3f5fb9051246fcdd7a8491578b545fff87dde9c07356604e8c99f396ccb::fixed_point32_empower::add(v1, 0xf698d3f5fb9051246fcdd7a8491578b545fff87dde9c07356604e8c99f396ccb::fixed_point32_empower::mul(0xf698d3f5fb9051246fcdd7a8491578b545fff87dde9c07356604e8c99f396ccb::value_calculator::usd_value(0xf698d3f5fb9051246fcdd7a8491578b545fff87dde9c07356604e8c99f396ccb::price::get_price(arg3, v3, arg4), 0xf698d3f5fb9051246fcdd7a8491578b545fff87dde9c07356604e8c99f396ccb::obligation::collateral(arg0, v3), 0xf698d3f5fb9051246fcdd7a8491578b545fff87dde9c07356604e8c99f396ccb::coin_decimals_registry::decimals(arg2, v3)), 0xf698d3f5fb9051246fcdd7a8491578b545fff87dde9c07356604e8c99f396ccb::risk_model::liq_factor(0xf698d3f5fb9051246fcdd7a8491578b545fff87dde9c07356604e8c99f396ccb::market::risk_model(arg1, v3))));
            v2 = v2 + 1;
        };
        v1
    }

    // decompiled from Move bytecode v6
}

