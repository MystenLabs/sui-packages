module 0x145dda01e3e5993564f18593764901b1820c595dbf91437e8a45a935ad6a4ff2::public_allocator {
    public fun reallocate<T0, T1>(arg0: &mut 0x145dda01e3e5993564f18593764901b1820c595dbf91437e8a45a935ad6a4ff2::meta_vault_core::Vault<T0, T1>, arg1: &mut 0x145dda01e3e5993564f18593764901b1820c595dbf91437e8a45a935ad6a4ff2::market::Hearn, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x145dda01e3e5993564f18593764901b1820c595dbf91437e8a45a935ad6a4ff2::meta_vault_core::rebalance<T0, T1>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

