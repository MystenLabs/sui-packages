module 0x93f227b2fa77f149d2a5cfbe0ac704cbd6671f2f54a7a0872c9f990ab5cd5b08::utils {
    public(friend) fun only_one_some<T0, T1>(arg0: &0x1::option::Option<T0>, arg1: &0x1::option::Option<T1>) {
        assert!(0x1::option::is_some<T0>(arg0) && 0x1::option::is_none<T1>(arg1) || 0x1::option::is_none<T0>(arg0) && 0x1::option::is_some<T1>(arg1), 1);
    }

    public(friend) fun parse_amount_and_direction<T0, T1>(arg0: &0x1::option::Option<0x2::coin::Coin<T0>>, arg1: &0x1::option::Option<0x2::coin::Coin<T1>>) : (u64, bool) {
        only_one_some<0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>>(arg0, arg1);
        if (0x1::option::is_some<0x2::coin::Coin<T0>>(arg0)) {
            (0x2::coin::value<T0>(0x1::option::borrow<0x2::coin::Coin<T0>>(arg0)), true)
        } else {
            (0x2::coin::value<T1>(0x1::option::borrow<0x2::coin::Coin<T1>>(arg1)), false)
        }
    }

    public(friend) fun transfer_or_destroy<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(&arg0) == 0) {
            0x2::coin::destroy_zero<T0>(arg0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg1));
        };
    }

    // decompiled from Move bytecode v6
}

