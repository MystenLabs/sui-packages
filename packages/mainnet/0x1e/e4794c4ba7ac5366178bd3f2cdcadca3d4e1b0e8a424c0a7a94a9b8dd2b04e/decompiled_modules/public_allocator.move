module 0x1ee4794c4ba7ac5366178bd3f2cdcadca3d4e1b0e8a424c0a7a94a9b8dd2b04e::public_allocator {
    public fun reallocate<T0, T1>(arg0: &mut 0x1ee4794c4ba7ac5366178bd3f2cdcadca3d4e1b0e8a424c0a7a94a9b8dd2b04e::meta_vault_core::Vault<T0, T1>, arg1: &mut 0x1ee4794c4ba7ac5366178bd3f2cdcadca3d4e1b0e8a424c0a7a94a9b8dd2b04e::market::Hearn, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x1ee4794c4ba7ac5366178bd3f2cdcadca3d4e1b0e8a424c0a7a94a9b8dd2b04e::meta_vault_core::rebalance<T0, T1>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

