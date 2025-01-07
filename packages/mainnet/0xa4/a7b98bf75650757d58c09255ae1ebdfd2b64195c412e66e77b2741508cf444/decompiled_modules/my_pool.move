module 0xa4a7b98bf75650757d58c09255ae1ebdfd2b64195c412e66e77b2741508cf444::my_pool {
    struct POOL_TEAM has drop {
        dummy_field: bool,
    }

    entry fun create_pool<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0xa4a7b98bf75650757d58c09255ae1ebdfd2b64195c412e66e77b2741508cf444::claim::create<T0>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

