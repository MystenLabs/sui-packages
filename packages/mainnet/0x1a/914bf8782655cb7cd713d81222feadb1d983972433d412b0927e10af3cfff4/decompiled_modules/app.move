module 0x1a914bf8782655cb7cd713d81222feadb1d983972433d412b0927e10af3cfff4::app {
    public fun transfer_coin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0, 0x2::coin::value<T0>(&arg0), arg2), arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

