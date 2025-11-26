module 0x7dcc19ef54dc4866df5921dacc872cd341f403a0f6053a35ef834ebc67ab3092::debt_value {
    public fun debts_value_usd(arg0: &0x7dcc19ef54dc4866df5921dacc872cd341f403a0f6053a35ef834ebc67ab3092::obligation::Obligation, arg1: &0x596e3f4cbfceafa0cca766cad1bd9a42ef720732c3fe786f75cc8c70575e31e::coin_decimals_registry::CoinDecimalsRegistry, arg2: &0x66895f6e3a45637db4bf50868d6b522f18f8ab35687517d3bacea4f1a3bae218::x_oracle::XOracle, arg3: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0x7dcc19ef54dc4866df5921dacc872cd341f403a0f6053a35ef834ebc67ab3092::obligation::debt_types(arg0);
        let v1 = 0xfff634b447243fd77f2cb87de5a84dfdce199ae70cb6f40e87a17e9fd24f6dac::fixed_point32_empower::zero();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&v0)) {
            let v3 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v0, v2);
            let (v4, _) = 0x7dcc19ef54dc4866df5921dacc872cd341f403a0f6053a35ef834ebc67ab3092::obligation::debt(arg0, v3);
            v1 = 0xfff634b447243fd77f2cb87de5a84dfdce199ae70cb6f40e87a17e9fd24f6dac::fixed_point32_empower::add(v1, 0x7dcc19ef54dc4866df5921dacc872cd341f403a0f6053a35ef834ebc67ab3092::value_calculator::usd_value(0x7dcc19ef54dc4866df5921dacc872cd341f403a0f6053a35ef834ebc67ab3092::price::get_price(arg2, v3, arg3), v4, 0x596e3f4cbfceafa0cca766cad1bd9a42ef720732c3fe786f75cc8c70575e31e::coin_decimals_registry::decimals(arg1, v3)));
            v2 = v2 + 1;
        };
        v1
    }

    // decompiled from Move bytecode v6
}

