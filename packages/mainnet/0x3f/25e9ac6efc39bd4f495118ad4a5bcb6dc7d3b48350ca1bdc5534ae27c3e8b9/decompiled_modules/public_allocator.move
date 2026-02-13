module 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::public_allocator {
    public fun reallocate<T0, T1>(arg0: &mut 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::Vault<T0, T1>, arg1: &mut 0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::market::Hearn, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x3f25e9ac6efc39bd4f495118ad4a5bcb6dc7d3b48350ca1bdc5534ae27c3e8b9::meta_vault_core::rebalance<T0, T1>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

