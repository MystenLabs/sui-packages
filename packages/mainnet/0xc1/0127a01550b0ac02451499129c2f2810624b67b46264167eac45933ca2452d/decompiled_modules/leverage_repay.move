module 0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::leverage_repay {
    struct RefundedEvent has copy, drop {
        leverage_owner_cap: 0x2::object::ID,
        amount: u64,
        amount_usd: 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::Decimal,
        coin_type: 0x1::type_name::TypeName,
    }

    public fun complete_leverage<T0, T1>(arg0: &mut 0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::market::Market<T0>, arg1: &mut 0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::leverage_market::LeverageMarket, arg2: &0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::leverage_obligation::LeverageMarketOwnerCap, arg3: 0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::reserve::FlashLoan<T0, T1>, arg4: 0x2::coin::Coin<T1>, arg5: &0x64442484ac47ad2547a37432b8bb393b90f5db7e167a20f649f90386a7e23e80::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &0xcfa25712c883ea080ae7cbd067998a134eee2e39cfbcbc4b6b29674117a021ee::coin_decimals_registry::CoinDecimalsRegistry, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::leverage_market::is_leverate_on_going(arg1), 13906834371911876607);
        0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::leverage_market::mark_leverage_finished(arg1);
        let v0 = 0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::reserve::fee<T0, T1>(&arg3) + 0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::reserve::loan_amount<T0, T1>(&arg3);
        assert!(0x2::coin::value<T1>(&arg4) >= v0, 0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::leverage_error::cannot_repay_flash_loan());
        0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::flash_loan::repay_flash_loan<T0, T1>(arg0, 0x2::coin::split<T1>(&mut arg4, v0, arg8), arg3, arg8);
        0x2::event::emit<RefundedEvent>(new_refunded_event<T1>(0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::leverage_obligation::id(arg2), arg5, arg6, 0x2::coin::value<T1>(&arg4), arg7));
        arg4
    }

    public(friend) fun emit_new_refunded_event<T0>(arg0: 0x2::object::ID, arg1: &0x64442484ac47ad2547a37432b8bb393b90f5db7e167a20f649f90386a7e23e80::x_oracle::XOracle, arg2: &0x2::clock::Clock, arg3: u64, arg4: &0xcfa25712c883ea080ae7cbd067998a134eee2e39cfbcbc4b6b29674117a021ee::coin_decimals_registry::CoinDecimalsRegistry) {
        0x2::event::emit<RefundedEvent>(new_refunded_event<T0>(arg0, arg1, arg2, arg3, arg4));
    }

    fun new_refunded_event<T0>(arg0: 0x2::object::ID, arg1: &0x64442484ac47ad2547a37432b8bb393b90f5db7e167a20f649f90386a7e23e80::x_oracle::XOracle, arg2: &0x2::clock::Clock, arg3: u64, arg4: &0xcfa25712c883ea080ae7cbd067998a134eee2e39cfbcbc4b6b29674117a021ee::coin_decimals_registry::CoinDecimalsRegistry) : RefundedEvent {
        RefundedEvent{
            leverage_owner_cap : arg0,
            amount             : arg3,
            amount_usd         : 0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::leverage_obligation::get_usd_value<T0>(arg1, arg2, arg3, arg4),
            coin_type          : 0x1::type_name::get<T0>(),
        }
    }

    // decompiled from Move bytecode v6
}

