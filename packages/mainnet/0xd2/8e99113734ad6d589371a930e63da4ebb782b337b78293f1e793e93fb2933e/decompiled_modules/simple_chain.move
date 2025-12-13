module 0xd28e99113734ad6d589371a930e63da4ebb782b337b78293f1e793e93fb2933e::simple_chain {
    public entry fun test_atomic_chain<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::coin::join<T0>(&mut arg0, 0x2::coin::split<T0>(&mut arg0, 0x2::coin::value<T0>(&arg0) / 2, arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg1));
    }

    public entry fun test_compile<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

