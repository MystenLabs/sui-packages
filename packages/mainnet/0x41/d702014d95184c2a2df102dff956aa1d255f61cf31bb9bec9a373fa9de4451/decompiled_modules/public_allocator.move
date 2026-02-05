module 0x41d702014d95184c2a2df102dff956aa1d255f61cf31bb9bec9a373fa9de4451::public_allocator {
    public fun reallocate<T0, T1>(arg0: &mut 0x41d702014d95184c2a2df102dff956aa1d255f61cf31bb9bec9a373fa9de4451::meta_vault_core::Vault<T0, T1>, arg1: &mut 0x41d702014d95184c2a2df102dff956aa1d255f61cf31bb9bec9a373fa9de4451::market::Hearn, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x41d702014d95184c2a2df102dff956aa1d255f61cf31bb9bec9a373fa9de4451::meta_vault_core::rebalance<T0, T1>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

