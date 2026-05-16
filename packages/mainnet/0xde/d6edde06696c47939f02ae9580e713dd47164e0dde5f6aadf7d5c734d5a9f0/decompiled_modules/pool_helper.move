module 0x7fb4bb8fc904a235806734ae0eb3c205fa7ac283c60633ede8be75f2056c7645::pool_helper {
    public fun create_pool_and_transfer<T0, T1>(arg0: &mut 0x2::coin::TreasuryCap<T0>, arg1: &mut 0x2::coin::TreasuryCap<T1>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x7fb4bb8fc904a235806734ae0eb3c205fa7ac283c60633ede8be75f2056c7645::pool::create_pool<T0, T1>(arg0, arg1, arg2, arg3, arg4);
        0x2::coin::burn<T0>(arg0, v1);
        0x2::coin::burn<T1>(arg1, v2);
        0x7fb4bb8fc904a235806734ae0eb3c205fa7ac283c60633ede8be75f2056c7645::pool::transfer_pool<T0, T1>(v0, 0x2::tx_context::sender(arg4));
    }

    // decompiled from Move bytecode v7
}

