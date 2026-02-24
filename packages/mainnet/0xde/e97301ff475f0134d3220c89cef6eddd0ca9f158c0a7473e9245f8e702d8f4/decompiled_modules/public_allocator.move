module 0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::public_allocator {
    public fun reallocate<T0, T1>(arg0: &mut 0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::meta_vault_core::Vault<T0, T1>, arg1: &mut 0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::market::Hearn, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::meta_vault_core::rebalance<T0, T1>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

