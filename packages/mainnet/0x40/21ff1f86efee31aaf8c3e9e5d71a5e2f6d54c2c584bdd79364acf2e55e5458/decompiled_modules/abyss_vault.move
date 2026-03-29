module 0x4021ff1f86efee31aaf8c3e9e5d71a5e2f6d54c2c584bdd79364acf2e55e5458::abyss_vault {
    struct AToken<phantom T0> has key {
        id: 0x2::object::UID,
    }

    struct Vault<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        dummy: u8,
    }

    public fun supply<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &mut 0x4021ff1f86efee31aaf8c3e9e5d71a5e2f6d54c2c584bdd79364acf2e55e5458::margin_pool::MarginPool, arg2: &0x4021ff1f86efee31aaf8c3e9e5d71a5e2f6d54c2c584bdd79364acf2e55e5458::vault_registry::VaultRegistry, arg3: &0x4021ff1f86efee31aaf8c3e9e5d71a5e2f6d54c2c584bdd79364acf2e55e5458::margin_registry::MarginRegistry, arg4: 0x2::coin::Coin<T0>, arg5: &0x4021ff1f86efee31aaf8c3e9e5d71a5e2f6d54c2c584bdd79364acf2e55e5458::vault_registry::AbyssSupplierCap, arg6: 0x1::option::Option<u64>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        abort 0
    }

    public fun withdraw<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &mut 0x4021ff1f86efee31aaf8c3e9e5d71a5e2f6d54c2c584bdd79364acf2e55e5458::margin_pool::MarginPool, arg2: &0x4021ff1f86efee31aaf8c3e9e5d71a5e2f6d54c2c584bdd79364acf2e55e5458::vault_registry::VaultRegistry, arg3: &0x4021ff1f86efee31aaf8c3e9e5d71a5e2f6d54c2c584bdd79364acf2e55e5458::margin_registry::MarginRegistry, arg4: 0x2::coin::Coin<T1>, arg5: &0x4021ff1f86efee31aaf8c3e9e5d71a5e2f6d54c2c584bdd79364acf2e55e5458::vault_registry::AbyssSupplierCap, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        abort 0
    }

    // decompiled from Move bytecode v6
}

