module 0x9610f8627666979cbb63e6f28e1ae91ecef4f1cc0ff8f36df14d75cf629080a2::execution {
    public fun maybe_x_to_y<T0, T1, T2>(arg0: &mut 0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::core::DEXStorage, arg1: &0x2::clock::Clock, arg2: 0x1::option::Option<0x2::coin::Coin<T1>>, arg3: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x2::coin::Coin<T2>> {
        if (0x1::option::is_none<0x2::coin::Coin<T1>>(&arg2)) {
            0x1::option::destroy_none<0x2::coin::Coin<T1>>(arg2);
            return 0x1::option::none<0x2::coin::Coin<T2>>()
        };
        assert!(0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::curve::is_volatile<T0>(), 2);
        0x1::option::some<0x2::coin::Coin<T2>>(0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::core::swap_token_x<T0, T1, T2>(arg0, arg1, 0x1::option::destroy_some<0x2::coin::Coin<T1>>(arg2), 0, arg3))
    }

    public fun maybe_y_to_x<T0, T1, T2>(arg0: &mut 0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::core::DEXStorage, arg1: &0x2::clock::Clock, arg2: 0x1::option::Option<0x2::coin::Coin<T2>>, arg3: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x2::coin::Coin<T1>> {
        if (0x1::option::is_none<0x2::coin::Coin<T2>>(&arg2)) {
            0x1::option::destroy_none<0x2::coin::Coin<T2>>(arg2);
            return 0x1::option::none<0x2::coin::Coin<T1>>()
        };
        assert!(0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::curve::is_volatile<T0>(), 2);
        0x1::option::some<0x2::coin::Coin<T1>>(0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::core::swap_token_y<T0, T1, T2>(arg0, arg1, 0x1::option::destroy_some<0x2::coin::Coin<T2>>(arg2), 0, arg3))
    }

    // decompiled from Move bytecode v7
}

