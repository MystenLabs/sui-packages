module 0x36c49ffe110886275583d75ac3714a3971767666fe5cf17f2395a3b52a2afa96::public_allocator {
    public fun reallocate<T0, T1>(arg0: &mut 0x36c49ffe110886275583d75ac3714a3971767666fe5cf17f2395a3b52a2afa96::meta_vault_core::Vault<T0, T1>, arg1: &mut 0x36c49ffe110886275583d75ac3714a3971767666fe5cf17f2395a3b52a2afa96::market::Hearn, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x36c49ffe110886275583d75ac3714a3971767666fe5cf17f2395a3b52a2afa96::meta_vault_core::rebalance<T0, T1>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

