module 0x1bbe8f1fee7bff4f9da9f709d707526a4ba8f543f2353f0998f745e8f152d034::public_allocator {
    public fun reallocate<T0, T1>(arg0: &mut 0x1bbe8f1fee7bff4f9da9f709d707526a4ba8f543f2353f0998f745e8f152d034::meta_vault_core::Vault<T0, T1>, arg1: &mut 0x1bbe8f1fee7bff4f9da9f709d707526a4ba8f543f2353f0998f745e8f152d034::market::Hearn, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x1bbe8f1fee7bff4f9da9f709d707526a4ba8f543f2353f0998f745e8f152d034::meta_vault_core::rebalance<T0, T1>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

