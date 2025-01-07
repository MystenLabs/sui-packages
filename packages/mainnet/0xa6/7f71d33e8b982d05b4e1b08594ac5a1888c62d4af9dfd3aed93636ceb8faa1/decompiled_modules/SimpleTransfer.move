module 0xa67f71d33e8b982d05b4e1b08594ac5a1888c62d4af9dfd3aed93636ceb8faa1::SimpleTransfer {
    public entry fun split_and_transfer<T0: store + key>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: address, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0, arg1, arg4), arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg3);
    }

    public entry fun transfer_object<T0: store + key>(arg0: T0, arg1: address) {
        0x2::transfer::public_transfer<T0>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

