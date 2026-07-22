module 0xf66f53413b4c3ba64a8f5ec87bee081493b85e78eb05a62194d28abaadaae81::stoken_vault_routing {
    public fun attach_proxy_asset_manager<T0, T1>(arg0: &mut 0xce6e044120fc75a807ed0d6c453a532badf79fa3d889674ed6675b3c665a2b49::stoken_vault::Vault<T0, T1>, arg1: &0xce6e044120fc75a807ed0d6c453a532badf79fa3d889674ed6675b3c665a2b49::stoken_vault::AdminCap, arg2: &0xf66f53413b4c3ba64a8f5ec87bee081493b85e78eb05a62194d28abaadaae81::stoken_proxy::ProxyAssetManager<T0>, arg3: &0x2::tx_context::TxContext) {
        assert!(0xf66f53413b4c3ba64a8f5ec87bee081493b85e78eb05a62194d28abaadaae81::stoken_proxy::get_vault_id<T0>(arg2) == 0x2::object::id<0xce6e044120fc75a807ed0d6c453a532badf79fa3d889674ed6675b3c665a2b49::stoken_vault::Vault<T0, T1>>(arg0), 1);
        let v0 = 0x2::object::id<0xf66f53413b4c3ba64a8f5ec87bee081493b85e78eb05a62194d28abaadaae81::stoken_proxy::ProxyAssetManager<T0>>(arg2);
        0xce6e044120fc75a807ed0d6c453a532badf79fa3d889674ed6675b3c665a2b49::stoken_vault::attach_asset_manager_role<T0, T1>(arg0, arg1, 0x2::object::id_to_address(&v0), arg3);
    }

    public fun emergency_sweep_to_vault<T0, T1>(arg0: &mut 0xce6e044120fc75a807ed0d6c453a532badf79fa3d889674ed6675b3c665a2b49::stoken_vault::Vault<T0, T1>, arg1: &mut 0xf66f53413b4c3ba64a8f5ec87bee081493b85e78eb05a62194d28abaadaae81::stoken_proxy::ProxyAssetManager<T0>, arg2: &0xf66f53413b4c3ba64a8f5ec87bee081493b85e78eb05a62194d28abaadaae81::stoken_proxy::ProxyManagerCap, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0xf66f53413b4c3ba64a8f5ec87bee081493b85e78eb05a62194d28abaadaae81::stoken_proxy::get_vault_id<T0>(arg1) == 0x2::object::id<0xce6e044120fc75a807ed0d6c453a532badf79fa3d889674ed6675b3c665a2b49::stoken_vault::Vault<T0, T1>>(arg0), 1);
        0xce6e044120fc75a807ed0d6c453a532badf79fa3d889674ed6675b3c665a2b49::stoken_vault::credit_returned_underlying<T0, T1>(arg0, 0xf66f53413b4c3ba64a8f5ec87bee081493b85e78eb05a62194d28abaadaae81::stoken_proxy::emergency_sweep<T0>(arg1, arg2, arg3, arg4, arg5));
    }

    public fun process_deposits<T0, T1>(arg0: &mut 0xce6e044120fc75a807ed0d6c453a532badf79fa3d889674ed6675b3c665a2b49::stoken_vault::Vault<T0, T1>, arg1: &0xce6e044120fc75a807ed0d6c453a532badf79fa3d889674ed6675b3c665a2b49::stoken_vault::ProcessorCap, arg2: &mut 0xf66f53413b4c3ba64a8f5ec87bee081493b85e78eb05a62194d28abaadaae81::stoken_proxy::ProxyAssetManager<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0xf66f53413b4c3ba64a8f5ec87bee081493b85e78eb05a62194d28abaadaae81::stoken_proxy::get_vault_id<T0>(arg2) == 0x2::object::id<0xce6e044120fc75a807ed0d6c453a532badf79fa3d889674ed6675b3c665a2b49::stoken_vault::Vault<T0, T1>>(arg0), 1);
        let v0 = 0x2::object::id<0xf66f53413b4c3ba64a8f5ec87bee081493b85e78eb05a62194d28abaadaae81::stoken_proxy::ProxyAssetManager<T0>>(arg2);
        assert!(0xce6e044120fc75a807ed0d6c453a532badf79fa3d889674ed6675b3c665a2b49::stoken_vault::asset_manager_return_allowed<T0, T1>(arg0, 0x2::object::id_to_address(&v0)), 1);
        0xf66f53413b4c3ba64a8f5ec87bee081493b85e78eb05a62194d28abaadaae81::stoken_proxy::accept_underlying<T0>(arg2, 0xce6e044120fc75a807ed0d6c453a532badf79fa3d889674ed6675b3c665a2b49::stoken_vault::withdraw_idle_to_coin<T0, T1>(arg0, arg1, arg3, arg5));
    }

    public fun process_deposits_manager<T0, T1>(arg0: &mut 0xce6e044120fc75a807ed0d6c453a532badf79fa3d889674ed6675b3c665a2b49::stoken_vault::Vault<T0, T1>, arg1: &0xce6e044120fc75a807ed0d6c453a532badf79fa3d889674ed6675b3c665a2b49::stoken_vault::ManagerCap, arg2: &mut 0xf66f53413b4c3ba64a8f5ec87bee081493b85e78eb05a62194d28abaadaae81::stoken_proxy::ProxyAssetManager<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0xf66f53413b4c3ba64a8f5ec87bee081493b85e78eb05a62194d28abaadaae81::stoken_proxy::get_vault_id<T0>(arg2) == 0x2::object::id<0xce6e044120fc75a807ed0d6c453a532badf79fa3d889674ed6675b3c665a2b49::stoken_vault::Vault<T0, T1>>(arg0), 1);
        let v0 = 0x2::object::id<0xf66f53413b4c3ba64a8f5ec87bee081493b85e78eb05a62194d28abaadaae81::stoken_proxy::ProxyAssetManager<T0>>(arg2);
        assert!(0xce6e044120fc75a807ed0d6c453a532badf79fa3d889674ed6675b3c665a2b49::stoken_vault::asset_manager_return_allowed<T0, T1>(arg0, 0x2::object::id_to_address(&v0)), 1);
        0xf66f53413b4c3ba64a8f5ec87bee081493b85e78eb05a62194d28abaadaae81::stoken_proxy::accept_underlying<T0>(arg2, 0xce6e044120fc75a807ed0d6c453a532badf79fa3d889674ed6675b3c665a2b49::stoken_vault::withdraw_idle_to_coin_manager<T0, T1>(arg0, arg1, arg3, arg5));
    }

    public fun return_funds_from_proxy<T0, T1>(arg0: &mut 0xce6e044120fc75a807ed0d6c453a532badf79fa3d889674ed6675b3c665a2b49::stoken_vault::Vault<T0, T1>, arg1: &0xf66f53413b4c3ba64a8f5ec87bee081493b85e78eb05a62194d28abaadaae81::stoken_proxy::ProxyAssetManager<T0>, arg2: &0xf66f53413b4c3ba64a8f5ec87bee081493b85e78eb05a62194d28abaadaae81::stoken_proxy::ProxyProcessorCap, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert!(0xf66f53413b4c3ba64a8f5ec87bee081493b85e78eb05a62194d28abaadaae81::stoken_proxy::get_processor_cap_proxy_id(arg2) == 0x2::object::id<0xf66f53413b4c3ba64a8f5ec87bee081493b85e78eb05a62194d28abaadaae81::stoken_proxy::ProxyAssetManager<T0>>(arg1), 1);
        assert!(0xf66f53413b4c3ba64a8f5ec87bee081493b85e78eb05a62194d28abaadaae81::stoken_proxy::get_vault_id<T0>(arg1) == 0x2::object::id<0xce6e044120fc75a807ed0d6c453a532badf79fa3d889674ed6675b3c665a2b49::stoken_vault::Vault<T0, T1>>(arg0), 1);
        let v0 = 0x2::object::id<0xf66f53413b4c3ba64a8f5ec87bee081493b85e78eb05a62194d28abaadaae81::stoken_proxy::ProxyAssetManager<T0>>(arg1);
        assert!(0x2::object::id_to_address(&v0) == 0xce6e044120fc75a807ed0d6c453a532badf79fa3d889674ed6675b3c665a2b49::stoken_vault::get_asset_manager<T0, T1>(arg0), 1);
        assert!(0x2::tx_context::sender(arg5) == 0xf66f53413b4c3ba64a8f5ec87bee081493b85e78eb05a62194d28abaadaae81::stoken_proxy::get_processor<T0>(arg1), 1);
        0xce6e044120fc75a807ed0d6c453a532badf79fa3d889674ed6675b3c665a2b49::stoken_vault::credit_returned_underlying<T0, T1>(arg0, arg3);
    }

    public fun return_funds_from_proxy_manager<T0, T1>(arg0: &mut 0xce6e044120fc75a807ed0d6c453a532badf79fa3d889674ed6675b3c665a2b49::stoken_vault::Vault<T0, T1>, arg1: &0xf66f53413b4c3ba64a8f5ec87bee081493b85e78eb05a62194d28abaadaae81::stoken_proxy::ProxyAssetManager<T0>, arg2: &0xf66f53413b4c3ba64a8f5ec87bee081493b85e78eb05a62194d28abaadaae81::stoken_proxy::ProxyManagerCap, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert!(0xf66f53413b4c3ba64a8f5ec87bee081493b85e78eb05a62194d28abaadaae81::stoken_proxy::get_manager_cap_proxy_id(arg2) == 0x2::object::id<0xf66f53413b4c3ba64a8f5ec87bee081493b85e78eb05a62194d28abaadaae81::stoken_proxy::ProxyAssetManager<T0>>(arg1), 1);
        assert!(0xf66f53413b4c3ba64a8f5ec87bee081493b85e78eb05a62194d28abaadaae81::stoken_proxy::get_vault_id<T0>(arg1) == 0x2::object::id<0xce6e044120fc75a807ed0d6c453a532badf79fa3d889674ed6675b3c665a2b49::stoken_vault::Vault<T0, T1>>(arg0), 1);
        let v0 = 0x2::object::id<0xf66f53413b4c3ba64a8f5ec87bee081493b85e78eb05a62194d28abaadaae81::stoken_proxy::ProxyAssetManager<T0>>(arg1);
        assert!(0x2::object::id_to_address(&v0) == 0xce6e044120fc75a807ed0d6c453a532badf79fa3d889674ed6675b3c665a2b49::stoken_vault::get_asset_manager<T0, T1>(arg0), 1);
        assert!(0x2::tx_context::sender(arg5) == 0xf66f53413b4c3ba64a8f5ec87bee081493b85e78eb05a62194d28abaadaae81::stoken_proxy::get_manager<T0>(arg1), 1);
        0xce6e044120fc75a807ed0d6c453a532badf79fa3d889674ed6675b3c665a2b49::stoken_vault::credit_returned_underlying<T0, T1>(arg0, arg3);
    }

    // decompiled from Move bytecode v7
}

