module 0xba1289f1d8476106664b93f5ec4d4b62d3e277f7372cd0ba740f3963c18f01b1::debt_value {
    public fun debts_value_usd(arg0: &0xba1289f1d8476106664b93f5ec4d4b62d3e277f7372cd0ba740f3963c18f01b1::obligation::Obligation, arg1: &0xd2340f9ef1088b9fdc4d02d2628fcca4b4552f71ffdb03049425fc0a3b19ce41::coin_decimals_registry::CoinDecimalsRegistry, arg2: &0x95fd973aea15879e75407f4e4c66a8d1026ad10a25360275a73b0ce44c7b09e8::x_oracle::XOracle, arg3: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0xba1289f1d8476106664b93f5ec4d4b62d3e277f7372cd0ba740f3963c18f01b1::obligation::debt_types(arg0);
        let v1 = 0xdb2f245331502370e5518886b9ef2ea52293df6d1238baa0a25de1341297feb0::fixed_point32_empower::zero();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&v0)) {
            let v3 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v0, v2);
            let (v4, _) = 0xba1289f1d8476106664b93f5ec4d4b62d3e277f7372cd0ba740f3963c18f01b1::obligation::debt(arg0, v3);
            v1 = 0xdb2f245331502370e5518886b9ef2ea52293df6d1238baa0a25de1341297feb0::fixed_point32_empower::add(v1, 0xba1289f1d8476106664b93f5ec4d4b62d3e277f7372cd0ba740f3963c18f01b1::value_calculator::usd_value(0xba1289f1d8476106664b93f5ec4d4b62d3e277f7372cd0ba740f3963c18f01b1::price::get_price(arg2, v3, arg3), v4, 0xd2340f9ef1088b9fdc4d02d2628fcca4b4552f71ffdb03049425fc0a3b19ce41::coin_decimals_registry::decimals(arg1, v3)));
            v2 = v2 + 1;
        };
        v1
    }

    // decompiled from Move bytecode v6
}

