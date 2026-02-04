module 0x652e2d10792bf6534c5f00faccdef0687c7eb89d30b6f65f1e03902e91d2f7ab::public_allocator {
    public fun reallocate<T0, T1>(arg0: &mut 0x652e2d10792bf6534c5f00faccdef0687c7eb89d30b6f65f1e03902e91d2f7ab::meta_vault_core::Vault<T0, T1>, arg1: &mut 0x652e2d10792bf6534c5f00faccdef0687c7eb89d30b6f65f1e03902e91d2f7ab::market::Hearn, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x652e2d10792bf6534c5f00faccdef0687c7eb89d30b6f65f1e03902e91d2f7ab::meta_vault_core::rebalance<T0, T1>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

