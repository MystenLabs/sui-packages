module 0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::public_allocator {
    public fun reallocate<T0, T1>(arg0: &mut 0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::meta_vault_core::Vault<T0, T1>, arg1: &mut 0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::market::Hearn, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::meta_vault_core::rebalance<T0, T1>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

