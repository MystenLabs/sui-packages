module 0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::revenue_admin {
    struct TakeRevenueEvent has copy, drop {
        market: 0x2::object::ID,
        amount: u64,
        coin_type: 0x1::type_name::TypeName,
        sender: address,
        timestamp_ms: u64,
    }

    public fun take_revenue<T0, T1>(arg0: &0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::app::AdminCap, arg1: &0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::app::ProtocolApp, arg2: &mut 0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::market::Market<T0>, arg3: u64, arg4: address, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::app::validate_market<T0>(arg1, arg2);
        assert!(arg3 > 0, 0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::error::invalid_params_error());
        assert!(!0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::market::has_circuit_break_triggered<T0>(arg2), 0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::error::market_under_circuit_break());
        let v0 = TakeRevenueEvent{
            market       : 0x2::object::id<0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::market::Market<T0>>(arg2),
            amount       : arg3,
            coin_type    : 0x1::type_name::get<T1>(),
            sender       : 0x2::tx_context::sender(arg6),
            timestamp_ms : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<TakeRevenueEvent>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::market::take_revenue<T0, T1>(arg2, arg3, arg6), arg4);
    }

    // decompiled from Move bytecode v6
}

