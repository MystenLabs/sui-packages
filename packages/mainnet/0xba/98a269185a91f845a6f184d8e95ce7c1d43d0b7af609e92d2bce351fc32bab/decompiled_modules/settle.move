module 0xad8506d1da61bb3c54d22ba4617e5c498f5a442c656a32f54e8ceb66810964c4::settle {
    public(friend) fun at_least<T0>(arg0: 0x2::balance::Balance<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        assert!(0x2::balance::value<T0>(&arg0) >= arg1, 1);
        arg0
    }

    public fun before(arg0: &0x2::clock::Clock, arg1: u64) {
        assert!(0x2::clock::timestamp_ms(arg0) <= arg1, 3);
    }

    public fun into_gas(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: 0x2::balance::Balance<0x2::sui::SUI>, arg2: u64) {
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg1) >= arg2, 1);
        0x2::balance::join<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(arg0), arg1);
    }

    public fun to_sender<T0>(arg0: 0x2::balance::Balance<T0>, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<T0>(&arg0) >= arg1, 1);
        0x2::balance::send_funds<T0>(arg0, 0x2::tx_context::sender(arg2));
    }

    public(friend) fun within(arg0: u128, arg1: u128, arg2: bool) {
        assert!(arg2 && arg0 >= arg1 || arg0 <= arg1, 2);
    }

    // decompiled from Move bytecode v7
}

