module 0x88ad0545a50e4834a79a4a3837a4e4c9b1e0c7a6e567b46897cf098a927240a2::SimpleTransfer {
    public entry fun split_and_transfer<T0: store + key>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: address, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0, arg1, arg4), arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg3);
    }

    public entry fun transfer_all_sui(arg0: 0x2::coin::Coin<u64>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<u64>>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

