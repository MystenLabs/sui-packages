module 0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::debt_value {
    public fun debts_value_usd(arg0: &0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::obligation::Obligation, arg1: &0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::coin_decimals_registry::CoinDecimalsRegistry, arg2: &0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::x_oracle::XOracle, arg3: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::obligation::debt_types(arg0);
        let v1 = 0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::fixed_point32_empower::zero();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&v0)) {
            let v3 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v0, v2);
            let (v4, _) = 0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::obligation::debt(arg0, v3);
            v1 = 0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::fixed_point32_empower::add(v1, 0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::value_calculator::usd_value(0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::price::get_price(arg2, v3, arg3), v4, 0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::coin_decimals_registry::decimals(arg1, v3)));
            v2 = v2 + 1;
        };
        v1
    }

    public fun debts_value_usd_with_weight(arg0: &0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::obligation::Obligation, arg1: &0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::coin_decimals_registry::CoinDecimalsRegistry, arg2: &0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::market::Market, arg3: &0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::x_oracle::XOracle, arg4: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::obligation::debt_types(arg0);
        let v1 = 0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::fixed_point32_empower::zero();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&v0)) {
            let v3 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v0, v2);
            let (v4, _) = 0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::obligation::debt(arg0, v3);
            v1 = 0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::fixed_point32_empower::add(v1, 0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::fixed_point32_empower::mul(0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::value_calculator::usd_value(0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::price::get_price(arg3, v3, arg4), v4, 0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::coin_decimals_registry::decimals(arg1, v3)), 0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::interest_model::borrow_weight(0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::market::interest_model(arg2, v3))));
            v2 = v2 + 1;
        };
        v1
    }

    // decompiled from Move bytecode v6
}

