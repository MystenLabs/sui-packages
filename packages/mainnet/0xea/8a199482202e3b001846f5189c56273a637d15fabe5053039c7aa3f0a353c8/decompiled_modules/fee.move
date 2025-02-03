module 0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::fee {
    fun calculate_fee(arg0: &0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::config::FeeConfig, arg1: u64, arg2: 0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::constant::FeeTypes) : u64 {
        arg1 * 0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::constant::match_fee_type_with_bps(arg2, arg0) / 10000
    }

    public(friend) fun pay_fee_1<T0, T1>(arg0: &0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::config::FeeConfig, arg1: &mut 0x2::coin::Coin<T0>, arg2: 0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::constant::FeeTypes, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = calculate_fee(arg0, 0x2::coin::value<T0>(arg1), arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(arg1, v0, arg3), 0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::config::fee_recipient(arg0));
        0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::events_fee::emit_fee_event(0x2::tx_context::sender(arg3), 0x1::type_name::get<T0>(), v0, 0x1::type_name::get<T1>());
    }

    public(friend) fun pay_fee_2<T0, T1, T2>(arg0: &0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::config::FeeConfig, arg1: &mut 0x2::coin::Coin<T0>, arg2: &mut 0x2::coin::Coin<T1>, arg3: 0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::constant::FeeTypes, arg4: &mut 0x2::tx_context::TxContext) {
        pay_fee_1<T0, T2>(arg0, arg1, arg3, arg4);
        pay_fee_1<T1, T2>(arg0, arg2, arg3, arg4);
    }

    public(friend) fun pay_fee_3<T0, T1, T2, T3>(arg0: &0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::config::FeeConfig, arg1: &mut 0x2::coin::Coin<T0>, arg2: &mut 0x2::coin::Coin<T1>, arg3: &mut 0x2::coin::Coin<T2>, arg4: 0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::constant::FeeTypes, arg5: &mut 0x2::tx_context::TxContext) {
        pay_fee_2<T0, T1, T3>(arg0, arg1, arg2, arg4, arg5);
        pay_fee_1<T2, T3>(arg0, arg3, arg4, arg5);
    }

    public(friend) fun pay_fee_4<T0, T1, T2, T3, T4>(arg0: &0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::config::FeeConfig, arg1: &mut 0x2::coin::Coin<T0>, arg2: &mut 0x2::coin::Coin<T1>, arg3: &mut 0x2::coin::Coin<T2>, arg4: &mut 0x2::coin::Coin<T3>, arg5: 0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::constant::FeeTypes, arg6: &mut 0x2::tx_context::TxContext) {
        pay_fee_3<T0, T1, T2, T4>(arg0, arg1, arg2, arg3, arg5, arg6);
        pay_fee_1<T3, T4>(arg0, arg4, arg5, arg6);
    }

    public(friend) fun pay_fee_5<T0, T1, T2, T3, T4, T5>(arg0: &0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::config::FeeConfig, arg1: &mut 0x2::coin::Coin<T0>, arg2: &mut 0x2::coin::Coin<T1>, arg3: &mut 0x2::coin::Coin<T2>, arg4: &mut 0x2::coin::Coin<T3>, arg5: &mut 0x2::coin::Coin<T4>, arg6: 0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::constant::FeeTypes, arg7: &mut 0x2::tx_context::TxContext) {
        pay_fee_4<T0, T1, T2, T3, T5>(arg0, arg1, arg2, arg3, arg4, arg6, arg7);
        pay_fee_1<T4, T5>(arg0, arg5, arg6, arg7);
    }

    public(friend) fun pay_fee_6<T0, T1, T2, T3, T4, T5, T6>(arg0: &0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::config::FeeConfig, arg1: &mut 0x2::coin::Coin<T0>, arg2: &mut 0x2::coin::Coin<T1>, arg3: &mut 0x2::coin::Coin<T2>, arg4: &mut 0x2::coin::Coin<T3>, arg5: &mut 0x2::coin::Coin<T4>, arg6: &mut 0x2::coin::Coin<T5>, arg7: 0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::constant::FeeTypes, arg8: &mut 0x2::tx_context::TxContext) {
        pay_fee_5<T0, T1, T2, T3, T4, T6>(arg0, arg1, arg2, arg3, arg4, arg5, arg7, arg8);
        pay_fee_1<T5, T6>(arg0, arg6, arg7, arg8);
    }

    public(friend) fun pay_fee_7<T0, T1, T2, T3, T4, T5, T6, T7>(arg0: &0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::config::FeeConfig, arg1: &mut 0x2::coin::Coin<T0>, arg2: &mut 0x2::coin::Coin<T1>, arg3: &mut 0x2::coin::Coin<T2>, arg4: &mut 0x2::coin::Coin<T3>, arg5: &mut 0x2::coin::Coin<T4>, arg6: &mut 0x2::coin::Coin<T5>, arg7: &mut 0x2::coin::Coin<T6>, arg8: 0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::constant::FeeTypes, arg9: &mut 0x2::tx_context::TxContext) {
        pay_fee_6<T0, T1, T2, T3, T4, T5, T7>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg8, arg9);
        pay_fee_1<T6, T7>(arg0, arg7, arg8, arg9);
    }

    // decompiled from Move bytecode v6
}

