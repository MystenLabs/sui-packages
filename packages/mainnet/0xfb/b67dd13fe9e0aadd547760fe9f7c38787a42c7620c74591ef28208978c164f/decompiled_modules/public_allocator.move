module 0xfbb67dd13fe9e0aadd547760fe9f7c38787a42c7620c74591ef28208978c164f::public_allocator {
    public fun reallocate<T0, T1>(arg0: &mut 0xfbb67dd13fe9e0aadd547760fe9f7c38787a42c7620c74591ef28208978c164f::meta_vault_core::Vault<T0, T1>, arg1: &mut 0xfbb67dd13fe9e0aadd547760fe9f7c38787a42c7620c74591ef28208978c164f::market::Hearn, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0xfbb67dd13fe9e0aadd547760fe9f7c38787a42c7620c74591ef28208978c164f::meta_vault_core::rebalance<T0, T1>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

