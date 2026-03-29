module 0x98a64aeca9255832c7f8b8309e8cf6440a56cde274adc18704adb4235c71ec0c::abyss_vault {
    struct AToken<phantom T0> has key {
        id: 0x2::object::UID,
    }

    struct Vault<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        dummy: u8,
    }

    public fun supply<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &mut 0x98a64aeca9255832c7f8b8309e8cf6440a56cde274adc18704adb4235c71ec0c::margin_pool::MarginPool, arg2: &0x98a64aeca9255832c7f8b8309e8cf6440a56cde274adc18704adb4235c71ec0c::vault_registry::VaultRegistry, arg3: &0x98a64aeca9255832c7f8b8309e8cf6440a56cde274adc18704adb4235c71ec0c::margin_registry::MarginRegistry, arg4: 0x2::coin::Coin<T0>, arg5: &0x98a64aeca9255832c7f8b8309e8cf6440a56cde274adc18704adb4235c71ec0c::vault_registry::AbyssSupplierCap, arg6: 0x1::option::Option<u64>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        abort 0
    }

    public fun withdraw<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &mut 0x98a64aeca9255832c7f8b8309e8cf6440a56cde274adc18704adb4235c71ec0c::margin_pool::MarginPool, arg2: &0x98a64aeca9255832c7f8b8309e8cf6440a56cde274adc18704adb4235c71ec0c::vault_registry::VaultRegistry, arg3: &0x98a64aeca9255832c7f8b8309e8cf6440a56cde274adc18704adb4235c71ec0c::margin_registry::MarginRegistry, arg4: 0x2::coin::Coin<T1>, arg5: &0x98a64aeca9255832c7f8b8309e8cf6440a56cde274adc18704adb4235c71ec0c::vault_registry::AbyssSupplierCap, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        abort 0
    }

    // decompiled from Move bytecode v6
}

