module 0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::repay {
    struct RepayEvent has copy, drop {
        repayer: address,
        market: 0x1::type_name::TypeName,
        obligation: 0x2::object::ID,
        asset: 0x1::type_name::TypeName,
        amount: u64,
        borrow_index: 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::Decimal,
        refund: u64,
        time: u64,
    }

    public fun repay<T0, T1>(arg0: &0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::obligation::ObligationOwnerCap, arg1: &mut 0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::market::Market<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = repay_coin_refund<T0, T1>(arg0, arg1, arg2, arg3, arg4);
        if (0x2::coin::value<T1>(&v0) == 0) {
            0x2::coin::destroy_zero<T1>(v0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v0, 0x2::tx_context::sender(arg4));
        };
    }

    public fun repay_coin_refund<T0, T1>(arg0: &0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::obligation::ObligationOwnerCap, arg1: &mut 0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::market::Market<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::market::ensure_version_matches<T0>(arg1);
        assert!(!0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::market::has_circuit_break_triggered<T0>(arg1), 0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::error::market_under_circuit_break());
        let v0 = 0x2::clock::timestamp_ms(arg3) / 1000;
        let (v1, v2) = 0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::market::handle_repay<T0, T1>(arg1, 0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::obligation::id(arg0), arg2, v0, arg4);
        let v3 = v1;
        let v4 = RepayEvent{
            repayer      : 0x2::tx_context::sender(arg4),
            market       : 0x1::type_name::get<T0>(),
            obligation   : 0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::obligation::id(arg0),
            asset        : 0x1::type_name::get<T1>(),
            amount       : 0x2::coin::value<T1>(&arg2),
            borrow_index : v2,
            refund       : 0x2::coin::value<T1>(&v3),
            time         : v0,
        };
        0x2::event::emit<RepayEvent>(v4);
        v3
    }

    // decompiled from Move bytecode v6
}

