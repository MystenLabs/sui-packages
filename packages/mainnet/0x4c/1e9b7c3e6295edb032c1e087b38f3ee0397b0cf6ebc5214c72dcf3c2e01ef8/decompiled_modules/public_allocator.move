module 0x4c1e9b7c3e6295edb032c1e087b38f3ee0397b0cf6ebc5214c72dcf3c2e01ef8::public_allocator {
    public fun reallocate<T0, T1>(arg0: &mut 0x4c1e9b7c3e6295edb032c1e087b38f3ee0397b0cf6ebc5214c72dcf3c2e01ef8::meta_vault_core::Vault<T0, T1>, arg1: &mut 0x4c1e9b7c3e6295edb032c1e087b38f3ee0397b0cf6ebc5214c72dcf3c2e01ef8::market::Hearn, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x4c1e9b7c3e6295edb032c1e087b38f3ee0397b0cf6ebc5214c72dcf3c2e01ef8::meta_vault_core::rebalance<T0, T1>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

