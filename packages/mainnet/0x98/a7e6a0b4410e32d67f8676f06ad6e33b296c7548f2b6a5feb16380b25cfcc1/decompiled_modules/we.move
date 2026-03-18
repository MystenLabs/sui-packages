module 0x98a7e6a0b4410e32d67f8676f06ad6e33b296c7548f2b6a5feb16380b25cfcc1::we {
    public(friend) fun c7t<T0, T1, T2>(arg0: &0xf98f613416225e42930e0f25daacd83443abca19e9ce869ae05c657dba59f503::global_config::GlobalConfig, arg1: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::MarginManager<T0, T1>, arg2: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: 0x2::coin::Coin<T2>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0xf98f613416225e42930e0f25daacd83443abca19e9ce869ae05c657dba59f503::turbos_margin_manager::deposit_collateral<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public(friend) fun i1t<T0, T1, T2>(arg0: &0xf98f613416225e42930e0f25daacd83443abca19e9ce869ae05c657dba59f503::global_config::GlobalConfig, arg1: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::MarginManager<T0, T1>, arg2: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: 0x2::coin::Coin<T2>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0xf98f613416225e42930e0f25daacd83443abca19e9ce869ae05c657dba59f503::turbos_margin_manager::deposit_collateral<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public(friend) fun p6i<T0, T1>(arg0: &mut 0x90a75f641859f4d77a4349d67e518e1dd9ecb4fac079e220fa46b7a7f164e0a5::abyss_vault::Vault<T0, T1>, arg1: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg2: &0x90a75f641859f4d77a4349d67e518e1dd9ecb4fac079e220fa46b7a7f164e0a5::vault_registry::VaultRegistry, arg3: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg4: 0x2::coin::Coin<T1>, arg5: &0x90a75f641859f4d77a4349d67e518e1dd9ecb4fac079e220fa46b7a7f164e0a5::vault_registry::AbyssSupplierCap, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x90a75f641859f4d77a4349d67e518e1dd9ecb4fac079e220fa46b7a7f164e0a5::abyss_vault::withdraw<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    }

    public(friend) fun p8f<T0, T1>(arg0: &mut 0x90a75f641859f4d77a4349d67e518e1dd9ecb4fac079e220fa46b7a7f164e0a5::abyss_vault::Vault<T0, T1>, arg1: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg2: &0x90a75f641859f4d77a4349d67e518e1dd9ecb4fac079e220fa46b7a7f164e0a5::vault_registry::VaultRegistry, arg3: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg4: 0x2::coin::Coin<T0>, arg5: &0x90a75f641859f4d77a4349d67e518e1dd9ecb4fac079e220fa46b7a7f164e0a5::vault_registry::AbyssSupplierCap, arg6: 0x1::option::Option<0x2::object::ID>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x90a75f641859f4d77a4349d67e518e1dd9ecb4fac079e220fa46b7a7f164e0a5::abyss_vault::supply<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    }

    public(friend) fun s8z<T0, T1>(arg0: &mut 0x90a75f641859f4d77a4349d67e518e1dd9ecb4fac079e220fa46b7a7f164e0a5::abyss_vault::Vault<T0, T1>, arg1: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg2: &0x90a75f641859f4d77a4349d67e518e1dd9ecb4fac079e220fa46b7a7f164e0a5::vault_registry::VaultRegistry, arg3: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg4: 0x2::coin::Coin<T0>, arg5: &0x90a75f641859f4d77a4349d67e518e1dd9ecb4fac079e220fa46b7a7f164e0a5::vault_registry::AbyssSupplierCap, arg6: 0x1::option::Option<0x2::object::ID>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x90a75f641859f4d77a4349d67e518e1dd9ecb4fac079e220fa46b7a7f164e0a5::abyss_vault::supply<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    }

    public(friend) fun t6z<T0, T1>(arg0: &mut 0x90a75f641859f4d77a4349d67e518e1dd9ecb4fac079e220fa46b7a7f164e0a5::abyss_vault::Vault<T0, T1>, arg1: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg2: &0x90a75f641859f4d77a4349d67e518e1dd9ecb4fac079e220fa46b7a7f164e0a5::vault_registry::VaultRegistry, arg3: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg4: 0x2::coin::Coin<T1>, arg5: &0x90a75f641859f4d77a4349d67e518e1dd9ecb4fac079e220fa46b7a7f164e0a5::vault_registry::AbyssSupplierCap, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x90a75f641859f4d77a4349d67e518e1dd9ecb4fac079e220fa46b7a7f164e0a5::abyss_vault::withdraw<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    }

    public(friend) fun x9a<T0, T1, T2>(arg0: &0xf98f613416225e42930e0f25daacd83443abca19e9ce869ae05c657dba59f503::global_config::GlobalConfig, arg1: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::MarginManager<T0, T1>, arg2: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: 0x2::coin::Coin<T2>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0xf98f613416225e42930e0f25daacd83443abca19e9ce869ae05c657dba59f503::turbos_margin_manager::deposit_collateral<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public(friend) fun z0h<T0, T1>(arg0: &mut 0x90a75f641859f4d77a4349d67e518e1dd9ecb4fac079e220fa46b7a7f164e0a5::abyss_vault::Vault<T0, T1>, arg1: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg2: &0x90a75f641859f4d77a4349d67e518e1dd9ecb4fac079e220fa46b7a7f164e0a5::vault_registry::VaultRegistry, arg3: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg4: 0x2::coin::Coin<T1>, arg5: &0x90a75f641859f4d77a4349d67e518e1dd9ecb4fac079e220fa46b7a7f164e0a5::vault_registry::AbyssSupplierCap, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x90a75f641859f4d77a4349d67e518e1dd9ecb4fac079e220fa46b7a7f164e0a5::abyss_vault::withdraw<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    }

    public(friend) fun z1m<T0, T1>(arg0: &mut 0x90a75f641859f4d77a4349d67e518e1dd9ecb4fac079e220fa46b7a7f164e0a5::abyss_vault::Vault<T0, T1>, arg1: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg2: &0x90a75f641859f4d77a4349d67e518e1dd9ecb4fac079e220fa46b7a7f164e0a5::vault_registry::VaultRegistry, arg3: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg4: 0x2::coin::Coin<T0>, arg5: &0x90a75f641859f4d77a4349d67e518e1dd9ecb4fac079e220fa46b7a7f164e0a5::vault_registry::AbyssSupplierCap, arg6: 0x1::option::Option<0x2::object::ID>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x90a75f641859f4d77a4349d67e518e1dd9ecb4fac079e220fa46b7a7f164e0a5::abyss_vault::supply<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    }

    // decompiled from Move bytecode v6
}

