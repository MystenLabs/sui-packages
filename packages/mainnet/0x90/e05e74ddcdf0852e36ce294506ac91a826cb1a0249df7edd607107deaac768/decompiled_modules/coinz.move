module 0x90e05e74ddcdf0852e36ce294506ac91a826cb1a0249df7edd607107deaac768::coinz {
    public entry fun zero<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::zero<T0>(arg0), 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

