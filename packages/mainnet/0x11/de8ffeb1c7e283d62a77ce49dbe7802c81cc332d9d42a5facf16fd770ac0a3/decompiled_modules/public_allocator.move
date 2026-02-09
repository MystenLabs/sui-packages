module 0x11de8ffeb1c7e283d62a77ce49dbe7802c81cc332d9d42a5facf16fd770ac0a3::public_allocator {
    public fun reallocate<T0, T1>(arg0: &mut 0x11de8ffeb1c7e283d62a77ce49dbe7802c81cc332d9d42a5facf16fd770ac0a3::meta_vault_core::Vault<T0, T1>, arg1: &mut 0x11de8ffeb1c7e283d62a77ce49dbe7802c81cc332d9d42a5facf16fd770ac0a3::market::Hearn, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x11de8ffeb1c7e283d62a77ce49dbe7802c81cc332d9d42a5facf16fd770ac0a3::meta_vault_core::rebalance<T0, T1>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

