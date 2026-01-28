module 0x8472b546a74ed517740271ae7f8e92af2ae26969bed365fb0fabf8bc1be5f69e::public_allocator {
    public fun reallocate<T0, T1>(arg0: &mut 0x8472b546a74ed517740271ae7f8e92af2ae26969bed365fb0fabf8bc1be5f69e::meta_vault_core::Vault<T0, T1>, arg1: &mut 0x8472b546a74ed517740271ae7f8e92af2ae26969bed365fb0fabf8bc1be5f69e::market::Hearn, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x8472b546a74ed517740271ae7f8e92af2ae26969bed365fb0fabf8bc1be5f69e::meta_vault_core::rebalance<T0, T1>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

