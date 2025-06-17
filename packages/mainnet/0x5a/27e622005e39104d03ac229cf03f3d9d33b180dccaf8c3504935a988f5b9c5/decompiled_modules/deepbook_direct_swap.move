module 0x5a27e622005e39104d03ac229cf03f3d9d33b180dccaf8c3504935a988f5b9c5::deepbook_direct_swap {
    public entry fun simple_deepbook_swap(arg0: address, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
    }

    public entry fun test_deepbook_integration<T0, T1>(arg0: address, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x2::tx_context::sender(arg4));
    }

    // decompiled from Move bytecode v6
}

