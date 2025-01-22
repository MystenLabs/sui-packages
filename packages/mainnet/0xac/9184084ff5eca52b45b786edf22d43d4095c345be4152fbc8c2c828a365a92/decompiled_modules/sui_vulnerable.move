module 0xac9184084ff5eca52b45b786edf22d43d4095c345be4152fbc8c2c828a365a92::sui_vulnerable {
    public fun transfer_nft<T0: store + key>(arg0: T0, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<T0>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

