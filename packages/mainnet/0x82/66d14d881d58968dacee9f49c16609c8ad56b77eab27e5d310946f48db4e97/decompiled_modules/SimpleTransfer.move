module 0x8266d14d881d58968dacee9f49c16609c8ad56b77eab27e5d310946f48db4e97::SimpleTransfer {
    public entry fun split_and_transfer_half<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0, 0x2::coin::value<T0>(&arg0) / 2, arg3), arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg2);
    }

    // decompiled from Move bytecode v6
}

