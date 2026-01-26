module 0x891e08c8f501685d1e572b123247a3936a912adc60da63b1ead95f136bad5d84::public_allocator {
    public fun reallocate<T0, T1>(arg0: &mut 0x891e08c8f501685d1e572b123247a3936a912adc60da63b1ead95f136bad5d84::meta_vault_core::Vault<T0, T1>, arg1: &mut 0x891e08c8f501685d1e572b123247a3936a912adc60da63b1ead95f136bad5d84::market::Hearn, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x891e08c8f501685d1e572b123247a3936a912adc60da63b1ead95f136bad5d84::meta_vault_core::rebalance<T0, T1>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

