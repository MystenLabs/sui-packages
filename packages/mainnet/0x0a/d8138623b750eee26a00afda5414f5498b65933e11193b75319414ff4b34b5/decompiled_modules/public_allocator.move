module 0xad8138623b750eee26a00afda5414f5498b65933e11193b75319414ff4b34b5::public_allocator {
    public fun reallocate<T0, T1>(arg0: &mut 0xad8138623b750eee26a00afda5414f5498b65933e11193b75319414ff4b34b5::meta_vault_core::Vault<T0, T1>, arg1: &mut 0xad8138623b750eee26a00afda5414f5498b65933e11193b75319414ff4b34b5::market::Hearn, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0xad8138623b750eee26a00afda5414f5498b65933e11193b75319414ff4b34b5::meta_vault_core::rebalance<T0, T1>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

