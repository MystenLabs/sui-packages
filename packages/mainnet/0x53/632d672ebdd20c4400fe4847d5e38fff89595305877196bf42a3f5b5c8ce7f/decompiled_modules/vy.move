module 0x53632d672ebdd20c4400fe4847d5e38fff89595305877196bf42a3f5b5c8ce7f::vy {
    public(friend) fun j1c<T0, T1>(arg0: &mut 0x90a75f641859f4d77a4349d67e518e1dd9ecb4fac079e220fa46b7a7f164e0a5::abyss_vault::Vault<T0, T1>, arg1: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg2: &0x90a75f641859f4d77a4349d67e518e1dd9ecb4fac079e220fa46b7a7f164e0a5::vault_registry::VaultRegistry, arg3: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg4: 0x2::coin::Coin<T0>, arg5: &0x90a75f641859f4d77a4349d67e518e1dd9ecb4fac079e220fa46b7a7f164e0a5::vault_registry::AbyssSupplierCap, arg6: 0x1::option::Option<0x2::object::ID>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x90a75f641859f4d77a4349d67e518e1dd9ecb4fac079e220fa46b7a7f164e0a5::abyss_vault::supply<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    }

    public(friend) fun l9s<T0, T1>(arg0: &mut 0x90a75f641859f4d77a4349d67e518e1dd9ecb4fac079e220fa46b7a7f164e0a5::abyss_vault::Vault<T0, T1>, arg1: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg2: &0x90a75f641859f4d77a4349d67e518e1dd9ecb4fac079e220fa46b7a7f164e0a5::vault_registry::VaultRegistry, arg3: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg4: 0x2::coin::Coin<T0>, arg5: &0x90a75f641859f4d77a4349d67e518e1dd9ecb4fac079e220fa46b7a7f164e0a5::vault_registry::AbyssSupplierCap, arg6: 0x1::option::Option<0x2::object::ID>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x90a75f641859f4d77a4349d67e518e1dd9ecb4fac079e220fa46b7a7f164e0a5::abyss_vault::supply<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    }

    public(friend) fun p7s<T0, T1, T2>(arg0: &0xf98f613416225e42930e0f25daacd83443abca19e9ce869ae05c657dba59f503::global_config::GlobalConfig, arg1: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::MarginManager<T0, T1>, arg2: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: 0x2::coin::Coin<T2>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0xf98f613416225e42930e0f25daacd83443abca19e9ce869ae05c657dba59f503::turbos_margin_manager::deposit_collateral<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public(friend) fun q5x<T0, T1>(arg0: &mut 0x90a75f641859f4d77a4349d67e518e1dd9ecb4fac079e220fa46b7a7f164e0a5::abyss_vault::Vault<T0, T1>, arg1: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg2: &0x90a75f641859f4d77a4349d67e518e1dd9ecb4fac079e220fa46b7a7f164e0a5::vault_registry::VaultRegistry, arg3: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg4: 0x2::coin::Coin<T0>, arg5: &0x90a75f641859f4d77a4349d67e518e1dd9ecb4fac079e220fa46b7a7f164e0a5::vault_registry::AbyssSupplierCap, arg6: 0x1::option::Option<0x2::object::ID>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x90a75f641859f4d77a4349d67e518e1dd9ecb4fac079e220fa46b7a7f164e0a5::abyss_vault::supply<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    }

    public(friend) fun s0z<T0, T1>(arg0: &mut 0x90a75f641859f4d77a4349d67e518e1dd9ecb4fac079e220fa46b7a7f164e0a5::abyss_vault::Vault<T0, T1>, arg1: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg2: &0x90a75f641859f4d77a4349d67e518e1dd9ecb4fac079e220fa46b7a7f164e0a5::vault_registry::VaultRegistry, arg3: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg4: 0x2::coin::Coin<T1>, arg5: &0x90a75f641859f4d77a4349d67e518e1dd9ecb4fac079e220fa46b7a7f164e0a5::vault_registry::AbyssSupplierCap, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x90a75f641859f4d77a4349d67e518e1dd9ecb4fac079e220fa46b7a7f164e0a5::abyss_vault::withdraw<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    }

    public(friend) fun x8q<T0, T1, T2>(arg0: &0xf98f613416225e42930e0f25daacd83443abca19e9ce869ae05c657dba59f503::global_config::GlobalConfig, arg1: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::MarginManager<T0, T1>, arg2: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: 0x2::coin::Coin<T2>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0xf98f613416225e42930e0f25daacd83443abca19e9ce869ae05c657dba59f503::turbos_margin_manager::deposit_collateral<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public(friend) fun y1w<T0, T1>(arg0: &mut 0x90a75f641859f4d77a4349d67e518e1dd9ecb4fac079e220fa46b7a7f164e0a5::abyss_vault::Vault<T0, T1>, arg1: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg2: &0x90a75f641859f4d77a4349d67e518e1dd9ecb4fac079e220fa46b7a7f164e0a5::vault_registry::VaultRegistry, arg3: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg4: 0x2::coin::Coin<T1>, arg5: &0x90a75f641859f4d77a4349d67e518e1dd9ecb4fac079e220fa46b7a7f164e0a5::vault_registry::AbyssSupplierCap, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x90a75f641859f4d77a4349d67e518e1dd9ecb4fac079e220fa46b7a7f164e0a5::abyss_vault::withdraw<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    }

    public(friend) fun z1n<T0, T1>(arg0: &mut 0x90a75f641859f4d77a4349d67e518e1dd9ecb4fac079e220fa46b7a7f164e0a5::abyss_vault::Vault<T0, T1>, arg1: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg2: &0x90a75f641859f4d77a4349d67e518e1dd9ecb4fac079e220fa46b7a7f164e0a5::vault_registry::VaultRegistry, arg3: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg4: 0x2::coin::Coin<T1>, arg5: &0x90a75f641859f4d77a4349d67e518e1dd9ecb4fac079e220fa46b7a7f164e0a5::vault_registry::AbyssSupplierCap, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x90a75f641859f4d77a4349d67e518e1dd9ecb4fac079e220fa46b7a7f164e0a5::abyss_vault::withdraw<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    }

    public(friend) fun z6o<T0, T1, T2>(arg0: &0xf98f613416225e42930e0f25daacd83443abca19e9ce869ae05c657dba59f503::global_config::GlobalConfig, arg1: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::MarginManager<T0, T1>, arg2: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: 0x2::coin::Coin<T2>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0xf98f613416225e42930e0f25daacd83443abca19e9ce869ae05c657dba59f503::turbos_margin_manager::deposit_collateral<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    // decompiled from Move bytecode v6
}

