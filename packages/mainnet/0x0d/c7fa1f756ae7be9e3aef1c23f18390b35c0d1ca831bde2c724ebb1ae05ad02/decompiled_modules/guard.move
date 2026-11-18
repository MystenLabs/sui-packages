module 0xdc7fa1f756ae7be9e3aef1c23f18390b35c0d1ca831bde2c724ebb1ae05ad02::guard {
    public fun at_least<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64) {
        assert!(0x2::coin::value<T0>(arg0) >= arg1, 3);
    }

    public fun code_late() : u64 {
        1
    }

    public fun code_leg() : u64 {
        3
    }

    public fun code_profit() : u64 {
        2
    }

    public fun not_after(arg0: &0x2::clock::Clock, arg1: u64) {
        assert!(0x2::clock::timestamp_ms(arg0) <= arg1, 1);
    }

    public fun settle<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg0) >= arg1, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg2));
    }

    public fun settle_balance<T0>(arg0: 0x2::balance::Balance<T0>, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<T0>(&arg0) >= arg1, 2);
        if (0x2::balance::value<T0>(&arg0) == 0) {
            0x2::balance::destroy_zero<T0>(arg0);
        } else {
            0x2::balance::send_funds<T0>(arg0, 0x2::tx_context::sender(arg2));
        };
    }

    public fun settle_to_balance<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        settle_balance<T0>(0x2::coin::into_balance<T0>(arg0), arg1, arg2);
    }

    // decompiled from Move bytecode v7
}

