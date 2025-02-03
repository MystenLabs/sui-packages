module 0x6c23585e940a989588432509107e98bae06dbca4e333f26d0635d401b3c7c76d::debt_value {
    public fun debts_value_usd(arg0: &0x6c23585e940a989588432509107e98bae06dbca4e333f26d0635d401b3c7c76d::obligation::Obligation, arg1: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg2: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg3: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0x6c23585e940a989588432509107e98bae06dbca4e333f26d0635d401b3c7c76d::obligation::debt_types(arg0);
        let v1 = 0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::zero();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&v0)) {
            let v3 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v0, v2);
            let (v4, _) = 0x6c23585e940a989588432509107e98bae06dbca4e333f26d0635d401b3c7c76d::obligation::debt(arg0, v3);
            v1 = 0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::add(v1, 0x6c23585e940a989588432509107e98bae06dbca4e333f26d0635d401b3c7c76d::value_calculator::usd_value(0x6c23585e940a989588432509107e98bae06dbca4e333f26d0635d401b3c7c76d::price::get_price(arg2, v3, arg3), v4, 0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::decimals(arg1, v3)));
            v2 = v2 + 1;
        };
        v1
    }

    public fun debts_value_usd_with_weight(arg0: &0x6c23585e940a989588432509107e98bae06dbca4e333f26d0635d401b3c7c76d::obligation::Obligation, arg1: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg2: &0x6c23585e940a989588432509107e98bae06dbca4e333f26d0635d401b3c7c76d::market::Market, arg3: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg4: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0x6c23585e940a989588432509107e98bae06dbca4e333f26d0635d401b3c7c76d::obligation::debt_types(arg0);
        let v1 = 0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::zero();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&v0)) {
            let v3 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v0, v2);
            let (v4, _) = 0x6c23585e940a989588432509107e98bae06dbca4e333f26d0635d401b3c7c76d::obligation::debt(arg0, v3);
            v1 = 0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::add(v1, 0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::mul(0x6c23585e940a989588432509107e98bae06dbca4e333f26d0635d401b3c7c76d::value_calculator::usd_value(0x6c23585e940a989588432509107e98bae06dbca4e333f26d0635d401b3c7c76d::price::get_price(arg3, v3, arg4), v4, 0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::decimals(arg1, v3)), 0x6c23585e940a989588432509107e98bae06dbca4e333f26d0635d401b3c7c76d::interest_model::borrow_weight(0x6c23585e940a989588432509107e98bae06dbca4e333f26d0635d401b3c7c76d::market::interest_model(arg2, v3))));
            v2 = v2 + 1;
        };
        v1
    }

    // decompiled from Move bytecode v6
}

