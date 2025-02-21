module 0x82c95b6cbbabf1432cfc9c581be676f2bff1c1898178f39b8a6d41505f9fbc4::coinz {
    public entry fun zero<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::zero<T0>(arg0), 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

