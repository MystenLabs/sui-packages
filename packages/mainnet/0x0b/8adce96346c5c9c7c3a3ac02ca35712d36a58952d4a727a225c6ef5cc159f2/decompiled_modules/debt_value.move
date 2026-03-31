module 0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::debt_value {
    public fun debts_value_usd(arg0: &0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::obligation::Obligation, arg1: &0x61f02204c9c3f56662b27ce7a29e935c2bce1917f51188f2a8aed5552505647b::coin_decimals_registry::CoinDecimalsRegistry, arg2: &0x39a8c5852036a052d196973795d48537f71bbb280616c878d7953cc1f98a79f2::x_oracle::XOracle, arg3: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::obligation::debt_types(arg0);
        let v1 = 0x826f5bc822e65e0cd12528ea725e16c9752b5fa94c66e20c6732d7a866c1781a::fixed_point32_empower::zero();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&v0)) {
            let v3 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v0, v2);
            let (v4, _, _) = 0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::obligation::debt(arg0, v3);
            v1 = 0x826f5bc822e65e0cd12528ea725e16c9752b5fa94c66e20c6732d7a866c1781a::fixed_point32_empower::add(v1, 0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::value_calculator::usd_value(0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::price::get_price(arg2, v3, arg3), v4, 0x61f02204c9c3f56662b27ce7a29e935c2bce1917f51188f2a8aed5552505647b::coin_decimals_registry::decimals(arg1, v3)));
            v2 = v2 + 1;
        };
        v1
    }

    // decompiled from Move bytecode v6
}

