module 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::debt_value {
    public fun debts_value_usd(arg0: &0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::obligation::Obligation, arg1: &0x177afe2b7c818730b4980df53cc683be7393d20cada006b02152d92210983a74::coin_decimals_registry::CoinDecimalsRegistry, arg2: &0x7fdc2bc8e78c3e133728c75e54fe5587b868ad59f849d8c7611147cc0394f305::x_oracle::XOracle, arg3: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::obligation::debt_types(arg0);
        let v1 = 0x47aee540b4cf13763b58341097db066dc43dfa0574cd74729b64694f097a4d5d::fixed_point32_empower::zero();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&v0)) {
            let v3 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v0, v2);
            let (v4, _) = 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::obligation::debt(arg0, v3);
            v1 = 0x47aee540b4cf13763b58341097db066dc43dfa0574cd74729b64694f097a4d5d::fixed_point32_empower::add(v1, 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::value_calculator::usd_value(0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::price::get_price(arg2, v3, arg3), v4, 0x177afe2b7c818730b4980df53cc683be7393d20cada006b02152d92210983a74::coin_decimals_registry::decimals(arg1, v3)));
            v2 = v2 + 1;
        };
        v1
    }

    // decompiled from Move bytecode v6
}

