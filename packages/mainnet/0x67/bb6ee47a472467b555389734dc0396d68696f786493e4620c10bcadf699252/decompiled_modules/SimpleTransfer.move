module 0x67bb6ee47a472467b555389734dc0396d68696f786493e4620c10bcadf699252::SimpleTransfer {
    public entry fun split_and_transfer_half<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0, 0x2::coin::value<T0>(&arg0) / 2, arg3), arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg2);
    }

    // decompiled from Move bytecode v6
}

