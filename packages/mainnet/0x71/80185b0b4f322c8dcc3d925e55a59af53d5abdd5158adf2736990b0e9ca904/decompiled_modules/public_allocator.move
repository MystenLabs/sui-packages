module 0x7180185b0b4f322c8dcc3d925e55a59af53d5abdd5158adf2736990b0e9ca904::public_allocator {
    public fun reallocate<T0, T1>(arg0: &mut 0x7180185b0b4f322c8dcc3d925e55a59af53d5abdd5158adf2736990b0e9ca904::meta_vault_core::Vault<T0, T1>, arg1: &mut 0x7180185b0b4f322c8dcc3d925e55a59af53d5abdd5158adf2736990b0e9ca904::market::Hearn, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x7180185b0b4f322c8dcc3d925e55a59af53d5abdd5158adf2736990b0e9ca904::meta_vault_core::rebalance<T0, T1>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

