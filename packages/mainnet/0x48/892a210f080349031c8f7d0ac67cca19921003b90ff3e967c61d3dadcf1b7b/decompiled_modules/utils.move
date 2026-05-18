module 0x48892a210f080349031c8f7d0ac67cca19921003b90ff3e967c61d3dadcf1b7b::utils {
    public fun split_coin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg1 > 0, 46000);
        assert!(0x2::coin::value<T0>(&arg0) >= arg1, 46001);
        if (0x2::coin::value<T0>(&arg0) == 0) {
            0x2::coin::destroy_zero<T0>(arg0);
            return 0x2::coin::split<T0>(&mut arg0, arg1, arg2)
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg2));
        0x2::coin::split<T0>(&mut arg0, arg1, arg2)
    }

    public fun split_coin_to_balance<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0x2::coin::into_balance<T0>(split_coin<T0>(arg0, arg1, arg2))
    }

    // decompiled from Move bytecode v7
}

