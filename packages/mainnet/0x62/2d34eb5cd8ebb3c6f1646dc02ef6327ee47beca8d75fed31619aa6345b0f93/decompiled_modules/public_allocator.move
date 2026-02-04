module 0x622d34eb5cd8ebb3c6f1646dc02ef6327ee47beca8d75fed31619aa6345b0f93::public_allocator {
    public fun reallocate<T0, T1>(arg0: &mut 0x622d34eb5cd8ebb3c6f1646dc02ef6327ee47beca8d75fed31619aa6345b0f93::meta_vault_core::Vault<T0, T1>, arg1: &mut 0x622d34eb5cd8ebb3c6f1646dc02ef6327ee47beca8d75fed31619aa6345b0f93::market::Hearn, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x622d34eb5cd8ebb3c6f1646dc02ef6327ee47beca8d75fed31619aa6345b0f93::meta_vault_core::rebalance<T0, T1>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

