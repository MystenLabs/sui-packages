module 0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::public_allocator {
    public fun reallocate<T0, T1>(arg0: &mut 0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::meta_vault_core::Vault<T0, T1>, arg1: &mut 0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::market::Hearn, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::meta_vault_core::rebalance<T0, T1>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

