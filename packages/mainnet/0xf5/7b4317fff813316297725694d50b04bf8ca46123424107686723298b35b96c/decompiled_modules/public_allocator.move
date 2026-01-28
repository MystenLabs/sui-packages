module 0xf57b4317fff813316297725694d50b04bf8ca46123424107686723298b35b96c::public_allocator {
    public fun reallocate<T0, T1>(arg0: &mut 0xf57b4317fff813316297725694d50b04bf8ca46123424107686723298b35b96c::meta_vault_core::Vault<T0, T1>, arg1: &mut 0xf57b4317fff813316297725694d50b04bf8ca46123424107686723298b35b96c::market::Hearn, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0xf57b4317fff813316297725694d50b04bf8ca46123424107686723298b35b96c::meta_vault_core::rebalance<T0, T1>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

