module 0xa0816d57df47db94f0022b4862bed94c0bc57b269f598fccc06ac2bbfe26cf67::debt_value {
    public fun debts_value_usd(arg0: &0xa0816d57df47db94f0022b4862bed94c0bc57b269f598fccc06ac2bbfe26cf67::obligation::Obligation, arg1: &0x2ad4f61ec97424692591625a5ce2c982241ea405e06f4052fc2ab2528dfc6306::coin_decimals_registry::CoinDecimalsRegistry, arg2: &0xc591cdee730dde36263a49ccbfa624d2c031aa81e2b2af1e84dc7488b3f374a5::x_oracle::XOracle, arg3: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0xa0816d57df47db94f0022b4862bed94c0bc57b269f598fccc06ac2bbfe26cf67::obligation::debt_types(arg0);
        let v1 = 0xfc009f0a14a67124d5a4fb2f6a7f29d9de8d90eabbce7bf3540125d0a3975ed::fixed_point32_empower::zero();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&v0)) {
            let v3 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v0, v2);
            let (v4, _, _) = 0xa0816d57df47db94f0022b4862bed94c0bc57b269f598fccc06ac2bbfe26cf67::obligation::debt(arg0, v3);
            v1 = 0xfc009f0a14a67124d5a4fb2f6a7f29d9de8d90eabbce7bf3540125d0a3975ed::fixed_point32_empower::add(v1, 0xa0816d57df47db94f0022b4862bed94c0bc57b269f598fccc06ac2bbfe26cf67::value_calculator::usd_value(0xa0816d57df47db94f0022b4862bed94c0bc57b269f598fccc06ac2bbfe26cf67::price::get_price(arg2, v3, arg3), v4, 0x2ad4f61ec97424692591625a5ce2c982241ea405e06f4052fc2ab2528dfc6306::coin_decimals_registry::decimals(arg1, v3)));
            v2 = v2 + 1;
        };
        v1
    }

    // decompiled from Move bytecode v6
}

