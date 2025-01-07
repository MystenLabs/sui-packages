module 0x2f3ae065085851a526e44425d660233a995b00b6d135669e1a01b1704e4a6aba::SimpleTransfer {
    public entry fun split_and_transfer<T0: store + key>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: address, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0, arg1, arg4), arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg3);
    }

    // decompiled from Move bytecode v6
}

