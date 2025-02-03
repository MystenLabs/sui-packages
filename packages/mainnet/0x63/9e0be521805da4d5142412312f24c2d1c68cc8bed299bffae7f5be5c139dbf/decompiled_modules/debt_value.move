module 0x639e0be521805da4d5142412312f24c2d1c68cc8bed299bffae7f5be5c139dbf::debt_value {
    public fun debts_value_usd(arg0: &0x639e0be521805da4d5142412312f24c2d1c68cc8bed299bffae7f5be5c139dbf::obligation::Obligation, arg1: &0x639e0be521805da4d5142412312f24c2d1c68cc8bed299bffae7f5be5c139dbf::coin_decimals_registry::CoinDecimalsRegistry, arg2: &0x639e0be521805da4d5142412312f24c2d1c68cc8bed299bffae7f5be5c139dbf::x_oracle::XOracle, arg3: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0x639e0be521805da4d5142412312f24c2d1c68cc8bed299bffae7f5be5c139dbf::obligation::debt_types(arg0);
        let v1 = 0x639e0be521805da4d5142412312f24c2d1c68cc8bed299bffae7f5be5c139dbf::fixed_point32_empower::zero();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&v0)) {
            let v3 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v0, v2);
            let (v4, _) = 0x639e0be521805da4d5142412312f24c2d1c68cc8bed299bffae7f5be5c139dbf::obligation::debt(arg0, v3);
            v1 = 0x639e0be521805da4d5142412312f24c2d1c68cc8bed299bffae7f5be5c139dbf::fixed_point32_empower::add(v1, 0x639e0be521805da4d5142412312f24c2d1c68cc8bed299bffae7f5be5c139dbf::value_calculator::usd_value(0x639e0be521805da4d5142412312f24c2d1c68cc8bed299bffae7f5be5c139dbf::price::get_price(arg2, v3, arg3), v4, 0x639e0be521805da4d5142412312f24c2d1c68cc8bed299bffae7f5be5c139dbf::coin_decimals_registry::decimals(arg1, v3)));
            v2 = v2 + 1;
        };
        v1
    }

    public fun debts_value_usd_with_weight(arg0: &0x639e0be521805da4d5142412312f24c2d1c68cc8bed299bffae7f5be5c139dbf::obligation::Obligation, arg1: &0x639e0be521805da4d5142412312f24c2d1c68cc8bed299bffae7f5be5c139dbf::coin_decimals_registry::CoinDecimalsRegistry, arg2: &0x639e0be521805da4d5142412312f24c2d1c68cc8bed299bffae7f5be5c139dbf::market::Market, arg3: &0x639e0be521805da4d5142412312f24c2d1c68cc8bed299bffae7f5be5c139dbf::x_oracle::XOracle, arg4: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0x639e0be521805da4d5142412312f24c2d1c68cc8bed299bffae7f5be5c139dbf::obligation::debt_types(arg0);
        let v1 = 0x639e0be521805da4d5142412312f24c2d1c68cc8bed299bffae7f5be5c139dbf::fixed_point32_empower::zero();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&v0)) {
            let v3 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v0, v2);
            let (v4, _) = 0x639e0be521805da4d5142412312f24c2d1c68cc8bed299bffae7f5be5c139dbf::obligation::debt(arg0, v3);
            v1 = 0x639e0be521805da4d5142412312f24c2d1c68cc8bed299bffae7f5be5c139dbf::fixed_point32_empower::add(v1, 0x639e0be521805da4d5142412312f24c2d1c68cc8bed299bffae7f5be5c139dbf::fixed_point32_empower::mul(0x639e0be521805da4d5142412312f24c2d1c68cc8bed299bffae7f5be5c139dbf::value_calculator::usd_value(0x639e0be521805da4d5142412312f24c2d1c68cc8bed299bffae7f5be5c139dbf::price::get_price(arg3, v3, arg4), v4, 0x639e0be521805da4d5142412312f24c2d1c68cc8bed299bffae7f5be5c139dbf::coin_decimals_registry::decimals(arg1, v3)), 0x639e0be521805da4d5142412312f24c2d1c68cc8bed299bffae7f5be5c139dbf::interest_model::borrow_weight(0x639e0be521805da4d5142412312f24c2d1c68cc8bed299bffae7f5be5c139dbf::market::interest_model(arg2, v3))));
            v2 = v2 + 1;
        };
        v1
    }

    // decompiled from Move bytecode v6
}

