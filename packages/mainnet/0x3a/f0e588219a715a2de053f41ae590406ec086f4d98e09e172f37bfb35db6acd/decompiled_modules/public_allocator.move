module 0x3af0e588219a715a2de053f41ae590406ec086f4d98e09e172f37bfb35db6acd::public_allocator {
    public fun reallocate<T0, T1>(arg0: &mut 0x3af0e588219a715a2de053f41ae590406ec086f4d98e09e172f37bfb35db6acd::meta_vault_core::Vault<T0, T1>, arg1: &mut 0x3af0e588219a715a2de053f41ae590406ec086f4d98e09e172f37bfb35db6acd::market::Hearn, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x3af0e588219a715a2de053f41ae590406ec086f4d98e09e172f37bfb35db6acd::meta_vault_core::rebalance<T0, T1>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v7
}

