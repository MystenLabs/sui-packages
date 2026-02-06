module 0x1456cd3e359f4f574a2c384052a3c67300e0a548bf797c2bf3cfc22a64d9303b::public_allocator {
    public fun reallocate<T0, T1>(arg0: &mut 0x1456cd3e359f4f574a2c384052a3c67300e0a548bf797c2bf3cfc22a64d9303b::meta_vault_core::Vault<T0, T1>, arg1: &mut 0x1456cd3e359f4f574a2c384052a3c67300e0a548bf797c2bf3cfc22a64d9303b::market::Hearn, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x1456cd3e359f4f574a2c384052a3c67300e0a548bf797c2bf3cfc22a64d9303b::meta_vault_core::rebalance<T0, T1>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

