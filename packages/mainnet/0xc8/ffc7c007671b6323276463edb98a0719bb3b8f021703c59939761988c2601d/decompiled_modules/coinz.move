module 0xc8ffc7c007671b6323276463edb98a0719bb3b8f021703c59939761988c2601d::coinz {
    public entry fun zero<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_share_object<0x2::coin::Coin<T0>>(0x2::coin::zero<T0>(arg0));
    }

    // decompiled from Move bytecode v6
}

