module 0xdd7376a4b89ffee6c2782e3da9fe9af9ee17a972879e685502ca102f0ffb8ae6::abyss_vault {
    struct AToken<phantom T0> has key {
        id: 0x2::object::UID,
    }

    struct Vault<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        dummy: u8,
    }

    public fun supply<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &mut 0xdd7376a4b89ffee6c2782e3da9fe9af9ee17a972879e685502ca102f0ffb8ae6::margin_pool::MarginPool, arg2: &0xdd7376a4b89ffee6c2782e3da9fe9af9ee17a972879e685502ca102f0ffb8ae6::vault_registry::VaultRegistry, arg3: &0xdd7376a4b89ffee6c2782e3da9fe9af9ee17a972879e685502ca102f0ffb8ae6::margin_registry::MarginRegistry, arg4: 0x2::coin::Coin<T0>, arg5: &0xdd7376a4b89ffee6c2782e3da9fe9af9ee17a972879e685502ca102f0ffb8ae6::vault_registry::AbyssSupplierCap, arg6: 0x1::option::Option<u64>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        abort 0
    }

    public fun withdraw<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &mut 0xdd7376a4b89ffee6c2782e3da9fe9af9ee17a972879e685502ca102f0ffb8ae6::margin_pool::MarginPool, arg2: &0xdd7376a4b89ffee6c2782e3da9fe9af9ee17a972879e685502ca102f0ffb8ae6::vault_registry::VaultRegistry, arg3: &0xdd7376a4b89ffee6c2782e3da9fe9af9ee17a972879e685502ca102f0ffb8ae6::margin_registry::MarginRegistry, arg4: 0x2::coin::Coin<T1>, arg5: &0xdd7376a4b89ffee6c2782e3da9fe9af9ee17a972879e685502ca102f0ffb8ae6::vault_registry::AbyssSupplierCap, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        abort 0
    }

    // decompiled from Move bytecode v6
}

