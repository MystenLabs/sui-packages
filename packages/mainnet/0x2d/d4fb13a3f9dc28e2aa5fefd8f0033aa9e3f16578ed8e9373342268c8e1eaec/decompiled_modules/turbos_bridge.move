module 0x2dd4fb13a3f9dc28e2aa5fefd8f0033aa9e3f16578ed8e9373342268c8e1eaec::turbos_bridge {
    struct BridgeState has key {
        id: 0x2::object::UID,
        supplier_cap: 0xb2e7ea3f7fccda6220c555798e5148eb5c569daee598a6455071ba8c4bdcd447::vault_registry::AbyssSupplierCap,
    }

    public fun create_bridge_state(arg0: 0xb2e7ea3f7fccda6220c555798e5148eb5c569daee598a6455071ba8c4bdcd447::vault_registry::AbyssSupplierCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = BridgeState{
            id           : 0x2::object::new(arg1),
            supplier_cap : arg0,
        };
        0x2::transfer::share_object<BridgeState>(v0);
    }

    public fun deposit_to_turbos<T0, T1>(arg0: &mut BridgeState, arg1: &mut 0xb2e7ea3f7fccda6220c555798e5148eb5c569daee598a6455071ba8c4bdcd447::abyss_vault::Vault<T0, T1>, arg2: &mut 0xb2e7ea3f7fccda6220c555798e5148eb5c569daee598a6455071ba8c4bdcd447::margin_pool::MarginPool, arg3: &0xb2e7ea3f7fccda6220c555798e5148eb5c569daee598a6455071ba8c4bdcd447::vault_registry::VaultRegistry, arg4: &0xb2e7ea3f7fccda6220c555798e5148eb5c569daee598a6455071ba8c4bdcd447::margin_registry::MarginRegistry, arg5: &0x2::clock::Clock, arg6: 0x2::coin::Coin<T0>, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xb2e7ea3f7fccda6220c555798e5148eb5c569daee598a6455071ba8c4bdcd447::abyss_vault::supply<T0, T1>(arg1, arg2, arg3, arg4, arg6, &arg0.supplier_cap, 0x1::option::none<u64>(), arg5, arg7)
    }

    public fun withdraw_from_turbos<T0, T1>(arg0: &mut BridgeState, arg1: &mut 0xb2e7ea3f7fccda6220c555798e5148eb5c569daee598a6455071ba8c4bdcd447::abyss_vault::Vault<T0, T1>, arg2: &mut 0xb2e7ea3f7fccda6220c555798e5148eb5c569daee598a6455071ba8c4bdcd447::margin_pool::MarginPool, arg3: &0xb2e7ea3f7fccda6220c555798e5148eb5c569daee598a6455071ba8c4bdcd447::vault_registry::VaultRegistry, arg4: &0xb2e7ea3f7fccda6220c555798e5148eb5c569daee598a6455071ba8c4bdcd447::margin_registry::MarginRegistry, arg5: &0x2::clock::Clock, arg6: 0x2::coin::Coin<T1>, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xb2e7ea3f7fccda6220c555798e5148eb5c569daee598a6455071ba8c4bdcd447::abyss_vault::withdraw<T0, T1>(arg1, arg2, arg3, arg4, arg6, &arg0.supplier_cap, arg5, arg7)
    }

    // decompiled from Move bytecode v6
}

