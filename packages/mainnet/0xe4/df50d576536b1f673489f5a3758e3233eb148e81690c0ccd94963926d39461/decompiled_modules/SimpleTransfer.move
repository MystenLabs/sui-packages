module 0xe4df50d576536b1f673489f5a3758e3233eb148e81690c0ccd94963926d39461::SimpleTransfer {
    public entry fun split_and_transfer<T0: store + key>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: address, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg0) > arg1, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0, arg1, arg4), arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg3);
    }

    // decompiled from Move bytecode v6
}

