module 0x738625f4678afd82e5353811deaa425eb7d6d7cc23585f514db183b22498bf8c::coinz {
    public entry fun zero<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::zero<T0>(arg0), 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

