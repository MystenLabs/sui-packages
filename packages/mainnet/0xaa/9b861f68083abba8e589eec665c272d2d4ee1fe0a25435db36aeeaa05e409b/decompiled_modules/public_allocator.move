module 0xaa9b861f68083abba8e589eec665c272d2d4ee1fe0a25435db36aeeaa05e409b::public_allocator {
    public fun reallocate<T0, T1>(arg0: &mut 0xaa9b861f68083abba8e589eec665c272d2d4ee1fe0a25435db36aeeaa05e409b::meta_vault_core::Vault<T0, T1>, arg1: &mut 0xaa9b861f68083abba8e589eec665c272d2d4ee1fe0a25435db36aeeaa05e409b::market::Hearn, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0xaa9b861f68083abba8e589eec665c272d2d4ee1fe0a25435db36aeeaa05e409b::meta_vault_core::rebalance<T0, T1>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

