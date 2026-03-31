module 0x5689c2dec9f0434ac283ee9f5fc84f6889a83caedd3507d2ba14b4d1a57117a2::debt_value {
    public fun debts_value_usd(arg0: &0x5689c2dec9f0434ac283ee9f5fc84f6889a83caedd3507d2ba14b4d1a57117a2::obligation::Obligation, arg1: &0xa6e55b3e7942faf5e3399233f3b0aa03042e01bf1f278e58c130ca824274942f::coin_decimals_registry::CoinDecimalsRegistry, arg2: &0xcde8e9f40019620c316c66627733237292e11f33ff2d0bffb1d4c2b3fed1646e::x_oracle::XOracle, arg3: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0x5689c2dec9f0434ac283ee9f5fc84f6889a83caedd3507d2ba14b4d1a57117a2::obligation::debt_types(arg0);
        let v1 = 0xda89b111cc86b01f38acf4b68987e400a7019c743f82b2490fe1cb66dac5205a::fixed_point32_empower::zero();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&v0)) {
            let v3 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v0, v2);
            let (v4, _, _) = 0x5689c2dec9f0434ac283ee9f5fc84f6889a83caedd3507d2ba14b4d1a57117a2::obligation::debt(arg0, v3);
            v1 = 0xda89b111cc86b01f38acf4b68987e400a7019c743f82b2490fe1cb66dac5205a::fixed_point32_empower::add(v1, 0x5689c2dec9f0434ac283ee9f5fc84f6889a83caedd3507d2ba14b4d1a57117a2::value_calculator::usd_value(0x5689c2dec9f0434ac283ee9f5fc84f6889a83caedd3507d2ba14b4d1a57117a2::price::get_price(arg2, v3, arg3), v4, 0xa6e55b3e7942faf5e3399233f3b0aa03042e01bf1f278e58c130ca824274942f::coin_decimals_registry::decimals(arg1, v3)));
            v2 = v2 + 1;
        };
        v1
    }

    // decompiled from Move bytecode v6
}

