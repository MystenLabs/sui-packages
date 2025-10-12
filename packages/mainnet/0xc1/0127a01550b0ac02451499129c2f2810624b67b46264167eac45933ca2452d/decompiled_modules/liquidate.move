module 0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::liquidate {
    struct LiquidateEvent has copy, drop {
        liquidator: address,
        market: 0x1::type_name::TypeName,
        obligation: 0x2::object::ID,
        debt_type: 0x1::type_name::TypeName,
        collateral_type: 0x1::type_name::TypeName,
        collateral_price: 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::Decimal,
        debt_price: 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::Decimal,
        seized_ctoken_amount: u64,
        seized_collateral_amount: u64,
        repay_amount: u64,
        timestamp: u64,
    }

    public fun liquidate<T0, T1, T2>(arg0: 0x2::object::ID, arg1: &mut 0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::market::Market<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &0xcfa25712c883ea080ae7cbd067998a134eee2e39cfbcbc4b6b29674117a021ee::coin_decimals_registry::CoinDecimalsRegistry, arg4: &0x64442484ac47ad2547a37432b8bb393b90f5db7e167a20f649f90386a7e23e80::x_oracle::XOracle, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::market::ensure_version_matches<T0>(arg1);
        assert!(!0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::market::has_circuit_break_triggered<T0>(arg1), 0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::error::market_under_circuit_break());
        let v0 = 0x2::clock::timestamp_ms(arg5) / 1000;
        let (v1, v2) = 0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::market::handle_liquidation<T0, T1, T2>(arg1, arg0, arg2, arg3, arg4, arg5, v0, arg6);
        let v3 = v1;
        let v4 = LiquidateEvent{
            liquidator               : 0x2::tx_context::sender(arg6),
            market                   : 0x1::type_name::get<T0>(),
            obligation               : arg0,
            debt_type                : 0x1::type_name::get<T1>(),
            collateral_type          : 0x1::type_name::get<T2>(),
            collateral_price         : 0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::value::get_price(arg4, 0x1::type_name::get<T2>(), arg5),
            debt_price               : 0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::value::get_price(arg4, 0x1::type_name::get<T1>(), arg5),
            seized_ctoken_amount     : v2,
            seized_collateral_amount : 0x2::coin::value<T2>(&v3),
            repay_amount             : 0x2::coin::value<T1>(&arg2),
            timestamp                : v0,
        };
        0x2::event::emit<LiquidateEvent>(v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v3, 0x2::tx_context::sender(arg6));
    }

    // decompiled from Move bytecode v6
}

