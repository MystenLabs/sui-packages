module 0x5f60ea19ec3f70bdc3d1227c06882bf2b343df7d893e5cce6491972d08f76355::deepbook_direct_swap {
    public entry fun simple_deepbook_swap(arg0: address, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
    }

    public entry fun test_deepbook_integration<T0, T1>(arg0: address, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x2::tx_context::sender(arg4));
    }

    // decompiled from Move bytecode v6
}

