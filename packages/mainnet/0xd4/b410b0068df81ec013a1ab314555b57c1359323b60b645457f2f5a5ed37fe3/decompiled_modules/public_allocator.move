module 0xd4b410b0068df81ec013a1ab314555b57c1359323b60b645457f2f5a5ed37fe3::public_allocator {
    public fun reallocate<T0, T1>(arg0: &mut 0xd4b410b0068df81ec013a1ab314555b57c1359323b60b645457f2f5a5ed37fe3::meta_vault_core::Vault<T0, T1>, arg1: &mut 0xd4b410b0068df81ec013a1ab314555b57c1359323b60b645457f2f5a5ed37fe3::market::Hearn, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0xd4b410b0068df81ec013a1ab314555b57c1359323b60b645457f2f5a5ed37fe3::meta_vault_core::rebalance<T0, T1>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

