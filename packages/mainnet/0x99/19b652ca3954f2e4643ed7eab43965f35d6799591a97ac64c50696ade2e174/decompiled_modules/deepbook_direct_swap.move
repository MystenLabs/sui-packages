module 0x9919b652ca3954f2e4643ed7eab43965f35d6799591a97ac64c50696ade2e174::deepbook_direct_swap {
    public entry fun simple_deepbook_swap(arg0: address, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
    }

    public entry fun test_deepbook_integration<T0, T1>(arg0: address, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x2::tx_context::sender(arg4));
    }

    // decompiled from Move bytecode v6
}

