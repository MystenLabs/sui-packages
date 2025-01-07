module 0x3df4b7fc9eeabe7f3d51f045cf7cc80fbc0bdc344a03e838b6e4f3858421aac6::transfer_pnut {
    public fun transfer_amount<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(arg0, arg1, arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

