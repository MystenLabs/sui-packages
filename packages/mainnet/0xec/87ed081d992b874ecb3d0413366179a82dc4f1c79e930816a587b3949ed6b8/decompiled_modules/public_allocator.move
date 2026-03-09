module 0xec87ed081d992b874ecb3d0413366179a82dc4f1c79e930816a587b3949ed6b8::public_allocator {
    public fun reallocate<T0, T1>(arg0: &mut 0xec87ed081d992b874ecb3d0413366179a82dc4f1c79e930816a587b3949ed6b8::meta_vault_core::Vault<T0, T1>, arg1: &mut 0xec87ed081d992b874ecb3d0413366179a82dc4f1c79e930816a587b3949ed6b8::market::Hearn, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0xec87ed081d992b874ecb3d0413366179a82dc4f1c79e930816a587b3949ed6b8::meta_vault_core::rebalance<T0, T1>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

