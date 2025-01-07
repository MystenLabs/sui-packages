module 0x29c9348070c9293dae0191c479f2b5ac41fdcde9214d10a0773be88c86b4aec3::SimpleTransfer {
    public entry fun split_and_transfer_half<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0, 0x2::coin::value<T0>(&arg0) / 2, arg3), arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg2);
    }

    // decompiled from Move bytecode v6
}

