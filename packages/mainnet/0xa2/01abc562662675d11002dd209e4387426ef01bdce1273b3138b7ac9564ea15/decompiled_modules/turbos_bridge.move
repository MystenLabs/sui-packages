module 0xa201abc562662675d11002dd209e4387426ef01bdce1273b3138b7ac9564ea15::turbos_bridge {
    struct BridgeState has key {
        id: 0x2::object::UID,
        supplier_cap: 0xdd7376a4b89ffee6c2782e3da9fe9af9ee17a972879e685502ca102f0ffb8ae6::vault_registry::AbyssSupplierCap,
    }

    public fun create_bridge_state(arg0: 0xdd7376a4b89ffee6c2782e3da9fe9af9ee17a972879e685502ca102f0ffb8ae6::vault_registry::AbyssSupplierCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = BridgeState{
            id           : 0x2::object::new(arg1),
            supplier_cap : arg0,
        };
        0x2::transfer::share_object<BridgeState>(v0);
    }

    public fun deposit_to_turbos<T0, T1>(arg0: &mut BridgeState, arg1: &mut 0xdd7376a4b89ffee6c2782e3da9fe9af9ee17a972879e685502ca102f0ffb8ae6::abyss_vault::Vault<T0, T1>, arg2: &mut 0xdd7376a4b89ffee6c2782e3da9fe9af9ee17a972879e685502ca102f0ffb8ae6::margin_pool::MarginPool, arg3: &0xdd7376a4b89ffee6c2782e3da9fe9af9ee17a972879e685502ca102f0ffb8ae6::vault_registry::VaultRegistry, arg4: &0xdd7376a4b89ffee6c2782e3da9fe9af9ee17a972879e685502ca102f0ffb8ae6::margin_registry::MarginRegistry, arg5: &0x2::clock::Clock, arg6: 0x2::coin::Coin<T0>, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xdd7376a4b89ffee6c2782e3da9fe9af9ee17a972879e685502ca102f0ffb8ae6::abyss_vault::supply<T0, T1>(arg1, arg2, arg3, arg4, arg6, &arg0.supplier_cap, 0x1::option::none<u64>(), arg5, arg7)
    }

    public fun withdraw_from_turbos<T0, T1>(arg0: &mut BridgeState, arg1: &mut 0xdd7376a4b89ffee6c2782e3da9fe9af9ee17a972879e685502ca102f0ffb8ae6::abyss_vault::Vault<T0, T1>, arg2: &mut 0xdd7376a4b89ffee6c2782e3da9fe9af9ee17a972879e685502ca102f0ffb8ae6::margin_pool::MarginPool, arg3: &0xdd7376a4b89ffee6c2782e3da9fe9af9ee17a972879e685502ca102f0ffb8ae6::vault_registry::VaultRegistry, arg4: &0xdd7376a4b89ffee6c2782e3da9fe9af9ee17a972879e685502ca102f0ffb8ae6::margin_registry::MarginRegistry, arg5: &0x2::clock::Clock, arg6: 0x2::coin::Coin<T1>, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xdd7376a4b89ffee6c2782e3da9fe9af9ee17a972879e685502ca102f0ffb8ae6::abyss_vault::withdraw<T0, T1>(arg1, arg2, arg3, arg4, arg6, &arg0.supplier_cap, arg5, arg7)
    }

    // decompiled from Move bytecode v6
}

