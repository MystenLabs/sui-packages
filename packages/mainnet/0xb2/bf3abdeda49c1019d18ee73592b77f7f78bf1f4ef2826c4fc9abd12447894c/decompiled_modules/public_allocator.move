module 0xb2bf3abdeda49c1019d18ee73592b77f7f78bf1f4ef2826c4fc9abd12447894c::public_allocator {
    public fun reallocate<T0, T1>(arg0: &mut 0xb2bf3abdeda49c1019d18ee73592b77f7f78bf1f4ef2826c4fc9abd12447894c::meta_vault_core::Vault<T0, T1>, arg1: &mut 0xb2bf3abdeda49c1019d18ee73592b77f7f78bf1f4ef2826c4fc9abd12447894c::market::Hearn, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0xb2bf3abdeda49c1019d18ee73592b77f7f78bf1f4ef2826c4fc9abd12447894c::meta_vault_core::rebalance<T0, T1>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

