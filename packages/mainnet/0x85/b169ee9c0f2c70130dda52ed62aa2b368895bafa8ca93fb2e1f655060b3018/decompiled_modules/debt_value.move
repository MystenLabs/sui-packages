module 0x85b169ee9c0f2c70130dda52ed62aa2b368895bafa8ca93fb2e1f655060b3018::debt_value {
    public fun debts_value_usd(arg0: &0x85b169ee9c0f2c70130dda52ed62aa2b368895bafa8ca93fb2e1f655060b3018::obligation::Obligation, arg1: &0x8a9d1a0a19089903ef423a2ee816d1cb386326a949dc23ddc99707094dd38ba7::coin_decimals_registry::CoinDecimalsRegistry, arg2: &0x6790ab53e30ff851d7199bc50243b229718daa0443b41bd663253bdc6624811a::x_oracle::XOracle, arg3: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0x85b169ee9c0f2c70130dda52ed62aa2b368895bafa8ca93fb2e1f655060b3018::obligation::debt_types(arg0);
        let v1 = 0xe427ee0ffc74da7fc4f24e3cf1c2f087207226c1538c9badfa502b1d44a6351e::fixed_point32_empower::zero();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&v0)) {
            let v3 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v0, v2);
            let (v4, _, _) = 0x85b169ee9c0f2c70130dda52ed62aa2b368895bafa8ca93fb2e1f655060b3018::obligation::debt(arg0, v3);
            v1 = 0xe427ee0ffc74da7fc4f24e3cf1c2f087207226c1538c9badfa502b1d44a6351e::fixed_point32_empower::add(v1, 0x85b169ee9c0f2c70130dda52ed62aa2b368895bafa8ca93fb2e1f655060b3018::value_calculator::usd_value(0x85b169ee9c0f2c70130dda52ed62aa2b368895bafa8ca93fb2e1f655060b3018::price::get_price(arg2, v3, arg3), v4, 0x8a9d1a0a19089903ef423a2ee816d1cb386326a949dc23ddc99707094dd38ba7::coin_decimals_registry::decimals(arg1, v3)));
            v2 = v2 + 1;
        };
        v1
    }

    // decompiled from Move bytecode v6
}

